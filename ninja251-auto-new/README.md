# Ninja 251 — Auto tạo tài khoản v4 trên máy tính

**Bản v4 báo rõ lỗi nhập liệu bằng tiếng Việt, giữ mật khẩu khi tên nhân vật chưa hợp lệ và thêm danh sách tài khoản đã đăng ký. Kế thừa ô nhập lớn, giao diện gọn và phím F6.**

Bản thử nghiệm dành cho Java 8 và giả lập `MICRO_NST.jar` đã gửi. Đây là bản máy tính; cửa sổ điều khiển dùng Swing nên không chạy bằng J2ME Loader trên Android.

## Luồng thực hiện

Chơi mới → tạo nhân vật tạm → vào game → gặp NPC **Admin** → **Tài khoản** → **Đăng ký** → điền tài khoản, mật khẩu → **chờ bạn nhập mã xác thực trong game** → chờ thông báo đăng ký thành công → chờ máy chủ ngắt kết nối → đăng nhập tài khoản mới → tạo nhân vật chính → vào game.

Mỗi lần bấm chỉ chạy một lượt, không tự thử lại khi lỗi. Auto gọi các thao tác của client gốc và chờ màn hình/phản hồi tiếp theo. Việc đã gửi yêu cầu không được tính là đăng ký thành công. Trạng thái hoàn tất yêu cầu cả thông báo thành công lẫn vào đúng nhân vật chính.

## Cách chạy trên Windows

1. Tải `Ninja251_AUTO_TaoTaiKhoan_v4.zip` và giải nén toàn bộ vào một thư mục riêng, ví dụ `Downloads\ninja-auto-v4`.
2. Chép **`MICRO_NST.jar` của bạn** vào cùng thư mục. Bộ ZIP không kèm giả lập. Giữ Java 8 đang dùng trên máy.
3. Chạy `CHAY_AUTO.cmd`. Chương trình kiểm tra khả năng nạp game và ghi log trước khi mở giả lập.
4. Trong giả lập chọn **File → Open MIDlet File** (hoặc mục mở JAR), mở **`251_Love_Atun_AUTO_NEW_v4.jar`**. Chọn **251 AUTO NEW v4**, nhấn **Start một lần**.
5. Chọn đúng máy chủ trong game rồi để game ở màn hình có nút **Chơi mới**. Cửa sổ **Ninja 251 — Auto v4** tự xuất hiện khi game đến màn hình này.
6. Nhập tài khoản mới, mật khẩu, tên nhân vật tạm và tên nhân vật chính. Hai tên nhân vật phải khác nhau và chưa được sử dụng. Bấm **Bắt đầu 1 lượt**.
7. Khi cửa sổ báo **CHỜ BẠN nhập mã xác thực**, chuyển sang game, đọc mã đang hiển thị, nhập vào ô bước 3 và bấm **Đồng ý**. Auto tiếp tục sau thao tác này.
8. Đợi thông báo **Hoàn tất**. Giữ cửa sổ điều khiển mở trong lúc chạy; có thể thu nhỏ. Đóng cửa sổ sẽ dừng auto; bấm **F6** khi đang chọn cửa sổ giả lập để mở lại bảng. F6 chỉ mở bảng, không tự bắt đầu một lượt.

Tài khoản: 3–24 ký tự, bắt đầu bằng chữ, sau đó là chữ/số/`_`. Mật khẩu: 6–32 ký tự. Tên nhân vật: 6–12 chữ thường/số, bắt đầu bằng chữ. Đây là giới hạn kiểm tra đầu vào của bản auto; máy chủ có thể áp dụng thêm quy tắc. Kiểu nhân vật dùng lựa chọn mặc định của game.

Không bấm thêm các menu trong lúc auto chạy, trừ bước nhập mã xác thực. **Dừng auto** chỉ dừng các bước tiếp theo; thao tác đã gửi tới máy chủ không được hoàn tác. Nếu đã đăng ký thành công nhưng lỗi ở bước đăng nhập/tạo nhân vật, trạng thái sẽ ghi rõ tài khoản đã được tạo. Khi đó dùng thông tin vừa chọn để đăng nhập thủ công.

Khi cập nhật từ bản cũ: đóng hết cửa sổ NST và CMD cũ, giải nén ZIP v2 vào thư mục mới, chỉ chép `MICRO_NST.jar` sang. Sau khi chạy CMD, mở đúng JAR **AUTO NEW v4**, không mở lại JAR bản cũ trong danh sách gần đây của giả lập.

## Tệp tài khoản đã đăng ký

Khi game v4 bắt đầu chạy, nó tự tạo **`tai-khoan-da-dang-ky.txt` cạnh `dang-ky.log`**. Ban đầu tệp chỉ có tiêu đề, chưa có tài khoản nào được ghi nhận. Tệp dùng UTF-8 có BOM để mở được bằng Notepad trên Windows.

