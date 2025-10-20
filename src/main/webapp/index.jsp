<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

<head>
    <meta charset="UTF-8" />
    <title>Trang chủ Java3Demo</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        .navbar-brand {
            font-size: 24px;
            letter-spacing: 1px;
        }
        .bg-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%) !important;
        }
        .card {
            border: none;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .nav-link {
            margin-right: 10px;
            transition: color 0.3s ease;
        }
        .nav-link:hover {
            color: #0ea5e9 !important;
        }
    </style>
</head>
<body>
<!-- Header Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <div class="container">
        <!-- Brand/Logo -->
        <a class="navbar-brand font-weight-bold" href="index.jsp">
            <i class="fas fa-shopping-cart"></i> Java3Demo
        </a>
        
        <!-- Hamburger Menu -->
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <!-- Navigation Menu -->
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="index.jsp">Trang chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="products/add">Sản phẩm</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#about">Về chúng tôi</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#contact">Liên hệ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link btn btn-primary text-white ml-2" href="#login">Đăng nhập</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section / Banner -->
<div class="bg-primary text-white py-5">
    <div class="container">
        <h1 class="display-4 font-weight-bold">Chào mừng đến với Java3Demo</h1>
        <p class="lead">Quản lý sản phẩm dễ dàng và hiệu quả</p>
        <a href="products/add" class="btn btn-light btn-lg mt-3">
            <i class="fas fa-plus"></i> Thêm sản phẩm mới
        </a>
    </div>
</div>

<!-- Main Content -->
<div class="container my-5">
    <div class="row">
        <div class="col-md-12">
            <h2>Tính năng chính</h2>
            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">📦 Quản lý sản phẩm</h5>
                            <p class="card-text">Thêm, sửa, xóa sản phẩm một cách dễ dàng</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">⚙️ Quản lý danh mục</h5>
                            <p class="card-text">Tổ chức sản phẩm theo các danh mục khác nhau</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">📊 Thống kê</h5>
                            <p class="card-text">Xem thống kê chi tiết về sản phẩm</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
