# Lịch sử Thay đổi (Change Log) — CEO Plugin

Tài liệu ghi nhận toàn bộ quá trình cải tiến và phát triển của **CEO Plugin** qua từng phiên bản.

---

## [Version 2.1.2] - 2026-11-26: Tái cấu trúc Lane `release` 3 Nhánh Tự chứa (`app-desktop`, `web-vps`, `web-pc-docker`), Định danh 2 Cấp `<branch>/<name>` & Tối ưu Bộ nhớ RAM
- **Tái cấu trúc Lane `release` thành 3 Nhánh Độc lập Tự chứa (`app-desktop`, `web-vps`, `web-pc-docker`):** Tách `cmd/engine/assets/release/SKILL.md` thành lõi quy chuẩn chung (`0..99`, tự cuốn cơ số 100 tại `.99`, ma trận khóa 9 tình huống, bộ định tuyến 3 nhánh bắt buộc xác nhận với Human Owner khi mơ hồ) kết hợp 17 tài liệu tham chiếu chuẩn 2 cấp trải đều trên 3 nhánh:
  - `app-desktop`: `workflow`, `bump-version`, `build-windows`, `build-mac`, `build-linux`, `push-clean-github`, `publish-release-github` (chuẩn hóa 6 tài liệu cũ + bổ sung `workflow.md`).
  - `web-vps`: `workflow`, `bump-version`, `build-docker-vps`, `deploy-vps`, `cloudflare-compose-vps` (Git PC + GitHub Private tags + Docker `.docker.tar.gz` + SHA-256 + SCP/SSH VPS bọc Cloudflare).
  - `web-pc-docker`: `workflow`, `bump-version`, `build-docker-pc`, `deploy-pc-docker`, `cloudflare-compose-pc` (Git PC + GitHub Private tags + Docker cục bộ trên PC server cách ly + Cloudflare Tunnel).
- **Hỗ trợ Chỉ mục Tham chiếu 2 Cấp `<branch>/<name>` Toàn hệ thống (`VirtualFS`, CLI, `help`, MCP & `AGENTS.md`/`CLAUDE.md`):** Nâng cấp `internal/virtualfs` (`AssetEntry.Branch`, `canonicalRefKey`, `isValidBranchSegment`, `BuildCatalog` sắp xếp tất định theo nhánh), `cmd/engine` (`help` & `help release` phân nhóm theo nhánh), `internal/mcpserver` (59 tài nguyên `ram://`, `get_lane_reference`, `ceo_command`), và `internal/aicontext` (tự động render mục `7.1`, `7.2`, `7.3` vào `AGENTS.md`/`CLAUDE.md` khi chạy `ceo-plugin init`).
- **Chặn Fail-Closed Bí danh 1 Cấp Cũ với Gợi ý Hành động (`RemovedReferenceHint`):** Loại bỏ dứt điểm 6 bí danh phẳng cũ của lane `release` (`bump-version`, `build-windows`, `build-mac`, `build-linux`, `push-clean-github`, `publish-release-github`) và `workflow`; CLI trả mã thoát `1` (stdout rỗng, 0 ghi đĩa) và MCP trả lỗi JSON-RPC `-32602` kèm chỉ dẫn chính xác sang cú pháp 2 cấp `<branch>/<name>`.
- **Tối ưu Bộ nhớ RAM Nhúng (`< 500 KiB`) & Loại bỏ Mã dư thừa:** Thay thế cơ chế nhân bản biến thể khóa `generateRefVariants` bằng chuẩn hóa 1 khóa `O(1)` (`canonicalRefKey`), giữ mức bộ nhớ RAM lưu giữ của toàn bộ 59 tài nguyên nhúng (`430,976` byte) ở mức `~471 KiB` (`< 500 KiB` ngưỡng ngân sách gốc).
- **Đồng bộ Điều phối CEO, Đa ngôn ngữ `i18n`, `README*.md`, Bộ đôi PDF Hướng dẫn (`v2.1.2`) & 5 Bộ Kiểm thử:** Cập nhật `cmd/engine/assets/ceo/SKILL.md`, `lane-and-skill-coordination.md`, `i18n/locales/{en,vi}.json`, `README*.md`, tái tạo `Guide/Guide_VN.pdf` & `Guide/Guide_EN.pdf` gắn phiên bản `v2.1.2`, và cập nhật kiểm thử đơn vị + race cho toàn bộ 5 gói liên quan.

