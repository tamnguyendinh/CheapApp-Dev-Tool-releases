# CEO Plugin

> **Multi-Agent Orchestration Workflow — 1-Click MSI Install, Instant Setup, Effortless to Use.**  
> **Version:** <!-- ceo-plugin:version:start -->`2.0.6`<!-- ceo-plugin:version:end -->  
> **Language:** **English** | [Tiếng Việt](README_VN.md)

---

## What is CEO Plugin?

**CEO Plugin** is a tool and workflow that turns AI assistants in your code editors (Antigravity, Cursor, Codex, Claude Desktop) into an **Intelligent Autonomous Orchestration Engine**.

Instead of manually reminding, delegating, or repeatedly explaining context, CEO Plugin automatically assigns specialized roles to AI agents (from strategic planning and architecture specification to coding, live runtime QA, and zero-trust quality acceptance).

![CEO Plugin Orchestration Architecture](./CEO-mermaid-diagram.svg)

---

## Step 1: Installation (1-Click MSI & Done)

Simply download <!-- ceo-plugin:msi:start -->`ceo-plugin-setup-2.0.6.msi`<!-- ceo-plugin:msi:end --> and double-click to install.
- Automatically installs per-user into `%USERPROFILE%\.ceo-plugin\bin\ceo-plugin.exe` (no Administrator UAC prompt required).
- Automatically configures User `PATH` and connects MCP to all AI code editors you use (Antigravity, Cursor, Codex, Claude).
- Automatically installs the User Guides and Architecture Diagram into `%USERPROFILE%\.ceo-plugin\Guide\Guide_EN.pdf` and `CEO-mermaid-diagram.svg` (along with the Vietnamese guide PDF) and creates Desktop shortcuts:
  - **`CEO Plugin - Guide (EN)`**
  - **`CEO Plugin - Architecture Diagram`** *(alongside the Vietnamese guide shortcut)*

---

## Step 2: Standard Operating Guide

### 1. First-Time Repository Setup
When opening a repository for the first time after installation, run this initial command in the AI chat to bootstrap the project:

> `"I appoint you as CEO, load the ceo-plugin MCP to get operational instructions."`

Upon appointment, the repository is automatically initialized with CEO operational context (`AGENTS.md` and `CLAUDE.md` are rendered with full instructions to operate CEO Plugin).

### 2. Opening Subsequent CEO Sessions
For future sessions on the same repository, simply use:

> `"I appoint you as CEO, please get ready."`

### 3. Standard Operating Workflow with the System Architect (Critical)

- **Step 1 — Open the System Architect Lane & Keep CEO on Strict Silent Standby:**
  - Tell the CEO:
    > `"Open the system architect lane for me to discuss."`
  - **Strict Context-Noise Prevention Rule:** While discussing with the System Architect, instruct the CEO to remain on **absolute standby** — even if the system sends automated notifications, the CEO must remain **completely silent** to prevent context pollution.

- **Step 2 — Request a Detailed Specification Report (or SPEC):**
  - Once all architectural points are discussed and aligned, you **MUST** instruct the System Architect:
    > `"Write a detailed specification report"` *(or `"Write the SPEC"` if authoring formal SPECs)*

- **Step 3 — Codebase Cross-Check Audit (Pass 1):**
  - After the report (or SPEC) is generated, instruct the System Architect:
    > `"Re-read the codebase and check whether the report misstates any discussed architecture in a way that could cause the coder to implement it wrongly."`

- **Step 4 — Codebase Cross-Check Audit (Pass 2 & Repeat Until Zero Drift — Critical):**
  - Instruct the System Architect **at least one more time**:
    > `"Re-read the codebase and check whether the report misstates any discussed architecture in a way that could cause the coder to implement it wrongly."`
  - **Important:** Repeat this audit pass until zero discrepancies remain between the report/SPEC, the discussed architecture, and the actual codebase.

- **Step 5 — Handoff to Execution Lanes:**
  - Instruct the System Architect to send the report to the CEO and trigger the implementation lane (e.g., `"Send to CEO and request the coder lane to implement"`).
  - *(Alternatively, copy the report file link yourself and instruct the CEO directly to launch the execution pipeline.)*

---

## Step 3: Specialist Lanes Reference

| When you want to... | CLI / MCP Command | The Experience You Get |
| :--- | :--- | :--- |
| **Orchestrate Operations** | `ceo-plugin ceo` | Master session coordinator managing specialist subagent lifecycles and cross-lane handoffs. |
| **Master Project Planning** | `ceo-plugin strategic-planner` | AI automatically breaks work down into atomic steps, complete with benchmarks and codebase reality tracking across every phase. |
| **Design Architecture & Specs** | `ceo-plugin system-architect` | AI discusses with you to finalize the optimal technical solution (Mode 0) and authors detailed specification reports (Mode 1A/1B). |
| **Implement Code** | `ceo-plugin coder` | AI focuses 100% on implementing atomic, precision code strictly within the assigned Touch-Map scope. |
| **Test Live Runtime App** | `ceo-plugin qa` | AI runs the actual built application to test real user behavior, end-to-end data flows, and UI interactions. |
| **Quality Gate & Acceptance** | `ceo-plugin supervisor` | Independently audits code, diffs, and runtime evidence with zero-trust verification to ensure zero defects remain. |
| **Version Bump & Release** | `ceo-plugin release` | Single dedicated lane that inspects repo changes for `change.md`, bumps version, builds packages + SHA-256, runs `-DryRun`, pushes clean source, and publishes the release. |

---

## Clean Uninstall (100% Residue-Free)
When you no longer need the tool:
- Go to **Windows Settings > Apps > Installed apps**, find **CEO Plugin**, and click **Uninstall**.

All binaries, the `Guide` folder, all 3 Desktop shortcuts, User `PATH` entries, and IDE MCP configurations will be cleanly removed, leaving zero junk files on your PC.
