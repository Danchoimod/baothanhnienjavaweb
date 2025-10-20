<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.poly.entities.NewsEntity" %>
<%@ page import="java.util.List" %>
<%
    NewsEntity news = (NewsEntity) request.getAttribute("news");
    List<NewsEntity> relatedNews = (List<NewsEntity>) request.getAttribute("relatedNews");
    
    if (news == null) {
        response.sendRedirect(request.getContextPath() + "/home");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= news.getTitle() %> - Thanh Niên</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .navbar {
            background-color: #007bff;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
        }
        
        .navbar-brand {
            color: white !important;
            font-weight: bold;
            font-size: 28px;
            letter-spacing: 1px;
        }
        
        .navbar-brand:hover {
            color: #f8f9fa !important;
        }
        
        .content-wrapper {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 15px;
        }
        
        .article-container {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            overflow: hidden;
        }
        
        .article-header {
            padding: 30px;
            border-bottom: 1px solid #e9ecef;
        }
        
        .article-category {
            display: inline-block;
            background-color: #007bff;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 14px;
            margin-bottom: 15px;
        }
        
        .article-title {
            font-size: 32px;
            font-weight: bold;
            line-height: 1.4;
            color: #333;
            margin-bottom: 15px;
        }
        
        .article-summary {
            font-size: 18px;
            color: #666;
            line-height: 1.6;
            font-weight: 500;
            margin-bottom: 20px;
        }
        
        .article-meta {
            display: flex;
            align-items: center;
            gap: 20px;
            color: #999;
            font-size: 14px;
            padding-top: 15px;
            border-top: 1px solid #e9ecef;
        }
        
        .article-meta i {
            margin-right: 5px;
        }
        
        .article-image {
            width: 100%;
            max-height: 500px;
            object-fit: cover;
        }
        
        .article-body {
            padding: 30px;
        }
        
        .article-content {
            font-size: 16px;
            line-height: 1.8;
            color: #333;
            text-align: justify;
        }
        
        .article-content p {
            margin-bottom: 20px;
        }
        
        .article-actions {
            padding: 20px 30px;
            border-top: 1px solid #e9ecef;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            gap: 10px;
        }
        
        .btn-action {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        .btn-action:hover {
            background-color: #f8f9fa;
            border-color: #007bff;
            color: #007bff;
        }
        
        .btn-action i {
            font-size: 18px;
        }
        
        .related-news {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            padding: 30px;
            margin-top: 30px;
        }
        
        .related-news h3 {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #007bff;
        }
        
        .related-news-item {
            display: flex;
            gap: 15px;
            padding: 15px 0;
            border-bottom: 1px solid #e9ecef;
            transition: all 0.3s;
        }
        
        .related-news-item:last-child {
            border-bottom: none;
        }
        
        .related-news-item:hover {
            background-color: #f8f9fa;
            padding-left: 10px;
        }
        
        .related-news-image {
            width: 150px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
            flex-shrink: 0;
        }
        
        .related-news-content {
            flex: 1;
        }
        
        .related-news-title {
            font-size: 16px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            line-height: 1.4;
        }
        
        .related-news-title a {
            color: #333;
            text-decoration: none;
        }
        
        .related-news-title a:hover {
            color: #007bff;
        }
        
        .related-news-meta {
            color: #999;
            font-size: 13px;
        }
        
        .sidebar {
            position: sticky;
            top: 20px;
        }
        
        .sidebar-section {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        
        .sidebar-section h4 {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #007bff;
        }
        
        .sidebar-news-item {
            padding: 10px 0;
            border-bottom: 1px solid #e9ecef;
        }
        
        .sidebar-news-item:last-child {
            border-bottom: none;
        }
        
        .sidebar-news-item h6 {
            font-size: 14px;
            line-height: 1.4;
            margin-bottom: 5px;
        }
        
        .sidebar-news-item a {
            color: #333;
            text-decoration: none;
        }
        
        .sidebar-news-item a:hover {
            color: #007bff;
        }
        
        .sidebar-news-item .meta {
            color: #999;
            font-size: 12px;
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
        
        .back-button {
            display: inline-block;
            color: #007bff;
            text-decoration: none;
            margin-bottom: 20px;
            padding: 8px 15px;
            border: 1px solid #007bff;
            border-radius: 5px;
            transition: all 0.3s;
        }
        
        .back-button:hover {
            background-color: #007bff;
            color: white;
            text-decoration: none;
        }
        
        @media (max-width: 768px) {
            .article-title {
                font-size: 24px;
            }
            
            .article-summary {
                font-size: 16px;
            }
            
            .related-news-image {
                width: 100px;
                height: 70px;
            }
            
            .sidebar {
                position: relative;
                margin-top: 30px;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/home">
                <i class="fas fa-newspaper"></i> THANH NIÊN
            </a>
            <div class="ml-auto">
                <% if (session.getAttribute("user") != null) { 
                    String role = (String) session.getAttribute("role");
                %>
                <div class="user-dropdown">
                    <div class="user-info" onclick="toggleDropdown()">
                        <i class="fas fa-user-circle"></i> <%= session.getAttribute("fullname") %>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="dropdown-menu-custom" id="userDropdown">
                        <a href="<%= request.getContextPath() %>/home">
                            <i class="fas fa-home"></i> Trang chủ
                        </a>
                        <a href="<%= request.getContextPath() %>/profile">
                            <i class="fas fa-user"></i> Trang cá nhân
                        </a>
                        <% if ("EDITOR".equals(role) || "ADMIN".equals(role)) { %>
                        <a href="<%= request.getContextPath() %>/news/list">
                            <i class="fas fa-newspaper"></i> Quản lý tin tức
                        </a>
                        <% } %>
                        <a href="<%= request.getContextPath() %>/logout">
                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                        </a>
                    </div>
                </div>
                <% } else { %>
                <a href="<%= request.getContextPath() %>/login" class="user-info" style="text-decoration: none;">
                    <i class="fas fa-user"></i> Đăng nhập
                </a>
                <% } %>
            </div>
        </div>
    </nav>

    <div class="content-wrapper">
        <a href="<%= request.getContextPath() %>/home" class="back-button">
            <i class="fas fa-arrow-left"></i> Quay lại trang chủ
        </a>

        <div class="row">
            <div class="col-lg-8">
                <!-- Article -->
                <article class="article-container">
                    <!-- Header -->
                    <div class="article-header">
                        <span class="article-category">
                            <i class="fas fa-folder"></i> <%= news.getCategoryName() %>
                        </span>
                        <h1 class="article-title"><%= news.getTitle() %></h1>
                        
                        <% if (news.getSummary() != null && !news.getSummary().isEmpty()) { %>
                        <div class="article-summary">
                            <%= news.getSummary() %>
                        </div>
                        <% } %>
                        
                        <div class="article-meta">
                            <span><i class="fas fa-user"></i> <%= news.getAuthorName() %></span>
                            <span><i class="fas fa-calendar"></i> <%= news.getCreateDate() %></span>
                            <span><i class="fas fa-eye"></i> <%= news.getViewCount() %> lượt xem</span>
                        </div>
                    </div>

                    <!-- Image -->
                    <% if (news.getImage() != null && !news.getImage().isEmpty()) { %>
                    <img src="<%= news.getImage() %>" alt="<%= news.getTitle() %>" class="article-image">
                    <% } %>

                    <!-- Content -->
                    <div class="article-body">
                        <div class="article-content">
                            <%= news.getContent().replace("\n", "<br>") %>
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="article-actions">
                        <button class="btn-action" onclick="alert('Chức năng đang phát triển')">
                            <i class="far fa-thumbs-up"></i>
                            <span>Thích</span>
                        </button>
                        <button class="btn-action" onclick="alert('Chức năng đang phát triển')">
                            <i class="far fa-comment"></i>
                            <span>Bình luận</span>
                        </button>
                        <button class="btn-action" onclick="shareArticle()">
                            <i class="fas fa-share"></i>
                            <span>Chia sẻ</span>
                        </button>
                        <button class="btn-action" onclick="alert('Chức năng đang phát triển')">
                            <i class="far fa-bookmark"></i>
                            <span>Lưu</span>
                        </button>
                    </div>
                </article>

                <!-- Related News -->
                <% if (relatedNews != null && !relatedNews.isEmpty()) { %>
                <div class="related-news">
                    <h3><i class="fas fa-newspaper"></i> Tin liên quan</h3>
                    <% for (NewsEntity related : relatedNews) { %>
                    <div class="related-news-item">
                        <% if (related.getImage() != null && !related.getImage().isEmpty()) { %>
                        <img src="<%= related.getImage() %>" alt="<%= related.getTitle() %>" class="related-news-image">
                        <% } else { %>
                        <img src="https://via.placeholder.com/150x100?text=No+Image" alt="No Image" class="related-news-image">
                        <% } %>
                        <div class="related-news-content">
                            <h5 class="related-news-title">
                                <a href="<%= request.getContextPath() %>/news/detail?id=<%= related.getId() %>">
                                    <%= related.getTitle() %>
                                </a>
                            </h5>
                            <div class="related-news-meta">
                                <i class="fas fa-calendar"></i> <%= related.getCreateDate() %> | 
                                <i class="fas fa-eye"></i> <%= related.getViewCount() %> lượt xem
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
                <% } %>
            </div>

            <!-- Sidebar -->
            <div class="col-lg-4">
                <div class="sidebar">
                    <!-- Most Viewed -->
                    <% if (relatedNews != null && !relatedNews.isEmpty()) { %>
                    <div class="sidebar-section">
                        <h4><i class="fas fa-fire"></i> Tin xem nhiều</h4>
                        <% for (int i = 0; i < Math.min(relatedNews.size(), 5); i++) {
                            NewsEntity popular = relatedNews.get(i);
                        %>
                        <div class="sidebar-news-item">
                            <h6>
                                <a href="<%= request.getContextPath() %>/news/detail?id=<%= popular.getId() %>">
                                    <%= popular.getTitle() %>
                                </a>
                            </h6>
                            <div class="meta">
                                <i class="fas fa-eye"></i> <%= popular.getViewCount() %> lượt xem
                            </div>
                        </div>
                        <% } %>
                    </div>
                    <% } %>

                    <!-- Advertisement -->
                    <div class="sidebar-section">
                        <img src="https://via.placeholder.com/350x250?text=Quảng+cáo" class="img-fluid w-100" style="border-radius: 5px;">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <script>
        function toggleDropdown() {
            document.getElementById('userDropdown').classList.toggle('show');
        }

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

        function shareArticle() {
            const url = window.location.href;
            const title = '<%= news.getTitle() %>';
            
            if (navigator.share) {
                navigator.share({
                    title: title,
                    url: url
                }).catch(err => console.log('Error sharing:', err));
            } else {
                // Fallback: Copy to clipboard
                navigator.clipboard.writeText(url).then(() => {
                    alert('Đã copy link bài viết!');
                });
            }
        }
    </script>
</body>
</html>