---

## [Version 2.1.1] - 2026-11-25: Tách Lane `engineer` Độc lập, Chuẩn hóa `system-architect`, Loại bỏ `architect`/Legacy, Staging Cục bộ 2 Pha & Khóa Phiên bản `0..99` + Tên gói Windows MSI Chuẩn OS
- **Tách Độc lập Lane `engineer` (`ceo-plugin engineer`) khỏi `system-architect` Chiến lược:** Bổ sung kỹ năng đơn tệp tiếng Việt `engineer` với cơ chế CEO kích hoạt theo ngữ cảnh khi cần xử lý kỹ thuật chuyên sâu, đồng thời áp dụng quy định cấm tuyệt đối trả `FAST BLOCK`/`BLOCKED` vì lý do kỹ thuật.
- **Nâng cấp `system-architect` với Quy tắc 3 Câu hỏi Nguyên lý Đầu tiên & Luật Cập nhật Chiến lược Tại chỗ:** Bổ sung bộ 3 câu hỏi First-Principles (`Input -> Output -> Problem Solved`) và luật cập nhật tại chỗ (In-Place Update) cho tài liệu kiến trúc chiến lược, đồng thời bảo toàn nguyên vẹn chuỗi báo cáo gắn dấu thời gian liên tục cho các lane thực thi.
- **Loại bỏ Dứt điểm Vai trò/Bí danh `architect` Cũ:** Xóa bỏ hoàn toàn vai trò/alias `architect` đã lỗi thời trên toàn bộ CLI, trợ giúp (`help`), hệ thống tệp ảo (VirtualFS) và MCP Server, thay thế bằng hướng dẫn phân tách rõ ràng giữa `system-architect` và `engineer`.
- **Dọn sạch 100% Quy tắc & Mã nguồn Legacy (`anvien` / `anvien-ceo-plugin`):** Loại bỏ dứt điểm quy tắc `anvien` trong quy trình vận hành (`6 -> 5` điều cấm tuyệt đối), xóa bỏ cấu hình loại trừ `.anvien/` và toàn bộ mã nguồn runtime/MCP/trình cài đặt tương thích cũ `anvien-ceo-plugin`.
- **Đồng bộ Trực quan, Đa ngôn ngữ `i18n`, `README` & Bộ đôi PDF Hướng dẫn (`v2.1.1`):** Cập nhật đồng nhất sơ đồ quy trình `CEO-mermaid-diagram.svg`, ảnh Ma trận Đội hình `CEO-EN.png` (bổ sung `1. ENGINEER LANE`), hệ thống bản địa hóa 7 lane trong `i18n`/`README*.md`, và tái tạo bộ đôi tài liệu hướng dẫn PDF Vector song ngữ `Guide/Guide_VN.pdf` & `Guide/Guide_EN.pdf`.
- **Quy trình Staging Cục bộ 2 Pha trên `dist/bin/`:** Nâng cấp `scripts/build_windows.ps1` (bổ sung cờ `-Clean` tường minh và bảo toàn các gói anh em Linux/macOS cùng phiên bản) kết hợp `updater/publish_release_github.ps1` theo quy trình 2 pha (`-StageOnly` build & kiểm chứng cục bộ trước khi chạm vào repo phát hành -> `-SkipBuild` xuất bản nguyên tử).
- **Hiến pháp Release & Cổng Khóa Phiên bản `0..99`, Chống Bypass 2 Nguồn & Tên gói Windows MSI Đồng bộ OS (`M1`):** Áp dụng chuẩn SemVer `0..99` nghiêm ngặt với tự cuốn cơ số 100 tại `.99`, khóa tăng tuần tự `+1` mặc định (chỉ cho phép nhảy số qua cờ `-AllowVersionJump` khi có chỉ thị trực tiếp của Owner), Cổng Chống Bypass 2 nguồn (`change.md` + GitHub `releases/latest`), và chuẩn hóa tên gói cài đặt Windows MSI theo cấu trúc đồng bộ hệ điều hành `ceo-plugin-2.1.1-windows-amd64.msi` (thay thế dứt điểm định dạng cũ `ceo-plugin-setup-<Version>.msi`).
- **Lưu ý Nâng cấp cho Người dùng Windows (`<= v2.1.0`):** Do chuyển đổi tên tệp gói cài đặt sang chuẩn đồng bộ OS (`M1`), người dùng Windows đang chạy phiên bản `<= v2.1.0` vui lòng tải và chạy trực tiếp `ceo-plugin-2.1.1-windows-amd64.msi` một lần; từ `v2.1.1` trở đi cơ chế tự động cập nhật sẽ tiếp tục hoạt động liền mạch.

