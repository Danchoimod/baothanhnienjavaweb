<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.poly.entities.Users" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Chào mừng - Báo Thanh Niên</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #007bff;
            --dark: #0f172a;
        }
        html, body {
            height: 100%;
        }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e3f2ff 0%, #ffffff 60%);
            color: #334155;
        }
        .navbar {
            background: var(--primary);
        }
        .navbar .navbar-brand {
            color: #fff !important;
            font-weight: 800;
            letter-spacing: .5px;
        }
        .hero {
            min-height: calc(100vh - 64px);
            display: flex;
            align-items: center;
        }
        .hero-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(2, 6, 23, 0.08);
            overflow: hidden;
        }
        .hero-left {
            padding: 48px 40px;
        }
        .hero-title {
            font-size: 42px;
            line-height: 1.2;
            font-weight: 800;
            color: #0f172a;
        }
        .hero-subtitle {
            font-size: 18px;
            color: #64748b;
            margin: 16px 0 28px;
        }
        .cta .btn {
            padding: 12px 22px;
            border-radius: 10px;
            font-weight: 600;
        }
        .btn-go {
            background: var(--primary);
            border: none;
        }
        .btn-go:hover { background: #0056b3; }
        .btn-outline { border: 2px solid #e2e8f0; color: #0f172a; }
        .btn-outline:hover { background: #f8fafc; }
        .hero-right {
            background: linear-gradient(135deg, rgba(0,123,255,.1), rgba(0,123,255,.05));
            padding: 0;
        }
        .hero-art {
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 32px;
        }
        .hero-art img {
            width: 100%;
            max-width: 520px;
            filter: drop-shadow(0 20px 30px rgba(2,6,23,.1));
        }
        .quick-links {
            margin-top: 28px;
            color: #94a3b8;
            font-size: 14px;
        }
        .quick-links a { color: #64748b; text-decoration: none; }
        .quick-links a:hover { color: var(--primary); }
        @media (max-width: 991px) {
            .hero-title { font-size: 32px; }
            .hero-right { display: none; }
            .hero-left { padding: 32px 24px; }
        }
    </style>
    <%
        Users user = (Users) session.getAttribute("user");
        String ctx = request.getContextPath();
        String role = null;
        if (user != null) role = user.getRole();
    %>
    
</head>
<body>
    <!-- Top Nav -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="<%= ctx %>/home">
                <i class="fas fa-newspaper"></i> THANH NIÊN
            </a>
            <div class="ml-auto">
                <% if (user != null) { %>
                    <a class="btn btn-light btn-sm" href="<%= ctx %>/home">
                        <i class="fas fa-home"></i> Trang chủ
                    </a>
                <% } else { %>
                    <a class="btn btn-light btn-sm" href="<%= ctx %>/login">
                        <i class="fas fa-sign-in-alt"></i> Đăng nhập
                    </a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Hero -->
    <section class="hero">
        <div class="container">
            <div class="row hero-card">
                <div class="col-lg-7 hero-left">
                    <span class="badge badge-primary mb-3">
                        <i class="fas fa-bolt"></i> Chào mừng bạn
                    </span>
                    <h1 class="hero-title">Báo Thanh Niên - Cập nhật nhanh, chính xác và đáng tin cậy</h1>
                    <p class="hero-subtitle">Khám phá những tin tức mới nhất về thời sự, kinh tế, công nghệ, thể thao và nhiều hơn nữa.
                    </p>
                    <div class="cta d-flex flex-wrap align-items-center gap-2">
                        <a href="<%= ctx %>/home" class="btn btn-go text-white mr-2">
                            <i class="fas fa-arrow-right"></i> Vào trang chủ
                        </a>
                        <% if (user == null) { %>
                        <a href="<%= ctx %>/login" class="btn btn-outline">
                            <i class="fas fa-user"></i> Đăng nhập
                        </a>
                        <% } else { %>
                            <% if ("EDITOR".equals(role) || "ADMIN".equals(role)) { %>
                            <a href="<%= ctx %>/news/list" class="btn btn-outline">
                                <i class="fas fa-newspaper"></i> Quản lý tin tức
                            </a>
                            <% } else { %>
                            <a href="<%= ctx %>/profile" class="btn btn-outline">
                                <i class="fas fa-user"></i> Trang cá nhân
                            </a>
                            <% } %>
                        <% } %>
                    </div>
                    <div class="quick-links">
                        <i class="fas fa-link"></i> Liên kết nhanh:
                        <a class="ml-2" href="<%= ctx %>/home">Trang chủ</a> ·
                        <a href="<%= ctx %>/profile">Tài khoản</a> ·
                        <a href="<%= ctx %>/news/list">Tin của bạn</a>
                    </div>
                </div>
                <div class="col-lg-5 hero-right">
                    <div class="hero-art">
                        <img src="https://images.unsplash.com/photo-1444653614773-995cb1ef9efa?q=80&w=1200&auto=format&fit=crop" alt="News Illustration">
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer class="text-center text-muted py-4">
        <div class="container">
            <small>&copy; <%= new java.util.GregorianCalendar().get(java.util.Calendar.YEAR) %> Báo Thanh Niên. All rights reserved.</small>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
