# Lịch sử Thay đổi (Change Log) — CEO Plugin

Tài liệu ghi nhận toàn bộ quá trình cải tiến và phát triển của **CEO Plugin** qua từng phiên bản.

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
