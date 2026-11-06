# Ninja School 251 — ghi log trên MicroEmulator (máy tính)

Bản này ghi dấu thời gian, luồng gọi hàm và mã lệnh ở các hàm tạo gói tin.
Dành cho chạy thử đăng ký thủ công; chưa có auto tạo tài khoản.

## Cách chạy trên Windows

1. Giải nén bộ `Ninja251_MicroEmulator_GhiLog.zip` vào một thư mục riêng.
2. Chép `microemulator.jar` và thư mục `lib` đi kèm bản MicroEmulator đang dùng
   vào cùng thư mục. Nếu JAR giả lập có tên kèm phiên bản, có thể đổi tên thành
   `microemulator.jar`; giữ các tệp phụ thuộc và cấu hình cần thiết của bản đó.
   Bộ tải này không bao gồm giả lập hay Java.
3. Chạy `CHAY_GHI_LOG.cmd`. Nếu Java chưa nằm trong PATH, dùng Java đã chạy
   được giả lập trên máy bạn hoặc thêm đường dẫn Java vào PATH.
4. Trong MicroEmulator, thực hiện đăng ký một tài khoản thử, chờ thông báo kết
   quả rồi đóng cửa sổ giả lập. Không chạy bằng cách bấm đúp JAR game.
5. Tệp `dang-ky.log` nằm ngay trong thư mục chứa `CHAY_GHI_LOG.cmd`, không cần
   xuất log từ trong game. Mỗi lần chạy sẽ ghi đè log cũ; sao lưu trước khi chạy lại.
6. Gửi log cùng thứ tự nút đã bấm, máy chủ đã chọn và thông báo kết quả.

Ví dụ cấu trúc thư mục:

```text
Ninja251_MicroEmulator/
  251_Love_Atun_TRACE.jar
  CHAY_GHI_LOG.cmd
  chay-ghi-log.sh
  microemulator.jar
  lib/
  dang-ky.log              <- sinh ra khi chạy bộ ghi log
```

Nếu bạn cần tham số JVM/cấu hình riêng để chạy MicroEmulator, giữ các tham số
đó và dùng JAR game `251_Love_Atun_TRACE.jar`. Ví dụ lệnh cơ bản:

```sh
java -Dfile.encoding=UTF-8 -jar microemulator.jar 251_Love_Atun_TRACE.jar > dang-ky.log 2>&1
```

Linux/macOS: chạy `sh chay-ghi-log.sh` từ bộ đã giải nén.

## Nội dung log và thông tin riêng tư

Các dòng `[NSO_TRACE]` gồm Unix timestamp mili giây, ENTER, tên lớp/hàm,
chữ ký hàm và các tham số số nguyên. `strings=REDACTED` cho biết chuỗi được bỏ qua.
Các hàm `(B)LWZKDTXfSh;` ghi `arg0` là mã lệnh có dấu.

Phần bổ sung không in giá trị chuỗi, mật khẩu, OTP hoặc mảng byte. Tệp còn thu
stdout/stderr sẵn có của game và giả lập; code gốc có thể tự in dữ liệu riêng tư.
Dùng tài khoản thử, đọc và che thông tin riêng tư trước khi gửi; không gửi mật khẩu/OTP.

Dấu ENTER chỉ cho biết đã vào hàm, không chứng minh máy chủ nhận yêu cầu hoặc
đăng ký thành công. Cần đối chiếu thứ tự thao tác và thông báo trên màn hình.
Bản máy tính không có menu giữ phím # của bản Android.

## Đã kiểm tra

- CRC ZIP/JAR, cấu trúc 310 lớp, chữ ký hàm không trùng.
- Phân tích bytecode 1.203 phương thức trong 23 lớp đã sửa, gồm 258 wrapper log.
- Chạy JVM `-Xverify:all` trên bộ thử chuyển tiếp chuỗi, mảng, tham số long/double/float,
  hàm static, trả đối tượng và ngoại lệ; kiểm tra không in chuỗi đầu vào trong log.
- Đã sửa lỗi nạp tham số chuỗi/mảng có thể gây VerifyError trong bản máy tính trước.

Chưa chạy trực tiếp trên MicroEmulator, chưa kết nối máy chủ và chưa tạo tài khoản.
Nếu giả lập không mở hoặc báo VerifyError/ClassFormatError, gửi `dang-ky.log`,
phiên bản Java và MicroEmulator để kiểm tra.
