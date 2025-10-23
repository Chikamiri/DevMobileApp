
# Mid Exam

## ⚙️ Công nghệ

- Flutter 3.x  
- SQLite (`sqflite` package)  
- Provider (hoặc setState) để đồng bộ dữ liệu giữa các màn hình  

---

## ✅ Các bảng trong SQLite

### `products`

| Cột | Kiểu dữ liệu | Ghi chú |
|------|---------------|---------|
| id | INTEGER (PK) | Tự tăng |
| name | TEXT | Tên hàng hóa |
| quantity | INTEGER | Số lượng tồn |
| price | REAL | Giá bán |
| supplierId | INTEGER | Liên kết với bảng suppliers |

### `suppliers`

| Cột | Kiểu dữ liệu | Ghi chú |
|------|---------------|---------|
| id | INTEGER (PK) | |
| name | TEXT | Tên nhà cung cấp |
| contact | TEXT | Thông tin liên hệ |

### `customers`

| Cột | Kiểu dữ liệu | Ghi chú |
|------|---------------|---------|
| id | INTEGER (PK) | |
| name | TEXT | Tên khách hàng |
| contact | TEXT | Thông tin liên hệ |

### `exports`

| Cột | Kiểu dữ liệu | Ghi chú |
|------|---------------|---------|
| id | INTEGER (PK) | |
| productId | INTEGER | Hàng hóa đã xuất |
| customerId | INTEGER | Khách hàng nhận |
| quantity | INTEGER | Số lượng xuất |
| date | TEXT | Ngày xuất |

---

## 📋 Chức năng chính

| Màn hình | Chức năng | Trạng thái |
|-----------|------------|-------------|
| Hàng hóa | Hiển thị danh sách, thêm/sửa/xóa, cập nhật tồn kho | 🔜 |
| Nhà cung cấp | Quản lý danh sách NCC | 🔜 |
| Khách hàng | Quản lý khách hàng | 🔜 |
| Xuất hàng | Tạo phiếu xuất, trừ số lượng tồn | 🔜 |
| Cài đặt | Thay đổi theme, reset DB | 🔜 |
