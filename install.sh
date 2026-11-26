#!/bin/sh
set -eu

REPO="${CEO_PLUGIN_REPO:-tamnguyendinh/CheapApp-Dev-Tool-releases}"
REQ_VERSION="${CEO_PLUGIN_VERSION:-latest}"
DOWNLOAD_BASE_URL="${CEO_PLUGIN_DOWNLOAD_BASE_URL:-}"
WORK_DIR=""

log() {
    printf '%s\n' "$*" >&2
}

die() {
    printf 'Error: %s\n' "$*" >&2
    exit 1
}

require_cmd() {
    if ! command -v "$1" >/dev/null 2>&1; then
        die "Required command '$1' was not found in PATH."
    fi
}

cleanup() {
    if [ -n "${WORK_DIR:-}" ] && [ -d "$WORK_DIR" ]; then
        rm -rf "$WORK_DIR"
    fi
}

detect_os() {
    uname_s="$(uname -s)"
    case "$uname_s" in
        Darwin)
            printf '%s\n' "darwin"
            ;;
        Linux)
            printf '%s\n' "linux"
            ;;
        *)
            die "Unsupported operating system: ${uname_s}. Supported platforms: macOS (darwin) and Linux (linux)."
            ;;
    esac
}

detect_arch() {
    target_os="$1"
    uname_m="$(uname -m)"
    case "$uname_m" in
        x86_64|amd64)
            if [ "$target_os" = "darwin" ] && command -v sysctl >/dev/null 2>&1; then
                arm64_cap="$(sysctl -n hw.optional.arm64 2>/dev/null || printf '0')"
                if [ "$arm64_cap" = "1" ]; then
                    log "Detected Apple Silicon running under Rosetta 2; selecting darwin/arm64."
                    printf '%s\n' "arm64"
                    return 0
                fi
            fi
            printf '%s\n' "amd64"
            ;;
        arm64|aarch64)
            printf '%s\n' "arm64"
            ;;
        *)
            die "Unsupported CPU architecture: ${uname_m}. Supported architectures: amd64 (x86_64) and arm64 (aarch64)."
            ;;
    esac
}

validate_semver() {
    ver="$1"
    case "$ver" in
        ""|*[!0-9.]*|.*|*.|*..*)
            return 1
            ;;
        *.*.*)
            # Ensure exactly 3 numeric dot-separated segments (X.Y.Z)
            rest="${ver#*.}"
            case "$rest" in
                *.*.*)
                    return 1
                    ;;
                *.*)
                    return 0
                    ;;
                *)
                    return 1
                    ;;
            esac
            ;;
        *)
            return 1
            ;;
    esac
}

resolve_version() {
    if [ "$REQ_VERSION" != "latest" ]; then
        ver="${REQ_VERSION#v}"
        if ! validate_semver "$ver"; then
            die "Invalid CEO_PLUGIN_VERSION '${REQ_VERSION}'. Expected strict SemVer X.Y.Z (or 'latest')."
        fi
        printf '%s\n' "$ver"
        return 0
    fi

    tag=""
    effective_url="$(curl -fsSLI -o /dev/null -w '%{url_effective}' "https://github.com/${REPO}/releases/latest" 2>/dev/null || true)"
    case "$effective_url" in
        */releases/tag/*)
            tag="${effective_url##*/tag/}"
            tag="${tag%%\?*}"
            tag="${tag%%#*}"
            ;;
    esac

    if [ -z "$tag" ]; then
        api_json="$(curl -fsSL -H 'Accept: application/vnd.github+json' "https://api.github.com/repos/${REPO}/releases/latest" 2>/dev/null || true)"
        if [ -n "$api_json" ]; then
            tag="$(printf '%s\n' "$api_json" | sed -n 's/.*"tag_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | sed -n '1p')"
        fi
    fi

    if [ -z "$tag" ]; then
        die "Could not resolve latest release version from https://github.com/${REPO}/releases/latest."
    fi

    ver="${tag#v}"
    if ! validate_semver "$ver"; then
        die "Resolved release tag '${tag}' is not a valid SemVer X.Y.Z version."
    fi
    printf '%s\n' "$ver"
}

lookup_expected_sha256() {
    checksums_file="$1"
    expected_name="$2"
    tr -d '\r' < "$checksums_file" | {
        while read -r cand_hash cand_name _ || [ -n "${cand_hash:-}" ]; do
            case "${cand_hash:-}" in
                ""|\#*)
                    continue
                    ;;
            esac
            if [ -z "${cand_name:-}" ]; then
                continue
            fi
            cand_name="${cand_name#\*}"
            if [ "$cand_name" = "$expected_name" ]; then
                printf '%s\n' "$cand_hash"
                exit 0
            fi
        done
        exit 1
    }
}