Chỉ khi máy chủ báo đăng ký thành công sau bước mã xác thực, auto mới thêm một dòng gồm **thời gian, tên tài khoản và kết quả**. Chưa xác nhận thành công, lỗi nhập liệu, đăng ký bị từ chối hoặc mất kết nối chưa có thông báo thành công đều không được ghi vào danh sách. Không ghi mật khẩu vào tệp này.

Các dòng cũ được giữ lại khi chạy lại launcher; tệp tài khoản không bị ghi đè như hai tệp log. Nếu đăng ký thành công rồi bước đăng nhập/tạo nhân vật chính bị lỗi, dòng tài khoản đã lưu vẫn còn. Nếu không ghi được tệp, auto báo đã đăng ký nhưng chưa lưu được danh sách và dừng các bước tiếp theo. Xem thông báo game để biết kết quả thực tế.

## Log và xử lý lỗi

Hai tệp nằm cạnh `CHAY_AUTO.cmd`: **`dang-ky.log`** và **`gia-lap-console.log`**. Mỗi lần chạy launcher sẽ ghi đè hai tệp này. `AUTO_ENGINE_READY build=auto-new-v4` xác nhận phần điều khiển v4 đã chạy. `AUTO_SCREEN pNpEFjPucSSVu` xác nhận đã nhận đúng màn hình Chơi mới. `AUTO_SHORTCUT_READY key=F6` xác nhận phím mở bảng đã được gắn. `AUTO_WINDOW_SHOWN build=auto-new-v4` xác nhận bảng đã được mở; `AUTO_UI_ERROR` ghi loại lỗi nếu không mở được. `AUTO_START_REJECTED` ghi lý do chưa bắt đầu; `AUTO_ACCOUNT_SAVED` xác nhận đã ghi một dòng vào tệp tài khoản. Các dòng `AUTO_STATE` ghi tiến trình, ví dụ `WAIT_MANUAL_CODE`, `WAIT_REGISTER_RESULT`, `DONE` hoặc `ERROR:...`.

Nếu báo tên nhân vật chưa hợp lệ: cả hai tên cần **6–12 chữ thường/số, bắt đầu bằng chữ**, và phải khác nhau. Bản auto kiểm tra điều kiện này trước khi gửi yêu cầu; ví dụ tên 5 ký tự sẽ chưa bắt đầu. Sửa đúng ô được báo rồi bấm lại; không phải nhập lại mật khẩu chỉ vì lỗi tên.

Nếu dừng ở một bước quá 60 giây, auto báo lỗi và không thử lại. Bước nhập mã cho phép chờ 5 phút. Nếu nhập sai mã hoặc máy chủ đổi luồng, xem thông báo trong game. Có thể thao tác thủ công sau khi dừng; muốn chạy lại từ đầu, quay về màn hình Chơi mới.

Nếu không thấy cửa sổ auto, chọn cửa sổ giả lập rồi bấm **F6**. Kiểm tra đã mở đúng JAR **AUTO NEW v4** và đã tới màn hình Chơi mới. `TRACE_UI_READY build=pc-file-v3` là dấu hiệu phần ghi log nền đã vẽ xong màn hình; bản auto kế thừa bộ ghi log v3 này. `TRACE_LOADER_READY build=auto-new-v4` chỉ xác nhận bước kiểm tra bộ nạp, chưa xác nhận game vào được máy chủ.

Mã auto không ghi tài khoản, mật khẩu hay nội dung mã xác thực vào hai tệp log; tên tài khoản được ghi riêng vào danh sách đã đăng ký theo yêu cầu. Nó không đọc hoặc tự điền mã xác thực. Mật khẩu chỉ dùng trong bộ nhớ để đăng ký và đăng nhập, rồi bỏ tham chiếu khi kết thúc/dừng/lỗi; game gốc vẫn có cơ chế lưu thông tin đăng nhập/RMS riêng. Hãy xem và che thông tin riêng tư trong các tệp trước khi gửi để hỗ trợ; không đưa tệp danh sách tài khoản cá nhân lên GitHub công khai. Video và log cá nhân không có trong gói này.

## Phạm vi đã kiểm tra

Đã tái hiện lỗi đọc nhầm màn hình trên v1 và kiểm tra sửa lỗi trên v2 (kế thừa trong v3) bằng chính game/giả lập gốc, không kết nối máy chủ. Đã kiểm tra cấu trúc JAR, bytecode, bộ nạp thật của `MICRO_NST.jar`, khởi động game ở chế độ không giao diện và các liên kết menu/ô nhập thật trong game với mạng bị chặn. Đã chạy mô phỏng toàn bộ luồng, chờ mã thủ công, phản hồi thành công/thất bại, thời gian chờ và dừng.

**Chưa kiểm thử cửa sổ Windows và một lượt đăng ký thực trên máy chủ.** Bản v4 cần bạn chạy thử trên máy đang dùng. Nó phụ thuộc NPC Admin, các menu và các bước đăng ký trong video; nếu máy chủ thay đổi chúng thì cần cập nhật.

Linux/macOS: chép giả lập vào cùng thư mục rồi chạy `sh chay-auto.sh`; vẫn cần Java có giao diện đồ họa.
