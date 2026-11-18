# CEO Plugin (Tài liệu Tiếng Việt)

> **Quy trình Điều phối Đa Tác nhân AI — Cài đặt chuẩn `.msi` 1-Click, Tự động Kết nối, Sử dụng Tức thì.**  
> <!-- ceo-plugin:version:start -->**Version:** `2.0.1`<!-- ceo-plugin:version:end -->

---

## CEO Plugin là gì?

**CEO Plugin** là công cụ và quy trình biến các trợ lý AI trong trình soạn thảo mã nguồn của bạn (Antigravity, Cursor, Codex, Claude Desktop) thành một **Hệ thống Điều phối Tự hành Thông minh**.

Thay vì phải nhắc nhở thủ công, giao việc từng bước hoặc giải thích lại ngữ cảnh nhiều lần, CEO Plugin tự động phân công đúng vai trò chuyên môn cho từng tác nhân AI (từ lập kế hoạch chiến lược, thiết kế kiến trúc, lập trình cho đến kiểm thử thực tế và nghiệm thu chất lượng Zero-Trust).

---

## Trải nghiệm Sử dụng (UX)

### Bước 1: Cài đặt (1-Click với bộ cài `.msi`)
Tải xuống bộ cài đặt chuẩn Windows <!-- ceo-plugin:msi:start -->`ceo-plugin-setup-2.0.1.msi`<!-- ceo-plugin:msi:end --> và nhấp đúp chuột để chạy.
- Tự động cài đặt theo phạm vi người dùng (`%USERPROFILE%\.ceo-plugin\bin\ceo-plugin.exe`, không yêu cầu quyền Quản trị viên UAC).
- Tự động thêm vào `PATH` và cấu hình kết nối MCP cho toàn bộ các trình soạn thảo AI bạn đang dùng (Antigravity, Cursor, Codex, Claude).
- Không cần gõ lệnh phức tạp, không cần chỉnh sửa file cấu hình thủ công.

---

### Bước 2: Khởi động AI và Chỉ huy
Khi mở bất kỳ dự án phần mềm nào, bạn chỉ cần gõ vào khung chat AI:
> *"Kích hoạt CEO điều phối dự án này"*

Hoặc mở Terminal và chạy duy nhất một lệnh:
```bash
ceo-plugin ceo
```
AI sẽ tự động nhận diện quy trình chuẩn hóa và khởi tạo ngữ cảnh làm việc.

---

### Bước 3: Gọi đúng Vai trò Chuyên môn
Bất cứ khi nào bạn hoặc AI cần thực hiện một nhiệm vụ cụ thể, chỉ cần gọi **một câu lệnh tương ứng**:

| Khi bạn muốn... | Chỉ cần chạy: | Trải nghiệm nhận được |
| :--- | :--- | :--- |
| **Lập Kế hoạch Tổng thể** | `ceo-plugin strategic-planner` | AI tự động chia nhỏ công việc thành các bước nguyên tử, kèm chỉ số đo lường (benchmark) và sổ cái đối chiếu thực tế mã nguồn qua từng giai đoạn. |
| **Thiết kế Kiến trúc & Đặc tả** | `ceo-plugin system-architect` | AI thảo luận cùng bạn để chốt phương án kỹ thuật tối ưu (Mode 0) và xuất báo cáo đặc tả kỹ thuật chi tiết (Mode 1A/1B). |
| **Thi công Mã nguồn** | `ceo-plugin coder` | AI tập trung 100% vào việc viết code chính xác, nguyên tử và tuân thủ chặt chẽ phạm vi Touch-Map được giao. |
| **Kiểm thử Thực tế (Runtime QA)** | `ceo-plugin qa` | AI chạy ứng dụng thực tế sau khi build để kiểm tra hành vi người dùng, dữ liệu đầu-cuối và tương tác giao diện. |
| **Nghiệm thu & Kiểm toán (Zero-Trust)** | `ceo-plugin supervisor` | Độc lập kiểm tra mã nguồn, git diff và bằng chứng thực thi để đảm bảo không còn bất kỳ lỗi tiềm ẩn nào. |

---

## Gỡ cài đặt Sạch sẽ (100% Không để lại Rác)
Khi không còn nhu cầu sử dụng:
- Mở **Windows Settings > Apps > Installed apps**, tìm **CEO Plugin** và nhấn **Uninstall**.

Toàn bộ file nhị phân, biến môi trường `PATH` và cấu hình MCP trong các IDE sẽ được gỡ bỏ hoàn toàn, trả lại trạng thái nguyên vẹn cho máy tính của bạn.