verify_sha256() {
    target_file="$1"
    expected_sha="$(printf '%s' "$2" | tr 'A-F' 'a-f')"

    case "$expected_sha" in
        *[!0-9a-f]*)
            die "Invalid SHA-256 format in checksums.txt: '${expected_sha}'."
            ;;
    esac
    if [ "${#expected_sha}" -ne 64 ]; then
        die "Invalid SHA-256 length in checksums.txt (expected 64 hex chars, got ${#expected_sha})."
    fi

    if command -v sha256sum >/dev/null 2>&1; then
        actual_sha="$(sha256sum "$target_file" | { read -r h _; printf '%s' "$h"; })"
    elif command -v shasum >/dev/null 2>&1; then
        actual_sha="$(shasum -a 256 "$target_file" | { read -r h _; printf '%s' "$h"; })"
    else
        die "Neither sha256sum nor shasum was found; cannot verify SHA-256 checksum."
    fi

    actual_sha="$(printf '%s' "$actual_sha" | tr 'A-F' 'a-f')"
    if [ "$actual_sha" != "$expected_sha" ]; then
        die "SHA-256 checksum mismatch for $(basename "$target_file"): expected ${expected_sha}, got ${actual_sha}."
    fi
}

main() {
    require_cmd curl
    require_cmd tar
    require_cmd mktemp
    require_cmd tr
    require_cmd sed

    OS="$(detect_os)"
    ARCH="$(detect_arch "$OS")"
    VERSION="$(resolve_version)"
    ASSET_NAME="ceo-plugin-${VERSION}-${OS}-${ARCH}.tar.gz"

    if [ -n "$DOWNLOAD_BASE_URL" ]; then
        BASE_URL="${DOWNLOAD_BASE_URL%/}"
    else
        BASE_URL="https://github.com/${REPO}/releases/download/v${VERSION}"
    fi
    CHECKSUMS_URL="${BASE_URL}/checksums.txt"
    ARCHIVE_URL="${BASE_URL}/${ASSET_NAME}"

    WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/ceo-plugin-install.XXXXXX")"
    trap cleanup EXIT INT TERM

    log "Fetching checksums for CEO Plugin v${VERSION} (${OS}/${ARCH})..."
    CHECKSUMS_FILE="${WORK_DIR}/checksums.txt"
    if ! curl -fsSL "$CHECKSUMS_URL" -o "$CHECKSUMS_FILE"; then
        die "Failed to download checksums.txt from ${CHECKSUMS_URL}."
    fi

    EXPECTED_SHA="$(lookup_expected_sha256 "$CHECKSUMS_FILE" "$ASSET_NAME" || true)"
    if [ -z "$EXPECTED_SHA" ]; then
        die "Release v${VERSION} does not include a prebuilt package for ${OS}/${ARCH} (${ASSET_NAME}). Check https://github.com/${REPO}/releases/tag/v${VERSION} or specify another version with CEO_PLUGIN_VERSION=X.Y.Z."
    fi

    log "Downloading ${ASSET_NAME}..."
    ARCHIVE_FILE="${WORK_DIR}/${ASSET_NAME}"
    if ! curl -fsSL "$ARCHIVE_URL" -o "$ARCHIVE_FILE"; then
        die "Failed to download ${ASSET_NAME} from ${ARCHIVE_URL}."
    fi

    verify_sha256 "$ARCHIVE_FILE" "$EXPECTED_SHA"
    log "SHA-256 checksum verified."

    EXTRACT_DIR="${WORK_DIR}/extract"
    mkdir -p "$EXTRACT_DIR"
    tar -xzf "$ARCHIVE_FILE" -C "$EXTRACT_DIR"

    ENGINE_BIN="${EXTRACT_DIR}/ceo-plugin"
    if [ ! -f "$ENGINE_BIN" ]; then
        die "Archive ${ASSET_NAME} did not contain expected 'ceo-plugin' binary."
    fi
    chmod 0755 "$ENGINE_BIN"

    if [ "$OS" = "darwin" ] && command -v xattr >/dev/null 2>&1; then
        xattr -dr com.apple.quarantine "$EXTRACT_DIR" 2>/dev/null || true
    fi

    log "Running CEO Plugin installer..."
    "$ENGINE_BIN" install --source-dir="$EXTRACT_DIR" "$@"
}

main "$@"
