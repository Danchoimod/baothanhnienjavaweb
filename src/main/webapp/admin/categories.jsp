<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.poly.entities.Category" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quản lý danh mục - Admin</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css">
</head>
<body>
  <div class="container my-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h3>Danh mục</h3>
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
      <div class="card-header">Tạo danh mục</div>
      <div class="card-body">
        <form action="<%= request.getContextPath() %>/admin/categories" method="post">
          <input type="hidden" name="action" value="create">
          <div class="form-row">
            <div class="form-group col-md-4">
              <label>Tên danh mục</label>
              <input type="text" name="name" class="form-control" required>
            </div>
            <div class="form-group col-md-8">
              <label>Mô tả</label>
              <input type="text" name="description" class="form-control">
            </div>
          </div>
          <button class="btn btn-primary">Thêm danh mục</button>
        </form>
      </div>
    </div>

    <div class="card">
      <div class="card-header">Danh sách danh mục</div>
      <div class="card-body p-0">
        <div class="table-responsive">
          <table class="table table-striped mb-0">
            <thead>
              <tr>
                <th>ID</th>
                <th>Tên</th>
                <th>Mô tả</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
              </tr>
            </thead>
            <tbody>
            <%
              List<Category> categories = (List<Category>) request.getAttribute("categories");
              if (categories != null) {
                for (Category c : categories) {
            %>
              <tr>
                <td><%= c.getId() %></td>
                <td>
                  <form class="form-inline" action="<%= request.getContextPath() %>/admin/categories" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="<%= c.getId() %>">
                    <input type="text" name="name" value="<%= c.getName() %>" class="form-control form-control-sm mr-2" required>
                    <input type="text" name="description" value="<%= c.getDescription() != null ? c.getDescription() : "" %>" class="form-control form-control-sm mr-2" style="min-width: 250px">
                    <div class="form-check mr-2">
                      <input class="form-check-input" type="checkbox" name="isActive" <%= c.isActive() ? "checked" : "" %> id="active_<%= c.getId() %>">
                      <label class="form-check-label" for="active_<%= c.getId() %>">Active</label>
                    </div>
                    <button class="btn btn-sm btn-primary">Lưu</button>
                  </form>
                </td>
                <td colspan="2"></td>
                <td>
                  <form action="<%= request.getContextPath() %>/admin/categories" method="post" style="display:inline" onsubmit="return confirm('Xóa vĩnh viễn danh mục này? Hành động không thể hoàn tác!');">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= c.getId() %>">
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