---

## [Version 2.1.0] - 2026-11-23: Hỗ trợ Đa nền tảng macOS & Linux, Quy trình Phát hành Option A1 (5/5 Nền tảng) & Ma trận Tác chiến `CEO-EN.png`
- **Hỗ trợ Đa nền tảng Hoàn chỉnh cho macOS (`arm64`, `amd64`) & Linux (`amd64`, `arm64`):** Triển khai đồng bộ lớp adapter hệ điều hành đa nền tảng (khóa tiến trình `flock`, chuẩn đường dẫn Unix/macOS, nhận diện ngữ cảnh IDE đa hệ điều hành và chính sách Claude Code CLI `C2`), ra mắt trình cài đặt POSIX `install.sh` chuẩn LF kèm kiểm tra chống `404` và xác thực `SHA-256` từ `checksums.txt` trước khi tải, đồng thời tích hợp bộ lệnh quản trị vòng đời `ceo-plugin install`, `ceo-plugin uninstall` và `ceo-plugin update`.
- **Tự động Cập nhật Đa nền tảng (Cross-Platform Auto-Update Parity):** Mở rộng hệ thống tự động cập nhật sang macOS và Linux với hộp thoại bản địa (`osascript` trên macOS, `zenity`/`kdialog` trên Linux kèm cơ chế dự phòng headless) và quy trình nâng cấp Unix nguyên tử 5 bước có tự động khôi phục (rollback) khi có sự cố.
- **Quy trình Phát hành Đa Hệ điều hành Option A1 PC-First (`5/5` Nền tảng):** Bổ sung `scripts/build_linux.ps1` (build Linux `amd64`/`arm64` qua Docker `golang:1.26-bookworm` non-root `builder`), `scripts/build_MAC.ps1` kết hợp `.github/workflows/build-macos.yml` (1 runner `macos-latest` duy nhất, `lipo` + ad-hoc `codesign`, zero-secret) và hợp nhất vào `updater/publish_release_github.ps1` để tự động đóng gói đủ 5 nền tảng, tạo `checksums.txt` thống nhất (6 dòng) và xuất bản nguyên tử 8 asset trên GitHub Releases.
- **Tích hợp Ma trận Điều phối `CEO-EN.png` trên README, Tài liệu PDF & Cây Zero-Code Công khai:** Bổ sung hình ảnh Ma trận Đội hình Tác chiến (`CEO-EN.png`) vào `README.md`, `README_EN.md`, `README_VN.md`, nhúng trực tiếp vào tài liệu hướng dẫn song ngữ `Guide/Guide_EN.pdf` & `Guide/Guide_VN.pdf` (mã hóa JPEG `/DCTDecode` trong bộ nhớ qua `scripts/generate_guides.py`, giữ nguyên tệp gốc) và mở rộng danh sách trắng cây phát hành Zero-Code `main` lên đúng 8 tệp (`CEO-EN.png`, `CEO-mermaid-diagram.svg`, `LICENSE`, `README*.md`, `change.md`, `install.sh`).

