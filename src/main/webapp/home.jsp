<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tin tức - Java3 News</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        .navbar-brand {
            font-size: 24px;
            letter-spacing: 1px;
            font-weight: bold;
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
        .news-category-nav {
            display: flex;
            border-bottom: 2px solid #007bff;
            overflow-x: auto;
            padding: 0;
            margin: 0;
        }
        .news-category-nav a {
            color: #333;
            text-decoration: none;
            padding: 12px 20px;
            border-bottom: 3px solid transparent;
            white-space: nowrap;
            transition: all 0.3s ease;
        }
        .news-category-nav a:hover,
        .news-category-nav a.active {
            color: #007bff;
            border-bottom-color: #007bff;
        }
        .main-featured-news {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }
        .main-featured-news img {
            width: 40%;
            height: 300px;
            object-fit: cover;
            border-radius: 8px;
        }
        .main-featured-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .main-featured-content h2 {
            font-size: 28px;
            font-weight: bold;
            line-height: 1.4;
            color: #333;
            margin-bottom: 15px;
        }
        .news-meta {
            color: #999;
            font-size: 13px;
            margin-bottom: 12px;
        }
        .secondary-news-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        .secondary-news-card {
            border: none;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .secondary-news-card img {
            height: 150px;
            object-fit: cover;
        }
        .secondary-news-card h5 {
            font-size: 15px;
            line-height: 1.4;
            font-weight: 600;
            min-height: 45px;
        }
        @media (max-width: 768px) {
            .main-featured-news {
                flex-direction: column;
            }
            .main-featured-news img {
                width: 100%;
            }
            .secondary-news-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 576px) {
            .secondary-news-grid {
                grid-template-columns: 1fr;
            }
        }
        .breaking-news {
            background-color: #f0f0f0;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #dc3545;
        }
        .breaking-news-label {
            color: #dc3545;
            font-weight: bold;
            font-size: 12px;
            text-transform: uppercase;
            margin-bottom: 8px;
        }
        .sidebar-section-title {
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 15px;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }
        .sidebar-news-item {
            padding: 12px 0;
            border-bottom: 1px solid #e9ecef;
        }
        .sidebar-news-item:last-child {
            border-bottom: none;
        }
        .sidebar-news-item h6 {
            font-size: 13px;
            font-weight: 600;
            line-height: 1.4;
            margin: 0;
        }
        .sidebar-news-item .meta {
            color: #999;
            font-size: 12px;
            margin-top: 5px;
        }
        .sidebar-news-item a {
            color: #333;
            text-decoration: none;
        }
        .sidebar-news-item a:hover {
            color: #007bff;
        }
        /* Modal Styles */
        .modal-header {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
            border: none;
        }
        .modal-header .close {
            color: white;
        }
        .nav-tabs .nav-link {
            color: #333;
            border: none;
            border-bottom: 3px solid transparent;
        }
        .nav-tabs .nav-link.active {
            color: #007bff;
            border-bottom: 3px solid #007bff;
            background-color: transparent;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }
        .btn-login {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            border: none;
            padding: 10px 20px;
            font-weight: 600;
        }
        .btn-login:hover {
            background: linear-gradient(135deg, #0056b3 0%, #003d82 100%);
            color: white;
        }
    </style>
</head>
<body>
    <!-- Header Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom sticky-top">
        <div class="container">
            <!-- Brand/Logo -->
            <a class="navbar-brand font-weight-bold" href="home" style="font-size: 32px; color: #007bff;">
                THANH NIÊN
            </a>
            
            <!-- Search -->
            <form class="form-inline mx-auto" style="flex: 1; max-width: 400px;">
                <input class="form-control w-100" type="search" placeholder=" Tìm kiếm">
            </form>

            <!-- Right Icons -->
            <div class="ml-3">
                <a href="#" class="btn btn-sm btn-light mr-2">
                    <i class="fas fa-podcast"></i> PODCAST
                </a>
                <a href="#" class="btn btn-sm btn-light mr-2">
                    <i class="fas fa-bullhorn"></i> QUẢNG CÁO
                </a>
                <a href="#" class="btn btn-sm btn-light mr-2">
                    <i class="fas fa-newspaper"></i> DẶT BÁO
                </a>
                
                <% if (session.getAttribute("user") != null) { %>
                    <!-- User logged in -->
                    <div class="dropdown d-inline-block">
                        <a href="profile" class="btn btn-sm btn-primary dropdown-toggle" type="button" id="userDropdown" data-toggle="dropdown">
                            <i class="fas fa-user"></i> <%= session.getAttribute("fullname") %>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right">
                            <a class="dropdown-item" href="profile"><i class="fas fa-user-circle"></i> Tài khoản</a>
                            <a class="dropdown-item" href="#"><i class="fas fa-cog"></i> Cài đặt</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item text-danger" href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                        </div>
                    </div>
                <% } else { %>
                    <!-- User not logged in -->
                    <a href="login" class="btn btn-sm btn-primary">
                        <i class="fas fa-user"></i> ĐĂNG NHẬP
                    </a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Category Navigation -->
    <div class="bg-white border-bottom">
        <div class="container">
            <div class="news-category-nav">
                <a href="#" class="active"> Chính trị</a>
                <a href="#">Thời sự</a>
                <a href="#">Thế giới</a>
                <a href="#">Kinh tế</a>
                <a href="#">Đối sống</a>
                <a href="#">Sức khỏe</a>
                <a href="#">Giới trẻ</a>

            </div>
        </div>
    </div>

    <!-- Hero Section / Banner -->
    <div class="bg-white py-3">
        <div class="container">
            <img src="https://via.placeholder.com/1200x100?text=Quảng+cáo+banner" class="img-fluid w-100" style="border-radius: 5px;">
        </div>
    </div>

    <!-- Main Content -->
    <div class="container my-4">
        <div class="row">
            <div class="col-lg-8">
                <!-- Breaking News -->
                <div class="breaking-news">
                    <div class="breaking-news-label">🔴 TIN NÓNG</div>
                    <h5 class="mb-0">Cử tri lo ngại trước biến động giá vàng, bất động sản</h5>
                    <div class="news-meta mt-2">
                        <i class="far fa-clock"></i> 2 giờ trước
                    </div>
                </div>

                <!-- Main Featured News -->
                <div class="main-featured-news">
                    <img src="https://via.placeholder.com/600x300?text=Tin+nổi+bật" alt="Featured">
                    <div class="main-featured-content">
                        <h2>Cử tri lo ngại trước biến động giá vàng, bất động sản</h2>
                        <div class="news-meta">
                            <i class="far fa-calendar"></i> Thứ Hai, 20/10/2025 | 
                            <i class="far fa-user"></i> Báo Thanh Niên
                        </div>
                        <p class="text-muted">Cử tri và nhân dân lo ngại về tác động của làm phát toàn cầu, cùng với sự biến động khó lường của giá vàng và bất động sản, những vấn đề được bàn tán sôi nổi trong cộng đồng.</p>
                        <a href="#" class="btn btn-primary btn-sm">Đọc tiếp</a>
                    </div>
                </div>

                <!-- Secondary News Grid -->
                <h5 class="mb-4">Tin khác</h5>
                <div class="secondary-news-grid">
                    <div class="card secondary-news-card">
                        <img src="https://via.placeholder.com/400x150?text=Tin+1" class="card-img-top">
                        <div class="card-body p-3">
                            <span class="badge badge-info mb-2">CHÍNH TRỊ</span>
                            <h5 class="card-title"><a href="#">Hợp tác quốc phòng Việt Nam – Belarus còn dư địa phát triển</a></h5>
                            <div class="news-meta">
                                <i class="far fa-clock"></i> 1 giờ trước
                            </div>
                        </div>
                    </div>

                    <div class="card secondary-news-card">
                        <img src="https://via.placeholder.com/400x150?text=Tin+2" class="card-img-top">
                        <div class="card-body p-3">
                            <span class="badge badge-success mb-2">KINH TẾ</span>
                            <h5 class="card-title"><a href="#">Đề nghị doanh nghiệp hoạt động ở nơi nào thì nộp thuế tại nơi đó</a></h5>
                            <div class="news-meta">
                                <i class="far fa-clock"></i> 3 giờ trước
                            </div>
                        </div>
                    </div>

                    <div class="card secondary-news-card">
                        <img src="https://via.placeholder.com/400x150?text=Tin+3" class="card-img-top">
                        <div class="card-body p-3">
                            <span class="badge badge-warning mb-2">XÃ HỘI</span>
                            <h5 class="card-title"><a href="#">Đề xuất chi thụ nhập thêm cho hơn 1.500 viên chức Bảo hiểm xã hội TP.HCM</a></h5>
                            <div class="news-meta">
                                <i class="far fa-clock"></i> 4 giờ trước
                            </div>
                        </div>
                    </div>
                </div>

                <!-- More News -->
                <div class="row">
                    <div class="col-md-6 mb-4">
                        <div class="card secondary-news-card h-100">
                            <img src="https://via.placeholder.com/400x150?text=Tin+4" class="card-img-top">
                            <div class="card-body p-3">
                                <span class="badge badge-secondary mb-2">THỜI SỰ</span>
                                <h5 class="card-title"><a href="#">Sự kiện chính trị tuần qua</a></h5>
                                <div class="news-meta">
                                    <i class="far fa-clock"></i> 5 giờ trước
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 mb-4">
                        <div class="card secondary-news-card h-100">
                            <img src="https://via.placeholder.com/400x150?text=Tin+5" class="card-img-top">
                            <div class="card-body p-3">
                                <span class="badge badge-danger mb-2">GIÁO DỤC</span>
                                <h5 class="card-title"><a href="#">Xu hướng giáo dục mới trong năm học 2025-2026</a></h5>
                                <div class="news-meta">
                                    <i class="far fa-clock"></i> 6 giờ trước
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Sidebar -->
            <div class="col-lg-4">
                <!-- Tin mới -->
                <div class="sidebar-section-title">
                    <i class="fas fa-star"></i> Tin mới
                </div>
                <div class="sidebar-news-item">
                    <h6><a href="#">Sự lún nghiêm trọng gần thủy điện Lạ Ly, 6 hộ dân trong vùng nguy hiểm</a></h6>
                    <div class="meta"><i class="far fa-clock"></i> 1 giờ trước</div>
                </div>
                <div class="sidebar-news-item">
                    <h6><a href="#">Bán hòa ca của lúa và dã thường</a></h6>
                    <div class="meta"><i class="far fa-clock"></i> 2 giờ trước</div>
                </div>
                <div class="sidebar-news-item">
                    <h6><a href="#">Mỗi tháng 10 dương lịch, đã rục rich làm đẹp... đón tết</a></h6>
                    <div class="meta"><i class="far fa-clock"></i> 3 giờ trước</div>
                </div>
                <div class="sidebar-news-item">
                    <h6><a href="#">Trung Kiên không thể cứu nối HAGL, cửa rơi hang đang đến gần</a></h6>
                    <div class="meta"><i class="far fa-clock"></i> 4 giờ trước</div>
                </div>

                <!-- Quảng cáo -->
                <div class="mt-4">
                    <img src="https://via.placeholder.com/300x250?text=Quảng+cáo+sidebar" class="img-fluid w-100" style="border-radius: 5px;">
                </div>

                <!-- Xem nhiều -->
                <div class="sidebar-section-title mt-4">
                    <i class="fas fa-fire"></i> Xem nhiều
                </div>
                <div class="sidebar-news-item">
                    <h6><a href="#">Lịch sử tương tác giữa nước ngoài và Việt Nam trong các năm qua</a></h6>
                    <div class="meta"><i class="far fa-clock"></i> 8 giờ trước | 5.2K xem</div>
                </div>
                <div class="sidebar-news-item">
                    <h6><a href="#">Các chính sách mới của Chính phủ tháng 10</a></h6>
                    <div class="meta"><i class="far fa-clock"></i> 10 giờ trước | 3.8K xem</div>
                </div>
                <div class="sidebar-news-item">
                    <h6><a href="#">Khuyến cáo an toàn giao thông dịp cuối năm</a></h6>
                    <div class="meta"><i class="far fa-clock"></i> 12 giờ trước | 2.1K xem</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5>Về Java3 News</h5>
                    <p>Nền tảng cung cấp tin tức chính xác, nhanh chóng và đáng tin cậy</p>
                </div>
                <div class="col-md-4">
                    <h5>Liên kết nhanh</h5>
                    <ul style="list-style: none; padding: 0;">
                        <li><a href="home" class="text-white-50 text-decoration-none">Trang chủ</a></li>
                        <li><a href="#" class="text-white-50 text-decoration-none">Hỗ trợ</a></li>
                        <li><a href="#" class="text-white-50 text-decoration-none">Điều khoản</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Liên hệ</h5>
                    <p class="mb-1"><i class="fas fa-envelope"></i> info@java3demo.com</p>
                    <p><i class="fas fa-phone"></i> 1900-1234</p>
                </div>
            </div>
            <hr class="bg-secondary">
            <p class="text-center text-white-50 mb-0">&copy; 2025 Java3Demo News. All rights reserved.</p>
        </div>
    </footer>

