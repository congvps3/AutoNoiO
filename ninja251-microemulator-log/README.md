# Ninja School 251 — PC LOG v2 (ghi trực tiếp ra tệp)

Bản sửa cho trường hợp `dang-ky.log` chỉ có thông tin Java và không có sự kiện.
Game ghi trực tiếp qua FileOutputStream; hoạt động độc lập với System.out/err.
Giả lập cần được thử thực tế vì MICRO_NST có thể thay đổi cách nạp game/quyền tệp.

## Cách dùng trên Windows

1. Đóng toàn bộ cửa sổ game/giả lập cũ. Giải nén đầy đủ bộ ZIP v2 vào thư mục mới.
2. Chép `MICRO_NST.jar` hoặc `microemulator.jar` vào đó, giữ tệp phụ trợ nếu bộ
   giả lập có sẵn. Không cần tự tạo `lib`. Bộ này không bao gồm Java/giả lập.
3. Chạy `CHAY_GHI_LOG.cmd`. Bộ chạy tự ưu tiên MICRO_NST nếu có cả hai tên.
4. Trong launcher, PHẢI chọn game có tên **251 PC LOG v2** rồi nhấn **Start**.
   Nếu chỉ thấy tên `251` cũ, dùng menu **File** của giả lập để mở đúng
   **251_Love_Atun_PC_LOG_v2.jar** vừa giải nén, rồi chọn game mới và Start.
   Chữ `251` cũ có thể là mục đã lưu; không dùng mục đó để kiểm tra bản mới.
5. Mở lại `dang-ky.log` bằng Notepad sau khi game đã Start. Phải thấy dòng chứa:

```text
[NSO_TRACE] ... TRACE_STARTED build=pc-file-v2 ...
```

Dòng này xác nhận bản có log đã được gọi startApp, chưa chứng minh kết nối máy
chủ hay đăng ký thành công. Chỉ các dòng NSO_TRACE_RUNNER/WAITING_FOR_TRACE_STARTED
chưa phải sự kiện game. Notepad không tự cập nhật: đóng và mở lại tệp để xem mới.

6. Sau khi thấy TRACE_STARTED, thực hiện đăng ký thử từ màn hình đăng ký tài khoản,
   chờ kết quả rồi đóng giả lập. Gửi cả `dang-ky.log` và `gia-lap-console.log`,
   kèm máy chủ, thứ tự thao tác và thông báo kết quả. Tạo nhân vật là bước khác;
   cần giữ log từ trước khi bấm đăng ký tài khoản.

Mỗi lần chạy sẽ ghi đè hai tệp cũ. Sao lưu trước khi chạy lại. Không mở đồng thời
nhiều phiên ghi cùng thư mục. Không mở game bằng bấm đúp JAR nếu muốn đặt vị trí
log đúng như bộ chạy.

## Tệp nằm ở đâu

- `dang-ky.log`: luồng game ghi trực tiếp, ngay cạnh file CMD.
- `gia-lap-console.log`: thông tin Java, stdout/stderr và lỗi của giả lập.
- `251_Love_Atun_PC_LOG_v2.jar`: game bản ghi log mới, tên launcher 251 PC LOG v2.

Script truyền thuộc tính JVM `nso.trace.file` bằng đường dẫn tuyệt đối. Nếu giả
lập không chuyển thuộc tính này tới game, helper thử tên `dang-ky.log` trong
thư mục làm việc của JVM. Nếu vẫn không có TRACE_STARTED sau khi chọn đúng tên
v2 và Start, gửi cả hai log cùng **MICRO_NST.jar** để phân tích bản giả lập.
Nếu helper bị từ chối ghi tệp, nó thử báo `NSO_TRACE_FILE_ERROR` trên stderr
(một số giả lập cũng có thể chuyển stderr ra nơi khác).

Linux/macOS: `sh chay-ghi-log.sh`. Lệnh tương đương trên Windows:

```bat
java -Dfile.encoding=UTF-8 "-Dnso.trace.file=%CD%\dang-ky.log" -jar MICRO_NST.jar 251_Love_Atun_PC_LOG_v2.jar > gia-lap-console.log 2>&1
```

Giữ các tham số cấu hình riêng của bản giả lập nếu cần. Bản v2 có tên/vender khác
để phân biệt trong launcher và có thể dùng RMS riêng, nên có thể cần chọn lại máy chủ.

## Nội dung và quyền riêng tư

Ghi thời gian, tên hàm, tham số số nguyên, mã gói tin gửi/đang xử lý; bỏ qua giá trị
chuỗi và mảng byte. Không ghi bàn phím, tài khoản/mật khẩu/OTP hay payload trong
phần bổ sung. Console sẵn có của game/giả lập có thể chứa thông tin riêng tư:
đọc và che trước khi gửi; dùng tài khoản thử. Các mốc ENTER chỉ xác nhận vào hàm,
không xác nhận máy chủ đã nhận hay chấp thuận đăng ký. Chưa có auto tạo tài khoản.

## Kiểm tra

- CRC JAR và cấu trúc 311 lớp; 259 hook, có startup hook.
- Phân tích bytecode 1.211 phương thức trong 24 lớp đã sửa.
- JVM -Xverify:all với helper thực đóng gói và bộ thử: tắt stdout/stderr vẫn ghi
  tệp, đường dẫn có dấu cách/tiếng Việt, startup marker, metadata gói tin, truyền
  chuỗi/mảng/long/double/float, static/return/ngoại lệ, không in chuỗi đầu vào,
  ghi đồng thời, lỗi ghi tệp không làm dừng game, phục hồi và đường dẫn mặc định.
- Bộ chạy shell: chọn tên giả lập, chuyển hướng console, đường dẫn tuyệt đối,
  dấu xác nhận, tệp thiếu và mã thoát bằng Java mô phỏng.
- Chưa chạy trực tiếp Windows/MICRO_NST hay đăng ký trên máy chủ. Cần thử thực tế.
