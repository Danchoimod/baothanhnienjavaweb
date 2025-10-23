<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bảng điều khiển - Admin</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="<%= request.getContextPath() %>/dashboard"><i class="fas fa-user-shield"></i> Admin</a>
    <div class="ml-auto">
      <a href="<%= request.getContextPath() %>/home" class="btn btn-outline-primary btn-sm"><i class="fas fa-home"></i> Trang chủ</a>
    </div>
  </nav>

  <div class="container my-4">
    <div class="row">
      <div class="col-md-4 mb-3">
        <a href="<%= request.getContextPath() %>/admin/users" class="card text-center p-4 text-decoration-none">
          <i class="fas fa-users" style="font-size:48px;color:#007bff;"></i>
          <h5 class="mt-3">Quản lý người dùng</h5>
          <p class="text-muted">Tổng: <strong><%= request.getAttribute("usersCount") %></strong></p>
        </a>
      </div>
      <div class="col-md-4 mb-3">
        <a href="<%= request.getContextPath() %>/admin/news" class="card text-center p-4 text-decoration-none">
          <i class="fas fa-newspaper" style="font-size:48px;color:#28a745;"></i>
          <h5 class="mt-3">Quản lý bài viết</h5>
          <p class="text-muted">Tổng: <strong><%= request.getAttribute("newsCount") %></strong></p>
        </a>
      </div>
      <div class="col-md-4 mb-3">
        <a href="<%= request.getContextPath() %>/admin/categories" class="card text-center p-4 text-decoration-none">
          <i class="fas fa-list" style="font-size:48px;color:#17a2b8;"></i>
          <h5 class="mt-3">Quản lý danh mục</h5>
          <p class="text-muted">Thêm/Sửa/Xóa danh mục</p>
        </a>
      </div>
      <div class="col-md-4 mb-3">
        <a href="<%= request.getContextPath() %>/admin/roles" class="card text-center p-4 text-decoration-none">
          <i class="fas fa-user-shield" style="font-size:48px;color:#ffc107;"></i>
          <h5 class="mt-3">Phân quyền</h5>
          <p class="text-muted">Gán quyền ADMIN/EDITOR/USER</p>
        </a>
      </div>
    </div>
  </div>
</body>
</html>