---

## [Version 2.0.6] - 2026-11-19: Sửa lỗi Hiển thị Sơ đồ SVG & Dòng Version CommonMark trên GitHub Release Công khai
- **Bổ sung `CEO-mermaid-diagram.svg` vào Cây Phát hành Zero-Code Công khai (`updater/publish_release_github.ps1`):** Đưa tệp sơ đồ quy trình `CEO-mermaid-diagram.svg` vào danh sách trắng `$ZeroCodeAllowedFiles` (nâng từ 5 lên 6 tệp) kèm kiểm tra số lượng tệp động, khắc phục triệt để lỗi ảnh sơ đồ bị hỏng (`404`) trên trang `README` công khai của `tamnguyendinh/CheapApp-Dev-Tool-releases`.
- **Sửa lỗi Render CommonMark Dòng Phiên bản (`README*.md` & `scripts/build_windows.ps1`):** Chuyển tiền tố `**Version:**` ra bên ngoài thẻ chú thích HTML (`<!-- ceo-plugin:version:start -->`) trong `README.md`, `README_EN.md`, `README_VN.md`, `scripts/build_windows.ps1` và tài liệu mẫu `cmd/engine/assets/release/references/build-windows.md`, đảm bảo GitHub hiển thị chuẩn thẻ nhấn mạnh `<strong>Version:</strong>` cùng mã phiên bản thay vì hiển thị chuỗi thô `**Version:**`.
- **Đồng bộ Tài liệu Tham chiếu `release` & Kiểm thử Đơn vị:** Cập nhật hướng dẫn bổ sung asset sơ đồ tĩnh trong `cmd/engine/assets/release/references/publish-release-github.md` và đồng bộ kích thước byte mong đợi trong `internal/virtualfs/virtualfs_test.go` và `cmd/engine/main_test.go`.

---

## [Version 2.0.5] - 2026-11-19: Kỹ năng Phát hành Chuẩn hóa (`release` Lane), Hướng dẫn Kiến trúc Mode 1B & Đồng bộ Tài liệu
- **Kỹ năng Vai trò Phát hành Độc lập (`release` Lane):** Tích hợp kỹ năng vai trò `release` chuẩn hóa cho quy trình đóng gói và phát hành khép kín (`cmd/engine/assets/release/SKILL.md`), hỗ trợ đầy đủ bộ tài liệu tham chiếu mẫu đa nền tảng (`bump-version.md`, `build-windows.md`, `build-mac.md`, `build-linux.md`, `push-clean-github.md`, `publish-release-github.md`) trong `references/`.
- **Đặc tả Kiến trúc Mode 1B cho Release Lane:** Bổ sung báo cáo kiến trúc hệ thống chuẩn Mode 1B (`reports/system-architect/...`) xác định ranh giới vận hành, giao thức phát hành zero-code, quy chuẩn cô lập kiểm thử và nguyên tắc bảo vệ kho mã nguồn.
- **Tích hợp CLI Command & Tra cứu Trợ giúp Hệ thống:** Đăng ký vai trò `release` vào hệ thống lệnh CLI của `ceo-plugin`, bổ sung kiểm thử đơn vị bao phủ toàn diện cho `cmd/engine`, MCP server và hệ thống tệp ảo `internal/virtualfs`.
- **Cập nhật & Đồng bộ Tài liệu Hướng dẫn Song ngữ:** Tái tạo và đồng bộ hóa tài liệu hướng dẫn định dạng PDF Vector song ngữ (`Guide_VN.pdf` & `Guide_EN.pdf`), sơ đồ quy trình trực quan SVG sáng chuẩn quốc tế, cùng các tài liệu `README.md`, `README_EN.md` và `README_VN.md`.

