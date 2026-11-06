# Ninja 251 Android Auto v6 — J2ME Loader

Bản riêng cho **J2ME Loader trên Android**; dùng giao diện MIDP gốc, không dùng Swing/AWT hoặc Java reflection. File cài: `251_Love_Atun_ANDROID_AUTO_v6.jar`.

## Cài và mở bảng Auto

1. Tải JAR về điện thoại, mở J2ME Loader và thêm/cài file JAR này. Đây là ứng dụng có tên **251 Android Auto v6**, tách dữ liệu RMS khỏi game gốc.
2. Vào game tới màn hình **Chơi mới**, chọn đúng máy chủ. Bảng **Ninja Auto Android v6** tự hiện một lần khi game tới màn hình đó.
3. Nếu cần mở lại bảng: ở màn hình game/Chơi mới, giữ phím **#** hơn một giây rồi thả. Dùng bàn phím giả lập của J2ME Loader để nhấn #.
4. Chọn **Vào game** để quay lại. Khi bảng Auto đang mở, luồng tự động tạm dừng và đồng hồ chờ được tạm giữ. Đóng ứng dụng/J2ME Loader vẫn làm mất hàng đợi chưa chạy trong bộ nhớ.

## Nạp danh sách

Chọn **Nạp file TXT → Chọn file**, duyệt các thư mục mà giả lập cho phép và chọn file UTF-8. Có thể gõ trực tiếp đường dẫn dạng `file:///.../danhsach.txt` trong ô đường dẫn rồi chọn **Nạp file**.

Mỗi dòng theo cú pháp:

```text
taikhoan01|MatKhau01|ninjachinh01
taikhoan02|MatKhau02|ninjachinh02
```

Thay ví dụ bằng thông tin của bạn, không thêm dòng tiêu đề. Tài khoản và tên nhân vật được bỏ khoảng trắng ở hai đầu; mật khẩu giữ nguyên nên không thêm khoảng trắng quanh dấu `|`. Hỗ trợ UTF-8 có/không BOM, xuống dòng Windows CRLF hoặc LF. Kiểm tra đủ cả file rồi mới thay danh sách đã nạp; file lỗi không làm mất danh sách cũ.

Nếu trình duyệt file báo không có quyền/không thấy file, vào cài đặt J2ME Loader, cấp quyền lưu trữ và kiểm tra thư mục gốc/file system của giả lập. Các đường dẫn `file:///...` là đường dẫn trong giả lập; tên thư mục Android thật phụ thuộc phiên bản J2ME Loader và thư mục bạn cấu hình, không phải luôn `/Download`.

Có thể dùng **Nhập/dán danh sách** để nhập trực tiếp hoặc dán văn bản từ điện thoại, sau đó **Nhận danh sách**. Cách này không cần quyền đọc file.

Tài khoản: 3–24 chữ/số/`_`, bắt đầu bằng chữ. Mật khẩu: 6–32 ký tự. Nhân vật chính: 6–12 chữ thường/số, bắt đầu bằng chữ. Các tài khoản và tên chính trong cùng danh sách phải khác nhau.

## Chạy danh sách

Để game ở màn hình Chơi mới, chọn **Bắt đầu danh sách**. Bảng được đóng và game tiếp tục hiển thị để auto hoạt động.

Mỗi lượt: Chơi mới → tên nhân vật tạm ngẫu nhiên → gặp Admin → Tài khoản → Đăng ký → điền tài khoản/mật khẩu → đọc mã đang hiển thị → chờ xác nhận đăng ký thành công → đăng nhập → tạo nhân vật chính **nam, phái Kiếm**, diện mạo đầu tiên → vào đúng nhân vật → đăng xuất về Chơi mới.

Chỉ sau khi màn hình Chơi mới đã trở lại và kết nối cũ đã đóng, auto mới sinh tên tạm mới rồi sang hàng tiếp theo. Hết danh sách thì dừng. Một hàng bị lỗi sẽ được đưa về Chơi mới trước khi chuyển tiếp; không tự lặp lại cùng hàng. Nếu không khôi phục được màn hình Chơi mới hoặc không lưu được kết quả RMS thì dừng toàn bộ.

Auto đọc phần chữ mã xác thực mà game đang vẽ. Nếu không nhận ra định dạng mã, có thể nhập tay trong game rồi bấm Đồng ý. Bước mã chờ tối đa 5 phút; các bước khác tối đa 60 giây. Mở bảng Auto sẽ tạm dừng đồng hồ chờ; quay về game để tiếp tục. **Dừng auto** dừng hàng đang chạy và các hàng còn lại, không hoàn tác yêu cầu đã gửi.

## Danh sách tài khoản và TXT kết quả

Chọn **Tài khoản đã tạo** để xem các tài khoản mà máy chủ đã xác nhận đăng ký thành công. Dữ liệu được lưu trong RMS riêng của ứng dụng này, giữ qua các lần đóng/mở J2ME Loader. Không xóa dữ liệu ứng dụng/giả lập trước khi xuất kết quả.

Chọn **Xuất TXT kết quả**, nhập đường dẫn file mới, ví dụ một đường dẫn hợp lệ trong giả lập kết thúc bằng `tai-khoan-da-dang-ky.txt`. Sau khi xuất thành công, các tài khoản thành công tiếp theo được ghi nối vào file đó. Nội dung gồm thời gian, tên tài khoản và kết quả; không ghi mật khẩu/mã xác thực. Tệp UTF-8 có BOM.

Không ghi đè file không liên quan đã có dữ liệu (chẳng hạn file danh sách đầu vào). Nếu được báo file đã có dữ liệu khác, chọn tên file kết quả mới. File kết quả do app đã xuất trước có thể được cập nhật lại. Nếu ghi file ngoài thất bại, bản RMS vẫn giữ tài khoản và bảng Auto báo lỗi xuất/ghi nối; có thể xuất lại sang đường dẫn khác.

Tài khoản được lưu ngay sau thông báo đăng ký thành công. Nếu bước tạo nhân vật chính sau đó lỗi, tài khoản đã đăng ký vẫn còn trong danh sách. Màn hình thông báo tiến trình và **Xem log** giúp xác định bước bị dừng; log chỉ giữ 300 sự kiện gần nhất, không chứa tài khoản, mật khẩu hay nội dung mã.

## Phạm vi kiểm tra

Đã kiểm tra bytecode/JAR, các API MIDP và JSR75 ở mức biên dịch, luồng hai tài khoản bằng bridge giả, đọc/ghi file với fixture, RMS, và khởi động game gốc đã chỉnh trên MICRO_NST ở chế độ headless với mạng bị chặn. Kiểm thử bridge thật đã xác nhận lệnh tạo nhân vật gửi giới tính=1 (nam), diện mạo=2, phái=1 (Kiếm), đăng xuất về Chơi mới và lấy mã mẫu qua hàm vẽ chữ gốc. Không tạo tài khoản thật trong kiểm thử.

**Chưa chạy trên điện thoại Android/J2ME Loader thật và chưa đăng ký trên máy chủ thật.** Quyền lưu trữ, bàn phím # và bố cục MIDP cần bạn thử trên điện thoại. Mã menu/NPC hoặc định dạng mã do máy chủ thay đổi có thể cần cập nhật.
