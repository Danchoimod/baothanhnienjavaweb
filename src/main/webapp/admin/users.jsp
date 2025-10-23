<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.poly.entities.Users" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quản lý người dùng - Admin</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css">
</head>
<body>
  <div class="container my-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h3>Người dùng</h3>
      <div>
        <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-secondary btn-sm">Bảng điều khiển</a>
        <a href="<%= request.getContextPath() %>/home" class="btn btn-outline-primary btn-sm">Trang chủ</a>
      </div>
    </div>

    <% if (request.getAttribute("success") != null) { %>
      <div class="alert alert-success"><%= request.getAttribute("success") %></div>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
      <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <div class="card mb-4">
      <div class="card-header">Tạo người dùng</div>
      <div class="card-body">
        <form action="<%= request.getContextPath() %>/admin/users" method="post">
          <div class="form-row">
            <div class="form-group col-md-3">
              <label>Tên đăng nhập</label>
              <input type="text" name="username" class="form-control" required minlength="4">
            </div>
            <div class="form-group col-md-3">
              <label>Mật khẩu</label>
              <input type="password" name="password" class="form-control" required minlength="6">
            </div>
            <div class="form-group col-md-3">
              <label>Email</label>
              <input type="email" name="email" class="form-control" required>
            </div>
            <div class="form-group col-md-3">
              <label>Họ tên</label>
              <input type="text" name="fullname" class="form-control" required>
            </div>
          </div>
          <div class="form-row">
            <div class="form-group col-md-3">
              <label>Điện thoại</label>
              <input type="text" name="phone" class="form-control">
            </div>
            <div class="form-group col-md-3">
              <label>Địa chỉ</label>
              <input type="text" name="address" class="form-control">
            </div>
            <div class="form-group col-md-3">
              <label>Ngày sinh</label>
              <input type="date" name="birthDate" class="form-control">
            </div>
            <!-- Vai trò được quản lý tại trang Phân quyền -->
            <div class="form-group col-md-1">
              <label>Active</label>
              <input type="checkbox" name="isActive" class="form-control" checked>
            </div>
          </div>
          <button class="btn btn-primary">Tạo người dùng</button>
        </form>
      </div>
    </div>

    <div class="card">
      <div class="card-header d-flex justify-content-between align-items-center">
        <span>Danh sách người dùng</span>
        <div>
          <a href="<%= request.getContextPath() %>/admin/roles" class="btn btn-sm btn-outline-secondary">Phân quyền</a>
        </div>
      </div>
      <div class="card-body p-0">
        <div class="table-responsive">
          <table class="table table-striped mb-0">
            <thead>
              <tr>
                <th>ID</th><th>Username</th><th>Họ tên</th><th>Email</th><th>Quyền</th><th>Active</th><th>Ngày tạo</th><th>Hành động</th>
              </tr>
            </thead>
            <tbody>
            <%
              List<Users> users = (List<Users>) request.getAttribute("users");
              if (users != null) {
                for (Users u : users) {
            %>
              <tr>
                <td><%= u.getId() %></td>
                <td><%= u.getUsername() %></td>
                <td>
                  <form action="<%= request.getContextPath() %>/admin/users" method="post" class="form-inline">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="<%= u.getId() %>">
                    <input type="text" name="fullname" value="<%= u.getFullname() %>" class="form-control form-control-sm">
                </td>
                <td>
                    <input type="email" name="email" value="<%= u.getEmail() %>" class="form-control form-control-sm">
                </td>
                <td>
                    <span class="badge badge-info"><%= u.getRole() %></span>
                </td>
                <td>
                    <input type="checkbox" name="isActive" <%= u.isActive() ? "checked" : "" %>>
                </td>
                <td><%= u.getCreateDate() %></td>
                <td>
                    <input type="hidden" name="phone" value="<%= u.getPhone() != null ? u.getPhone() : "" %>">
                    <input type="hidden" name="address" value="<%= u.getAddress() != null ? u.getAddress() : "" %>">
                    <input type="hidden" name="birthDate" value="<%= u.getBirthDate() != null ? u.getBirthDate().toString() : "" %>">
                    <button class="btn btn-sm btn-primary">Lưu</button>
                  </form>
                  <form action="<%= request.getContextPath() %>/admin/users" method="post" style="display:inline" onsubmit="return confirm('Vô hiệu hóa người dùng này?');">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= u.getId() %>">
                    <button class="btn btn-sm btn-outline-danger">Xóa</button>
                  </form>
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