---

## [Version 2.0.4] - 2026-11-18: Module Đa ngôn ngữ `i18n`, Sơ đồ Quy trình 100% Tiếng Anh, Bộ 3 Lối tắt MSI Desktop & Tối ưu Giao diện Popup Win32
- **Module Đa ngôn ngữ Tập trung (`i18n`):** Tích hợp gói bản địa hóa `i18n` hỗ trợ tiếng Anh (`en`) và tiếng Việt (`vi`), tự động nhận diện ngôn ngữ hệ thống qua Windows UI Language (`GetUserDefaultUILanguage`) và biến môi trường `LANG`/`LC_ALL`.
- **Sơ đồ Quy trình Chuẩn hóa 100% Tiếng Anh & Giao diện Sáng (`CEO-mermaid-diagram.svg`):** Chuẩn hóa toàn bộ sơ đồ quy trình sang tiếng Anh quốc tế, tông màu sáng hiện đại, nhúng phông chữ Inter chuẩn xác, căn chỉnh padding và bo viền hộp tránh tràn chữ.
- **Bộ 3 Lối tắt Desktop Chuẩn Win32 COM trong Gói Cài đặt MSI:** Tích hợp tự động tạo 3 lối tắt trên Desktop: `CEO Plugin - Hướng dẫn (VN).lnk`, `CEO Plugin - Guide (EN).lnk`, và `CEO Plugin - Sơ đồ Quy trình (Workflow Diagram).lnk`.
- **Tối ưu hóa Giao diện Thông báo Win32 Popup & Nút Đóng Thủ công:** Cho phép đóng thủ công thẻ thông báo cài đặt MSI trực tiếp ở chế độ tương tác qua nút `X`, đảm bảo trải nghiệm người dùng linh hoạt và không bị cưỡng chế đóng tự động khi chưa kịp đọc.

---

