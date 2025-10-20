<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.poly.entities.NewsEntity" %>
<%@ page import="com.poly.entities.Users" %>
<%
    Users user = (Users) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    String role = user.getRole();
    if (!"EDITOR".equals(role) && !"ADMIN".equals(role)) {
        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này!");
        return;
    }
    
    List<NewsEntity> newsList = (List<NewsEntity>) request.getAttribute("newsList");
    String success = request.getParameter("success");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý tin tức - Thanh Niên</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        
        .navbar {
            background-color: #007bff;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
        }
        
        .navbar-brand {
            color: white !important;
            font-weight: bold;
            font-size: 24px;
        }
        
        .navbar-brand:hover {
            color: #f8f9fa !important;
        }
        
        .content-wrapper {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 15px;
        }
        
        .page-header {
            background: white;
            padding: 20px 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .page-header h2 {
            margin: 0;
            color: #333;
        }
        
        .btn-create {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .btn-create:hover {
            background-color: #0056b3;
            color: white;
            text-decoration: none;
        }
        
        .news-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            margin-bottom: 20px;
            overflow: hidden;
            transition: all 0.3s;
        }
        
        .news-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,.15);
            transform: translateY(-2px);
        }
        
        .news-card-body {
            padding: 20px;
        }
        
        .news-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        
        .news-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }
        
        .news-summary {
            color: #666;
            font-size: 14px;
            margin-bottom: 15px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .news-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 13px;
            color: #999;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .news-actions {
            display: flex;
            gap: 10px;
        }
        
        .btn-edit, .btn-delete {
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .btn-edit {
            background-color: #28a745;
            color: white;
        }
        
        .btn-edit:hover {
            background-color: #218838;
            color: white;
            text-decoration: none;
        }
        
        .btn-delete {
            background-color: #dc3545;
            color: white;
            border: none;
            cursor: pointer;
        }
        
        .btn-delete:hover {
            background-color: #c82333;
        }
        
        .empty-state {
            background: white;
            padding: 60px 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            text-align: center;
        }
        
        .empty-state i {
            font-size: 64px;
            color: #ddd;
            margin-bottom: 20px;
        }
        
        .empty-state p {
            color: #999;
            font-size: 16px;
            margin-bottom: 20px;
        }
        
        .user-dropdown {
            position: relative;
            display: inline-block;
        }
        
        .user-info {
            background-color: white;
            color: #007bff;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .user-info:hover {
            background-color: #f8f9fa;
        }
        
        .user-info i {
            margin-left: 5px;
        }
        
        .dropdown-menu-custom {
            display: none;
            position: absolute;
            right: 0;
            top: 100%;
            margin-top: 5px;
            background-color: white;
            min-width: 200px;
            box-shadow: 0 2px 10px rgba(0,0,0,.15);
            border-radius: 5px;
            z-index: 1000;
        }
        
        .dropdown-menu-custom.show {
            display: block;
        }
        
        .dropdown-menu-custom a {
            display: block;
            padding: 10px 20px;
            color: #333;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .dropdown-menu-custom a:hover {
            background-color: #f8f9fa;
        }
        
        .dropdown-menu-custom a i {
            margin-right: 10px;
            width: 20px;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/home">
                <i class="fas fa-newspaper"></i> Thanh Niên
            </a>
            <div class="ml-auto">
                <div class="user-dropdown">
                    <div class="user-info" onclick="toggleDropdown()">
                        <i class="fas fa-user-circle"></i> <%= user.getFullname() %>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="dropdown-menu-custom" id="userDropdown">
                        <a href="<%= request.getContextPath() %>/home">
                            <i class="fas fa-home"></i> Trang chủ
                        </a>
                        <a href="<%= request.getContextPath() %>/profile">
                            <i class="fas fa-user"></i> Trang cá nhân
                        </a>
                        <a href="<%= request.getContextPath() %>/news/list">
                            <i class="fas fa-newspaper"></i> Quản lý tin tức
                        </a>
                        <a href="<%= request.getContextPath() %>/logout">
                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <div class="content-wrapper">
        <!-- Page Header -->
        <div class="page-header">
            <h2><i class="fas fa-list"></i> Quản lý tin tức</h2>
            <a href="<%= request.getContextPath() %>/news/create" class="btn-create">
                <i class="fas fa-plus"></i> Đăng tin mới
            </a>
        </div>

        <!-- Success Message -->
        <% if (success != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle"></i>
                <% if ("create".equals(success)) { %>
                    Đăng tin tức thành công!
                <% } else if ("update".equals(success)) { %>
                    Cập nhật tin tức thành công!
                <% } else if ("delete".equals(success)) { %>
                    Xóa tin tức thành công!
                <% } %>
                <button type="button" class="close" data-dismiss="alert">
                    <span>&times;</span>
                </button>
            </div>
        <% } %>

        <!-- News List -->
        <% if (newsList != null && !newsList.isEmpty()) { %>
            <div class="row">
                <% for (NewsEntity news : newsList) { %>
                    <div class="col-md-6">
                        <div class="news-card">
                            <% if (news.getImage() != null && !news.getImage().isEmpty()) { %>
                                <img src="<%= news.getImage() %>" alt="<%= news.getTitle() %>" class="news-image">
                            <% } %>
                            <div class="news-card-body">
                                <h3 class="news-title"><%= news.getTitle() %></h3>
                                <div class="news-meta">
                                    <span><i class="fas fa-folder"></i> <%= news.getCategoryName() %></span>
                                    <span><i class="fas fa-eye"></i> <%= news.getViewCount() %> lượt xem</span>
                                    <span><i class="fas fa-calendar"></i> <%= news.getCreateDate() %></span>
                                </div>
                                <p class="news-summary"><%= news.getSummary() %></p>
                                <div class="news-actions">
                                    <a href="<%= request.getContextPath() %>/news/edit?id=<%= news.getId() %>" class="btn-edit">
                                        <i class="fas fa-edit"></i> Sửa
                                    </a>
                                    <button class="btn-delete" onclick="confirmDelete(<%= news.getId() %>)">
                                        <i class="fas fa-trash"></i> Xóa
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } else { %>
            <div class="empty-state">
                <i class="fas fa-newspaper"></i>
                <p>Bạn chưa đăng tin tức nào</p>
                <a href="<%= request.getContextPath() %>/news/create" class="btn-create">
                    <i class="fas fa-plus"></i> Đăng tin mới
                </a>
            </div>
        <% } %>
    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <script>
        function toggleDropdown() {
            document.getElementById('userDropdown').classList.toggle('show');
        }

        // Đóng dropdown khi click bên ngoài
        window.onclick = function(event) {
            if (!event.target.matches('.user-info') && !event.target.closest('.user-info')) {
                var dropdowns = document.getElementsByClassName("dropdown-menu-custom");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }
        }

        function confirmDelete(newsId) {
            if (confirm('Bạn có chắc chắn muốn xóa tin tức này?')) {
                window.location.href = '<%= request.getContextPath() %>/news/delete?id=' + newsId;
            }
        }
    </script>
</body>
</html>
