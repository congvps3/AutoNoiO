# Ninja 251 — Auto danh sách v6 trên máy tính

V6 thêm nút **Thêm file TXT** để đọc danh sách UTF-8/BOM và tạo nhân vật chính **Nam, phái Kiếm**. Auto chạy lần lượt nhiều tài khoản từ bảng nhập, tự sinh tên nhân vật tạm, đọc mã xác nhận đang hiển thị, tạo nhân vật chính và đăng xuất về **Chơi mới** trước lượt kế tiếp. Dành cho Java 8 và `MICRO_NST.jar` đã gửi; giao diện Swing chạy trên máy tính.

## Chạy bản mới

1. Đóng các cửa sổ NST/CMD cũ. Giải nén toàn bộ `Ninja251_AUTO_TaoTaiKhoan_v6.zip` vào thư mục mới.
2. Chép `MICRO_NST.jar` của bạn vào cùng thư mục rồi chạy `CHAY_AUTO.cmd`.
3. Trong giả lập chọn File → mở `251_Love_Atun_AUTO_NEW_v6.jar`, chọn **251 AUTO NEW v6** và Start một lần.
4. Chọn máy chủ, để game ở màn hình **Chơi mới**. Bảng Auto tự mở; có thể bấm **F6** khi đang chọn cửa sổ giả lập để gọi lại.
5. Điền bảng rồi bấm **Bắt đầu danh sách**. Mỗi hàng là một lượt; chạy hết hàng đã nhập thì dừng tại màn hình Chơi mới.

## Nhập nhiều tài khoản

Bấm **Thêm file TXT** rồi chọn tệp `.txt` mã hóa UTF-8, mỗi dòng `taikhoan|matkhau|tennhanvatchinh`. Không thêm tiêu đề. Tệp được đọc/kiểm tra định dạng trước khi thêm vào bảng; nếu lỗi định dạng thì dữ liệu đang có không bị thay đổi. Các dòng mới điền vào hàng trống rồi được nối tiếp vào danh sách.

Bảng có ba cột nhập **Tài khoản**, **Mật khẩu**, **Nhân vật chính** và cột **Kết quả**. Nhấp vào ô để nhập. Mật khẩu được che trên bảng. Bấm **Thêm dòng** hoặc chọn các hàng rồi **Xóa dòng**.

Có thể sao chép ba cột từ Excel rồi bấm **Dán danh sách**. Cũng có thể sao chép văn bản theo dạng sau, mỗi dòng ba giá trị phân cách bằng `|` (thay ví dụ bằng thông tin của bạn):

```text
taikhoan01|MatKhau01|ninjachinh01
taikhoan02|MatKhau02|ninjachinh02
```

Không thêm dòng tiêu đề. Khi dán, mật khẩu giữ nguyên khoảng trắng nên không thêm khoảng trắng quanh dấu `|`. Tài khoản và tên nhân vật được bỏ khoảng trắng ở hai đầu. Bảng được kiểm tra toàn bộ trước khi gửi yêu cầu đầu tiên: lỗi báo rõ số dòng và ô cần sửa; tài khoản hoặc tên nhân vật chính trùng trong cùng danh sách sẽ bị báo lỗi.

Giới hạn kiểm tra của bản auto: tài khoản 3–24 chữ/số/`_`, bắt đầu bằng chữ; mật khẩu 6–32 ký tự; nhân vật chính 6–12 chữ thường/số, bắt đầu bằng chữ. Máy chủ có thể có thêm quy tắc. Các hàng trống hoàn toàn được bỏ qua.

## Luồng mỗi lượt

Chơi mới → tạo nhân vật tạm → vào game → NPC Admin → Tài khoản → Đăng ký → điền tài khoản/mật khẩu → đọc và điền mã đang hiển thị → chờ xác nhận đăng ký thành công → đăng nhập tài khoản mới → tạo và vào đúng nhân vật chính → đóng phiên kết nối và trở về Chơi mới.

Chỉ sau khi màn hình Chơi mới đã trở lại và kết nối cũ đã đóng, auto mới chờ khoảng một giây rồi bắt đầu hàng kế tiếp. Tên tạm mới gồm 11 chữ thường/số, bắt đầu bằng `t`, được sinh lại sau mỗi lượt và tránh trùng với các tên chính trong danh sách. Ô tên tạm chỉ hiển thị tên đang dùng/chuẩn bị dùng. Nhân vật chính được đặt **Nam + Kiếm** ngay trước khi gửi thao tác tạo; nhân vật tạm dùng mặc định game.

