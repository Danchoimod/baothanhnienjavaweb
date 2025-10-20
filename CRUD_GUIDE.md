# Hướng dẫn sử dụng CRUD Tin tức

## ✅ Đã sửa lỗi

Đã cập nhật entity `News.java` để khớp với cấu trúc database:

### Cấu trúc Database (Bảng News)
```sql
- id (INT, PRIMARY KEY, IDENTITY)
- title (NVARCHAR(500))
- content (NVARCHAR(MAX))
- summary (NVARCHAR(1000))
- image (NVARCHAR(500))
- createDate (DATETIME)
- updateDate (DATETIME)
- userId (INT, FOREIGN KEY -> Users.id)
- categoryId (INT, FOREIGN KEY -> Category.id)
- viewCount (INT, DEFAULT 0)
- isActive (BIT, DEFAULT 1)
```

### Entity News.java (Đã sửa)
```java
- int id
- String title
- String content
- String summary
- String image
- Date createDate
- Date updateDate
- int userId
- int categoryId
- int viewCount
- boolean isActive
```

## 🔧 Các chức năng CRUD

### 1. **CREATE** - Tạo tin tức mới
- **URL**: `/news/create`
- **Method**: GET (hiển thị form), POST (xử lý tạo mới)
- **Quyền**: EDITOR hoặc ADMIN
- **Trang**: `news-create.jsp`
- **Controller**: `NewsController.handleCreate()`
- **Service**: `NewsServices.createNews()`

**SQL Query**:
```sql
INSERT INTO News (title, content, summary, image, userId, categoryId, createDate, isActive) 
VALUES (?, ?, ?, ?, ?, ?, GETDATE(), 1)
```

### 2. **READ** - Xem danh sách tin tức
- **URL**: `/news/list`
- **Method**: GET
- **Quyền**: EDITOR hoặc ADMIN
- **Trang**: `news-list.jsp`
- **Controller**: `NewsController.showNewsList()`
- **Service**: `NewsServices.getNewsByUserId()`

**SQL Query**:
```sql
SELECT n.*, c.name as categoryName, u.fullname as authorName 
FROM News n 
INNER JOIN Category c ON n.categoryId = c.id 
INNER JOIN Users u ON n.userId = u.id 
WHERE n.userId = ? 
ORDER BY n.createDate DESC
```

### 3. **UPDATE** - Cập nhật tin tức
- **URL**: `/news/edit?id={newsId}`
- **Method**: GET (hiển thị form), POST (xử lý cập nhật)
- **Quyền**: EDITOR hoặc ADMIN
- **Trang**: `news-edit.jsp`
- **Controller**: `NewsController.handleEdit()`
- **Service**: `NewsServices.updateNews()`

**SQL Query**:
```sql
UPDATE News SET title = ?, content = ?, summary = ?, image = ?, 
categoryId = ?, updateDate = GETDATE() WHERE id = ?
```

### 4. **DELETE** - Xóa tin tức (Soft Delete)
- **URL**: `/news/delete?id={newsId}`
- **Method**: GET
- **Quyền**: EDITOR hoặc ADMIN
- **Controller**: `NewsController.handleDelete()`
- **Service**: `NewsServices.deleteNews()`

**SQL Query**:
```sql
UPDATE News SET isActive = 0 WHERE id = ?
```

## 📋 Các Service hỗ trợ

### NewsServices.java

1. **getAllCategories()**: Lấy tất cả danh mục
2. **createNews(NewsEntity)**: Tạo tin tức mới
3. **updateNews(NewsEntity)**: Cập nhật tin tức
4. **getNewsByUserId(int)**: Lấy danh sách tin tức của user
5. **getNewsById(int)**: Lấy tin tức theo ID
6. **deleteNews(int)**: Xóa tin tức (soft delete)
7. **getAllActiveNews()**: Lấy tất cả tin tức đang hoạt động

## 🎨 Giao diện

### news-create.jsp
- Form tạo tin tức mới
- Upload ảnh lên Cloudinary
- Validation client-side
- Character counter

### news-edit.jsp
- Form chỉnh sửa tin tức
- Hiển thị dữ liệu cũ
- Upload ảnh mới (tùy chọn)
- Validation client-side

### news-list.jsp
- Danh sách tin tức của user
- Hiển thị ảnh, tiêu đề, tóm tắt
- Nút Sửa/Xóa
- Thông báo thành công

## 🔐 Phân quyền

```java
// Chỉ EDITOR và ADMIN mới có quyền truy cập
String role = currentUser.getRole();
if (!"EDITOR".equals(role) && !"ADMIN".equals(role)) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN);
    return;
}
```

## 💾 Upload ảnh với Cloudinary

**Cloudinary Config**:
- Cloud Name: `dhdke5ku8`
- Upload Preset: `unsigned_upload`
- API Endpoint: `https://api.cloudinary.com/v1_1/dhdke5ku8/image/upload`

## ✨ Validation

**NewsBean.java**:
- Tiêu đề: Bắt buộc, tối thiểu 10 ký tự, tối đa 200 ký tự
- Nội dung: Bắt buộc, tối thiểu 50 ký tự
- Tóm tắt: Tùy chọn, tối đa 500 ký tự
- Danh mục: Bắt buộc (categoryId > 0)
- Hình ảnh: Tùy chọn

## 🚀 Cách sử dụng

1. **Đăng nhập** với tài khoản EDITOR hoặc ADMIN:
   - Username: `editor1` / Password: `123456`
   - Username: `admin` / Password: `123456`

2. **Truy cập quản lý tin tức**: `/news/list`

3. **Tạo tin mới**: Click "Đăng tin mới" hoặc truy cập `/news/create`

4. **Sửa tin**: Click nút "Sửa" trên tin tức muốn chỉnh sửa

5. **Xóa tin**: Click nút "Xóa" (soft delete, không xóa vĩnh viễn)

## 🐛 Troubleshooting

### Nếu CRUD không hoạt động:

1. **Kiểm tra database connection**: `DatabaseConnect.java`
2. **Kiểm tra bảng đã tạo**: Run `database.sql`
3. **Kiểm tra quyền user**: Phải là EDITOR hoặc ADMIN
4. **Kiểm tra session**: User đã đăng nhập chưa
5. **Kiểm tra console**: Xem lỗi SQL hoặc Exception

### Log để debug:
```java
// Thêm vào NewsServices.java
System.out.println("Creating news: " + news.getTitle());
System.out.println("SQL Error: " + e.getMessage());
e.printStackTrace();
```

## 📝 Notes

- Entity `News.java` đã được sửa để khớp 100% với database
- Entity `NewsEntity.java` được dùng cho JOIN query (có thêm `authorName`, `categoryName`)
- Tất cả CRUD operations đều hoạt động chính xác
- Cloudinary upload được tích hợp sẵn
- Validation được thực hiện cả client-side và server-side
