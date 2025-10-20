# 📰 Tính năng Chi tiết Bài báo

## ✨ Đã hoàn thành

Đã thêm tính năng xem chi tiết bài báo với đầy đủ các chức năng:

### 🎯 Các chức năng chính

#### 1. **Xem chi tiết bài báo**
- URL: `/news/detail?id={newsId}`
- Hiển thị đầy đủ thông tin:
  - ✅ Tiêu đề
  - ✅ Danh mục
  - ✅ Tác giả
  - ✅ Ngày đăng
  - ✅ Số lượt xem
  - ✅ Tóm tắt
  - ✅ Hình ảnh
  - ✅ Nội dung đầy đủ

#### 2. **Đếm lượt xem tự động**
- Mỗi lần truy cập bài viết, số lượt xem tự động tăng lên
- SQL: `UPDATE News SET viewCount = viewCount + 1 WHERE id = ?`

#### 3. **Tin liên quan**
- Hiển thị 5 tin cùng danh mục
- Sắp xếp theo số lượt xem và ngày đăng
- Loại bỏ bài báo hiện tại

#### 4. **Sidebar**
- Tin xem nhiều
- Quảng cáo

#### 5. **Các nút tương tác**
- 👍 Thích (Coming soon)
- 💬 Bình luận (Coming soon)
- 🔗 Chia sẻ (Hỗ trợ Web Share API & Copy link)
- 🔖 Lưu (Coming soon)

## 📁 Các file đã thêm/sửa

### 1. File mới: `news-detail.jsp`
Trang hiển thị chi tiết bài báo với giao diện đẹp, responsive

**Đặc điểm:**
- Layout 2 cột (8-4)
- Header navbar với user dropdown
- Back button về trang chủ
- Meta information (tác giả, ngày, lượt xem)
- Social share buttons
- Related news section
- Sidebar với tin xem nhiều

### 2. Cập nhật: `NewsServices.java`
Thêm 2 methods mới:

```java
// Tăng lượt xem
public boolean incrementViewCount(int newsId)

// Lấy tin liên quan
public List<NewsEntity> getRelatedNews(int newsId, int categoryId, int limit)
```

### 3. Cập nhật: `NewsController.java`
Thêm route và method mới:

```java
@WebServlet({..., "/news/detail"})

private void showNewsDetail(HttpServletRequest req, HttpServletResponse resp)
```

**Xử lý:**
- Lấy tin tức theo ID
- Kiểm tra tồn tại và active
- Tăng view count
- Lấy tin liên quan
- Forward đến JSP

### 4. Cập nhật: `home.jsp`
Thay đổi tất cả link `#` thành link thực:

```jsp
<!-- Trước -->
<a href="#">Tiêu đề tin</a>

<!-- Sau -->
<a href="<%= request.getContextPath() %>/news/detail?id=<%= news.getId() %>">
    <%= news.getTitle() %>
</a>
```

## 🎨 Giao diện

### Desktop
```
┌─────────────────────────────────────────────┐
│           NAVBAR (Logo + User)               │
├───────────────────┬─────────────────────────┤
│                   │                         │
│   Article         │   Sidebar               │
│   - Header        │   - Tin xem nhiều       │
│   - Image         │   - Quảng cáo           │
│   - Content       │                         │
│   - Actions       │                         │
│                   │                         │
│   Related News    │                         │
│                   │                         │
└───────────────────┴─────────────────────────┘
```

### Mobile (Responsive)
```
┌─────────────────────┐
│   NAVBAR            │
├─────────────────────┤
│   Article           │
│   - Header          │
│   - Image           │
│   - Content         │
│   - Actions         │
│                     │
│   Related News      │
│                     │
│   Sidebar           │
│   - Tin xem nhiều   │
└─────────────────────┘
```

## 🔧 Cách sử dụng

### 1. Từ trang chủ
```
1. Truy cập: http://localhost:8080/your-app/home
2. Click vào bất kỳ bài báo nào
3. Tự động chuyển đến: /news/detail?id={newsId}
```

### 2. Truy cập trực tiếp
```
URL: http://localhost:8080/your-app/news/detail?id=1
```

### 3. Từ danh sách tin liên quan
```
Click vào bất kỳ tin liên quan nào
→ Tự động reload trang với bài báo mới
→ View count tăng
```

## 📊 Database

### View Count được tăng tự động
```sql
-- Mỗi lần xem
UPDATE News SET viewCount = viewCount + 1 WHERE id = ?

-- Kiểm tra
SELECT id, title, viewCount FROM News ORDER BY viewCount DESC
```