Auto đọc mã 6 chữ/số cùng phần tiêu đề xác thực mà game đang vẽ. Không đoán mã hoặc thử nhiều giá trị. Nếu chưa nhận ra phần mã đang hiển thị, bảng báo đang chờ; bạn có thể nhập trực tiếp trong game và bấm Đồng ý để tiếp tục. Bước chờ này tối đa 5 phút. Các bước khác tối đa 60 giây.

Nếu một lượt lỗi, cột Kết quả lưu trạng thái của lượt đó. Auto đưa game về Chơi mới rồi mới chuyển sang hàng kế tiếp; không tự đăng ký lại cùng hàng. Nếu không trở về được Chơi mới trong thời gian chờ, hoặc không lưu được tệp tài khoản sau xác nhận thành công, danh sách sẽ dừng. Đã xử lý hết danh sách không có nghĩa mọi hàng đều thành công: xem cột Kết quả và tệp đã đăng ký.

**Dừng** ngừng xử lý các bước và hàng tiếp theo; không hoàn tác thao tác đã gửi. Đóng bảng cũng dừng danh sách; bấm F6 để mở lại. Mật khẩu của các hàng đã xử lý được xóa khỏi bảng. Khi dừng/hết danh sách, mật khẩu còn lại được bỏ khỏi bộ nhớ cấu hình/bảng; hãy chuẩn bị lại thông tin nếu muốn chạy một danh sách mới.

## Tệp kết quả và log

`tai-khoan-da-dang-ky.txt` nằm cạnh `dang-ky.log`, có các cột **Thời gian, Tài khoản, Kết quả**, dùng UTF-8 có BOM để mở bằng Notepad. File được tạo khi game chạy; ban đầu chỉ có tiêu đề.

Mỗi tài khoản được thêm một dòng ngay khi máy chủ xác nhận đăng ký thành công. Nếu sau đó bước đăng nhập/tạo nhân vật chính lỗi, dòng đã đăng ký vẫn được giữ, còn cột Kết quả trong bảng chỉ rõ lỗi bước sau. File danh sách được ghi nối tiếp, không bị ghi đè khi chạy lại launcher. Không lưu mật khẩu hoặc mã xác nhận vào file này.

Hai tệp chẩn đoán `dang-ky.log` và `gia-lap-console.log` cũng nằm cạnh CMD, được ghi đè mỗi lần chạy launcher. Các dòng `AUTO_BATCH_PROGRESS`, `AUTO_STATE`, `AUTO_ROW_RESULT`, `AUTO_ACCOUNT_SAVED` ghi tiến độ; không ghi tài khoản, mật khẩu hoặc nội dung mã vào hai log này. Game gốc có cơ chế RMS riêng. Không đưa danh sách tài khoản cá nhân hoặc danh sách mật khẩu lên repository công khai.

## Phạm vi kiểm tra

Đã kiểm tra mô phỏng hai tài khoản liên tiếp, điều kiện chờ đăng xuất/ngắt kết nối, sinh tên tạm, tự điền đúng một mã đã đọc, xác nhận thành công trước khi lưu, hàng lỗi và khôi phục, hủy danh sách, lỗi lưu file và kiểm tra toàn bộ đầu vào.

Đã kiểm tra với chính JAR game và `MICRO_NST.jar` ở chế độ không giao diện, mạng bị chặn: game khởi động/vẽ, callback menu/ô nhập, kiểm tra lựa chọn Nam/Kiếm trên lớp game gốc, đọc file UTF-8 bằng bộ nạp thật, thao tác đăng xuất về Chơi mới và lấy mã mẫu qua hàm vẽ chữ gốc. Dữ liệu kiểm thử là dữ liệu giả và không có trong ZIP.

**Chưa kiểm thử giao diện Windows và đăng ký thực trên máy chủ.** Nếu máy chủ thay đổi NPC, menu hoặc định dạng hiển thị mã thì cần cập nhật. Có thể nhập mã tay khi phần đọc tự động chưa nhận ra.

Linux/macOS: chép giả lập vào cùng thư mục, dùng Java có giao diện và chạy `sh chay-auto.sh`.
