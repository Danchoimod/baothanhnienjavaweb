<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.poly.entities.NewsEntity" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quản lý bài viết - Admin</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css">
</head>
<body>
  <div class="container my-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h3>Bài viết</h3>
      <div>
        <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-secondary btn-sm">Bảng điều khiển</a>
        <a href="<%= request.getContextPath() %>/home" class="btn btn-outline-primary btn-sm">Trang chủ</a>
      </div>
    </div>

    <div class="card">
      <div class="card-header">Danh sách tất cả bài viết</div>
      <div class="card-body p-0">
        <div class="table-responsive">
          <table class="table table-striped mb-0">
            <thead>
              <tr>
                <th>ID</th><th>Tiêu đề</th><th>Danh mục</th><th>Tác giả</th><th>Ngày tạo</th><th>Lượt xem</th><th>Trạng thái</th><th>Hành động</th>
              </tr>
            </thead>
            <tbody>
            <%
              List<NewsEntity> newsList = (List<NewsEntity>) request.getAttribute("newsList");
              if (newsList != null) {
                for (NewsEntity n : newsList) {
            %>
              <tr>
                <td><%= n.getId() %></td>
                <td style="max-width:300px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;">
                  <%= n.getTitle() %>
                </td>
                <td><%= n.getCategoryName() %></td>
                <td><%= n.getAuthorName() %></td>
                <td><%= n.getCreateDate() %></td>
                <td><%= n.getViewCount() %></td>
                <td>
                  <span class="badge <%= n.isActive() ? "badge-success" : "badge-secondary" %>">
                    <%= n.isActive() ? "Active" : "Inactive" %>
                  </span>
                </td>
                <td>
                  <a class="btn btn-sm btn-primary" href="<%= request.getContextPath() %>/news/edit?id=<%= n.getId() %>">Sửa</a>
                  <a class="btn btn-sm btn-danger" href="<%= request.getContextPath() %>/news/delete?id=<%= n.getId() %>" onclick="return confirm('Xóa bài viết này?')">Xóa</a>
                </td>
              </tr>
            <%
                }
              }
            %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