### Lấy tin liên quan
```sql
SELECT TOP 5 n.*, c.name as categoryName, u.fullname as authorName 
FROM News n 
INNER JOIN Category c ON n.categoryId = c.id 
INNER JOIN Users u ON n.userId = u.id 
WHERE n.isActive = 1 
  AND n.categoryId = ? 
  AND n.id != ? 
ORDER BY n.viewCount DESC, n.createDate DESC
```

## ⚡ Tính năng nổi bật

### 1. **Không cần đăng nhập**
```java
// Trang chi tiết không cần đăng nhập
if (path.equals("/news/detail")) {
    showNewsDetail(req, resp);
    return; // Không check session
}
```

### 2. **Auto-increment View Count**
```java
// Tự động tăng khi vào trang
newsServices.incrementViewCount(newsId);
```

### 3. **Related News thông minh**
- Cùng danh mục
- Loại bỏ bài hiện tại
- Ưu tiên tin xem nhiều
- Limit 5 bài

### 4. **Web Share API**
```javascript
function shareArticle() {
    if (navigator.share) {
        navigator.share({
            title: title,
            url: url
        });
    } else {
        // Fallback: Copy to clipboard
        navigator.clipboard.writeText(url);
    }
}
```

### 5. **Responsive Design**
- Desktop: 2 cột (8-4)
- Tablet: 2 cột adjusted
- Mobile: 1 cột stack

## 🐛 Error Handling

### 1. Không tìm thấy bài báo
```java
if (news == null || !news.isActive()) {
    resp.sendRedirect(req.getContextPath() + "/home");
    return;
}
```

### 2. ID không hợp lệ
```java
try {
    int newsId = Integer.parseInt(newsIdParam);
    // ...
} catch (NumberFormatException e) {
    resp.sendRedirect(req.getContextPath() + "/home");
}
```

### 3. Bài báo đã xóa (isActive = 0)
```java
if (!news.isActive()) {
    resp.sendRedirect(req.getContextPath() + "/home");
}
```

## 📱 Social Features

### Chia sẻ
- ✅ Web Share API (Mobile)
- ✅ Copy link (Fallback)
- 🔜 Facebook Share
- 🔜 Twitter Share
- 🔜 Zalo Share

### Tương tác
- 🔜 Like/Unlike
- 🔜 Comment
- 🔜 Bookmark
- 🔜 Report

## 🎯 Flow hoạt động

```
User click bài báo trên home.jsp
    ↓
GET /news/detail?id=123
    ↓
NewsController.showNewsDetail()
    ↓
1. Lấy tin tức từ DB (getNewsById)
    ↓
2. Kiểm tra tồn tại & active
    ↓
3. Tăng view count (incrementViewCount)
    ↓
4. Lấy tin liên quan (getRelatedNews)
    ↓
5. Set attributes và forward
    ↓
news-detail.jsp render
    ↓
User xem nội dung đầy đủ
```

## 🔍 SEO Friendly

### Meta tags
```jsp
<title><%= news.getTitle() %> - Thanh Niên</title>
```

### Semantic HTML
```html
<article class="article-container">
    <header class="article-header">
        <h1 class="article-title">...</h1>
    </header>
    <div class="article-body">
        <div class="article-content">...</div>
    </div>
</article>
```

## 🚀 Performance

### Optimization
- ✅ Single query để lấy full info (JOIN)
- ✅ Limit tin liên quan (TOP 5)
- ✅ Index trên categoryId, isActive
- ✅ Lazy load images (thuộc tính HTML)

### Caching (Future)
- 🔜 Cache bài báo phổ biến
- 🔜 Cache tin liên quan
- 🔜 CDN cho images

## 📝 Testing

### Test Cases
```
1. ✅ Xem bài báo hợp lệ
2. ✅ Xem bài báo không tồn tại (redirect home)
3. ✅ Xem bài báo đã xóa (redirect home)
4. ✅ ID không hợp lệ (redirect home)
5. ✅ View count tăng đúng
6. ✅ Tin liên quan hiển thị đúng
7. ✅ Share button hoạt động
8. ✅ Responsive trên mobile
```

## 🎉 Kết quả

✅ **Hoàn thành 100%** tính năng chi tiết bài báo

**Có thể:**
- Xem đầy đủ nội dung bài báo
- Tự động đếm lượt xem
- Xem tin liên quan
- Chia sẻ bài viết
- Responsive hoàn toàn
- Không cần đăng nhập

**Next steps:**
- Thêm comment system
- Thêm like/unlike
- Thêm bookmark
- Thêm social share buttons
- SEO optimization
