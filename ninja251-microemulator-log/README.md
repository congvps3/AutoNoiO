# Ninja 251 — MICRO_NST PC LOG v3

Sửa lỗi lấy màn hình khi MIDletBridge không tìm thấy đăng ký MIDlet đang khởi động.
Bản v3 giữ nguyên tên và cấu trúc startApp; chỉ thay lời gọi lấy Display bằng
helper. Helper chỉ khôi phục liên kết khi context hiện hành trỏ đúng cùng MIDlet;
không gán một MIDlet khác vào context. Mốc UI_READY ghi sau khi paint trả về.

## Chạy thử

1. Đóng tất cả cửa sổ giả lập cũ. Giải nén đầy đủ ZIP v3 vào một thư mục mới.
2. Chép MICRO_NST.jar của bạn vào đó. Giữ tệp phụ trợ của giả lập nếu có;
   không tự tạo lib. Bộ tải không bao gồm giả lập hay Java.
3. Chạy CHAY_GHI_LOG.cmd. Giữ NST_TRACE_CHECK.jar cùng thư mục. Bộ chạy kiểm tra
   loader/ghi tệp trước; nếu thất bại, gửi hai log, chưa cần thử đăng ký.
4. Sau thông báo KIEM TRA DA DAT, giả lập mở ở launcher. Bản này không tự nạp
   hoặc tự Start game. Vào menu File, chọn mở 251_Love_Atun_PC_LOG_v3.jar.
5. Chọn đúng **251 PC LOG v3** rồi nhấn **Start một lần**. Không chọn mục v2 cũ.
6. Đóng và mở lại dang-ky.log bằng Notepad. Chờ thấy:

```text
TRACE_UI_READY build=pc-file-v3
```

7. Sau khi thấy mốc trên và game hiển thị bình thường, thực hiện đăng ký tài khoản
   thử. Chờ thông báo kết quả, đóng giả lập rồi gửi dang-ky.log và gia-lap-console.log,
   kèm máy chủ, thứ tự nút bấm và thông báo kết quả. Tạo nhân vật là bước khác;
   log cần bắt đầu từ trước thao tác đăng ký tài khoản.

Mỗi lần chạy CMD ghi đè hai tệp log; sao lưu trước khi chạy lại. Không mở nhiều
phiên trong cùng thư mục. Notepad không tự cập nhật, hãy đóng/mở lại để xem mới.

## Các mốc

- TRACE_LOADER_READY: bộ nạp và ghi tệp đã qua tự kiểm tra, chưa Start game.
- TRACE_CONTEXT_RESTORED: đã khôi phục đăng ký bị thiếu của đúng context hiện tại.
- TRACE_CONTEXT_MISSING: không tìm được context phù hợp; không tự gán sai context.
- TRACE_DISPLAY_READY: lấy được Display.
- TRACE_UI_READY: một lần vẽ màn hình game đã trả về thành công. Mốc này không
  xác nhận kết nối máy chủ hoặc đăng ký tài khoản thành công.

Nếu còn hộp lỗi, gửi cả hai log cùng ảnh hộp lỗi. Không chỉ dựa vào mốc
TRACE_STARTED của bản cũ, vì nó chỉ cho biết đã vào hàm khởi động.

## Tệp và dữ liệu

- dang-ky.log: luồng game ghi trực tiếp ngay cạnh CMD, không phụ thuộc console.
- gia-lap-console.log: kết quả tự kiểm tra và đầu ra của giả lập/Java.
- NST_TRACE_CHECK.jar: kiểm tra loader/quyền ghi; không thực hiện đăng ký.
- Linux/macOS: sh chay-ghi-log.sh; sau đó mở game v3 từ menu File như trên.

Log bổ sung chỉ ghi tên hàm, thời gian, tham số số nguyên và mã lệnh. Giá trị
chuỗi, mật khẩu, OTP, tài khoản và payload không được ghi bởi phần bổ sung.
Console sẵn có có thể chứa thông tin riêng tư: dùng tài khoản thử và kiểm tra/che
trước khi gửi. Chưa có auto tạo tài khoản trong bản này.

## Xác minh

Phân tích bytecode, kiểm tra ZIP/JAR; giữ nguyên các phương thức vòng đời gốc,
chỉ đổi một tham chiếu phương thức trong startApp. Đã khởi động game thật bằng
MICRO_NST được cung cấp ở chế độ headless và thấy TRACE_DISPLAY_READY/UI_READY.
Đã tái hiện đúng NullPointerException của Display.getDisplay khi thiếu đăng ký,
xác minh helper khôi phục đúng context và từ chối context sai. Phép thử chặn toàn
bộ kết nối mạng, không tạo tài khoản. Chưa thử giao diện Windows hay máy chủ.
