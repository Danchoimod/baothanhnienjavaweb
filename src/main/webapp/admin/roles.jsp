<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.poly.entities.Users" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Phân quyền - Admin</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css">
</head>
<body>
  <div class="container my-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h3>Phân quyền người dùng</h3>
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

    <div class="card">
      <div class="card-body p-0">
        <div class="table-responsive">
          <table class="table table-striped mb-0">
            <thead>
              <tr>
                <th>ID</th>
                <th>Tên đăng nhập</th>
                <th>Họ tên</th>
                <th>Email</th>
                <th>Quyền hiện tại</th>
                <th>Đổi quyền</th>
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
                <td><%= u.getFullname() %></td>
                <td><%= u.getEmail() %></td>
                <td><span class="badge badge-info"><%= u.getRole() %></span></td>
                <td>
                  <form class="form-inline" action="<%= request.getContextPath() %>/admin/roles" method="post">
                    <input type="hidden" name="id" value="<%= u.getId() %>">
                    <select name="role" class="form-control form-control-sm mr-2">
                      <option value="USER" <%= "USER".equals(u.getRole()) ? "selected" : "" %>>USER</option>
                      <option value="EDITOR" <%= "EDITOR".equals(u.getRole()) ? "selected" : "" %>>EDITOR</option>
                      <option value="ADMIN" <%= "ADMIN".equals(u.getRole()) ? "selected" : "" %>>ADMIN</option>
                    </select>
                    <button class="btn btn-sm btn-primary">Cập nhật</button>
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