## [Version 2.0.3] - 2026-11-18: Tài liệu Hướng dẫn Sử dụng PDF Vector Song ngữ (`Guide_VN.pdf` & `Guide_EN.pdf`), Đóng gói MSI, Lối tắt Desktop Win32 COM & Đồng bộ README
- **Tài liệu Hướng dẫn Sử dụng PDF Vector Song ngữ (`Guide\Guide_VN.pdf` & `Guide\Guide_EN.pdf`):** Bổ sung bộ đôi tài liệu hướng dẫn chuẩn doanh nghiệp song ngữ Việt - Anh dưới dạng PDF Vector sắc nét (hỗ trợ bôi đen/sao chép văn bản, tìm kiếm `Ctrl+F`, nhúng phông chữ `/FontDescriptor` + bảng ánh xạ `/ToUnicode` CMap và chuẩn hóa siêu dữ liệu `/CreationDate`, `/ModDate` tất định qua `scripts/generate_guides.py`).
- **Đóng gói tự động vào bộ cài Windows `.msi` (`%USERPROFILE%\.ceo-plugin\Guide\`):** Tích hợp thành phần WiX v5 `Component Id="UserGuideDocs"` trong `installer/ceo-plugin.wxs` (100% mã nguồn ASCII tránh lỗi `WIX0311`) kèm cổng kiểm tra toàn vẹn header `%PDF-1.` trong `scripts/build_windows.ps1`, tự động trích xuất cả 2 file PDF vào `%USERPROFILE%\.ceo-plugin\Guide\` khi cài đặt/cập nhật và dọn sạch khi gỡ cài đặt.
- **Tự động tạo & gỡ bỏ Lối tắt Desktop chuẩn Win32 COM (`IShellLinkW` / `IPersistFile` UTF-16):** Tích hợp trực tiếp vào `cmd/msihook` cơ chế khởi tạo 2 lối tắt trên màn hình nền (`CEO Plugin - Hướng dẫn (VN).lnk` và `CEO Plugin - Guide (EN).lnk`) bằng giao diện Win32 COM `IShellLinkW` gốc với chuỗi UTF-16LE bảo toàn tuyệt đối dấu tiếng Việt, tự động cập nhật khi nâng cấp và xóa sạch khi gỡ cài đặt (đảm bảo cô lập 100% thư mục Desktop máy chủ khi chạy kiểm thử đơn vị).
- **Đồng bộ hóa toàn diện `README.md`, `README_EN.md` & `README_VN.md`:** Chuẩn hóa quy trình vận hành chuẩn 3 phần / 5 bước (Thiết lập kho mã nguồn lần đầu, Khởi tạo các phiên CEO tiếp theo, và Quy trình 5 bước làm việc với System Architect kèm mẫu câu lệnh đối chiếu mã nguồn thực tế nhiều vòng) đồng nhất giữa 3 tệp README và bộ đôi PDF hướng dẫn.

---

## [Version 2.0.2] - 2026-11-18: Module `internal/popupui` Độc lập & Giao diện Thẻ Thông báo Win32 Hiện đại (Auto-Update + Cài đặt MSI Trực tiếp)
- **Tách biệt kiến trúc module giao diện `internal/popupui`:** Chuyển toàn bộ logic hiển thị cửa sổ thông báo sang gói độc lập `internal/popupui` với cơ chế khởi tạo lười (`sync.Once`) cho các thư viện hệ thống (`user32.dll`, `gdi32.dll`, `kernel32.dll`, `dwmapi.dll`), đảm bảo không phát sinh chi phí bộ nhớ khi chạy các lệnh CLI/MCP thông thường.
- **Giao diện Thẻ Thông báo Win32 Vẽ tùy chỉnh Hiện đại (Modern Custom-Drawn Win32 Notification Card):** Nâng cấp toàn diện giao diện thông báo với kỹ thuật vẽ đệm kép chống nháy (`Double-Buffered GDI` + `WS_CLIPCHILDREN`), hỗ trợ độ phân giải cao đa màn hình (`Per-Monitor High-DPI v2`), bo góc cửa sổ chuẩn Windows 11 (`DWMWA_WINDOW_CORNER_PREFERENCE`), hệ thống 5 cấp phông chữ `Segoe UI` ClearType, biểu tượng ứng dụng nhúng trực tiếp (`IDI_ICON1`), nút `UPDATE` bo tròn có hiệu ứng rê chuột (`Hover`), biểu tượng dấu tích xanh ngọc lục bảo và thanh tiến trình đếm ngược 4 giây mượt mà (chu kỳ làm mới `40ms`).
- **Thông báo hoàn tất khi cài đặt trực tiếp bộ cài `.msi`:** Khi người dùng chạy trực tiếp file `ceo-plugin-setup-2.0.2.msi` ở chế độ giao diện tương tác (`UILevel >= 3`), hệ thống tự động hiển thị thẻ thông báo xác nhận cài đặt/cập nhật thành công ở Trạng thái 2 và tự động đóng sau 4 giây (trong khi chế độ nâng cấp ngầm `/qn` hoàn toàn không làm phiền người dùng).

---

## [Version 2.0.1] - 2026-11-18: Tự động Cập nhật (Auto-Update), Nâng cấp MSI Live-Safe & Giao diện Popup Win32
- **Hệ thống Tự động Cập nhật 2 pha (2-Phase Staged Auto-Update):** Tự động truy vấn bản phát hành mới nhất trên GitHub Releases (`CheapApp-Dev-Tool-releases`), tải ngầm bộ cài `.msi` vào vùng đệm tạm thời (`.part`) và đối chiếu nghiêm ngặt mã băm `SHA-256` từ `checksums.txt` trước khi kích hoạt thông báo cập nhật.
- **Nâng cấp MSI trực tiếp không cần tắt IDE (Live-Safe MSI Upgrade qua `RetireRunningEngine`):** Cơ chế tách nóng nhị phân đang chạy (`MoveFileEx` sang `.old` kết hợp sao chép hoàn trả tức thì) giúp gỡ bỏ hoàn toàn khóa tiến trình Windows (`ERROR_SHARING_VIOLATION`) và cho phép nâng cấp `.msi` ngầm (`/qn /norestart`) ngay trong lúc các IDE (Antigravity, Cursor, Codex, Claude) đang mở phiên MCP.
- **Chu kỳ kiểm tra thông minh (1 giờ định kỳ + Mỗi lần khởi động IDE):** Tự động kiểm tra bản cập nhật mới ngay khi mở IDE (`initialized` MCP handshake với chống dội 15 giây) và định kỳ mỗi 1 giờ hoạt động; nếu người dùng bấm `X` đóng thông báo, hệ thống tự động nhắc lại sau đúng 1 giờ.
- **Giao diện Popup Win32 Bản địa 2 Trạng thái (Native Win32 2-State Popup UI):** Cửa sổ thông báo gọn nhẹ cấp hệ điều hành với nút `UPDATE` duy nhất; khi nhấn cập nhật, nút `UPDATE` lập tức ẩn đi, chuyển thông điệp hoàn tất ngay trên cùng cửa sổ sau khi nâng cấp xong và tự động đóng sau 4 giây.

---

## [Version 2.0.0] - 2026-11-18: Chuẩn hóa Bộ cài Windows `.msi` & Thương hiệu `CEO Plugin`
- **Chuẩn hóa bộ cài đặt Windows `.msi` duy nhất:** Chuyển đổi hoàn toàn sang bộ cài chuẩn Windows Installer Per-User (`ceo-plugin-setup-2.0.0.msi` đóng gói bằng WiX v5), thay thế vĩnh viễn các file cài đặt/gỡ cài đặt `.exe` rời rạc trước đây.
- **Tích hợp Windows Settings > Apps duy nhất:** Đăng ký chuẩn xác một mục duy nhất trong **Windows Settings > Apps > Installed apps** kèm biểu tượng đa độ phân giải (`app.ico`), hỗ trợ nâng cấp trực tiếp (`MajorUpgrade`) giữ nguyên cấu hình IDE MCP và tự động dọn sạch khóa Registry/file gỡ cài đặt thế hệ cũ.
- **Đổi tên và chuẩn hóa toàn diện hệ sinh thái `CEO Plugin`:** Đồng bộ lệnh CLI (`ceo-plugin <lane>`), binary chính (`~/.ceo-plugin/bin/ceo-plugin.exe`), Go module (`module ceo-plugin`), cấu hình MCP Server trên 4 IDE (Antigravity, Cursor, Codex, Claude) và thẻ ngữ cảnh AI (`<!-- ceo-plugin:start -->`).
- **Chuẩn hóa quy trình Build, Quản lý Phiên bản & Phát hành Zero-Code:** Hợp nhất quy trình build vào `scripts/build_windows.ps1`, tự động hóa nâng phiên bản qua `scripts/bump_version.ps1` và xuất bản bản phát hành công khai kèm kiểm tra toàn vẹn `SHA-256` (`checksums.txt`).

---

## [Version 1.5.0] - 2026-10-26: Nạp Kỹ năng Trực tiếp qua Bộ nhớ (In-Memory Runtime Streaming)
- **Nạp trọn gói thư mục kỹ năng:** Khi chạy lệnh của bất kỳ vai trò nào (`ceo-plugin qa`, `ceo-plugin supervisor`...), công cụ nạp trọn vẹn cả kỹ năng cốt lõi (`SKILL.md`) cùng toàn bộ các tài liệu hướng dẫn chuyên sâu (`references/`) hoặc biểu mẫu (`templates/`) qua luồng dữ liệu màn hình (Stdout Pipe).
- **Bảo mật bí mật công nghệ:** Dữ liệu kỹ năng được nạp thẳng vào bộ nhớ RAM của AI, tuyệt đối không tạo thêm file rác trên ổ cứng máy tính.
- **Khóa quyền tự chủ cho AI cấp dưới:** Quy định rõ ràng trong hợp đồng: Subagent Lane tự chạy lệnh nạp kỹ năng của chính mình, giảm tải tối đa bộ nhớ ngữ cảnh cho CEO.
- **Dọn sạch kho lưu trữ Git:** Quy tụ toàn bộ file nhị phân vào thư mục `dist/bin/` và đưa vào `.gitignore`, giữ kho mã nguồn dự án luôn sạch sẽ.

---

## [Version 1.4.0] - 2026-10-26: Chuẩn hóa Quốc tế Bảng Hướng dẫn Lệnh
- **Bảng điều hướng 2 cột chuẩn quốc tế:** Tối ưu hóa bảng "Command Selection Guide" sang 100% tiếng Anh súc tích (`When you need to... | Use command`) để các mô hình ngôn ngữ lớn (LLM) phân tích cú pháp nhanh hơn và tiết kiệm token.
- **Che giấu chi tiết nội bộ:** Loại bỏ cột mô tả chi tiết file cài đặt để giữ giao diện bảng lệnh gọn gàng và bảo mật.

---

## [Version 1.3.0] - 2026-10-26: Tự động Đồng bộ Ngữ cảnh AI
- **Tự động cập nhật `AGENTS.md` & `CLAUDE.md`:** Mỗi khi chạy bất kỳ câu lệnh nào của công cụ, bảng hướng dẫn chọn vai trò sẽ tự động được tiêm hoặc cập nhật mới nhất vào các file cấu hình AI gốc của kho mã nguồn.
- **Tách bạch quy chế giám sát:** Tách riêng quy chế chờ lệnh (Standby) và bộ đếm nhịp định kỳ (Liveness Timer Heartbeat) cho CEO điều phối.

---

## [Version 1.2.0] - 2026-10-26: Bề mặt Lệnh CLI Chuyên môn & Tự nhận diện Môi trường
- **Hỗ trợ đầy đủ 8 vai trò chuyên môn:** Bổ sung các lệnh dòng lệnh trực tiếp cho: `ceo`, `system-architect`, `architect`, `coder`, `qa`, `supervisor`, `mechanical-planner`, `strategic-planner`.
- **Tự động nhận diện IDE:** Tự động phát hiện môi trường soạn thảo đang chạy (Google Antigravity, Codex App, Cursor) để đưa ra chỉ dẫn khởi tạo tác nhân phù hợp nhất.

---

## [Version 1.1.0] - 2026-10-26: Bộ 3 Nhị phân Độc lập & Đăng ký Windows Apps
- **Tách biệt 3 chức năng nhị phân:**
  1. Lõi Engine CLI & MCP Server.
  2. Trình cài đặt 1-Click All-in-One (`setup.exe`).
  3. Trình gỡ cài đặt chuyên biệt (`uninstall.exe`).
- **Tự động thêm vào PATH:** Người dùng và AI có thể gọi lệnh từ bất kỳ thư mục hay ổ đĩa nào trong máy tính.
- **Tích hợp sâu Windows Apps:** Đăng ký trực tiếp vào hệ thống quản lý ứng dụng của Windows (Settings > Apps > Installed apps) để người dùng có thể gỡ bỏ nhanh chóng.

---

## [Version 1.0.0] - 2026-10-25: Bản Khởi tạo Lõi Điều phối
- **Đóng gói nhị phân độc lập:** Biên dịch mã máy nhị phân chạy trực tiếp trên Windows.
- **Tích hợp MCP Server Stdio:** Hỗ trợ kết nối chuẩn Model Context Protocol (MCP) qua luồng Stdio cho các trợ lý lập trình AI hàng đầu.
