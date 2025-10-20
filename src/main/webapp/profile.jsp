<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin tài khoản - Java3 News</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        .profile-container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 15px;
        }
        .profile-sidebar {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            text-align: center;
        }
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: linear-gradient(135deg, #007bff, #00c6ff);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 48px;
            font-weight: bold;
            position: relative;
        }
        .profile-avatar .camera-icon {
            position: absolute;
            bottom: 5px;
            right: 5px;
            background: white;
            border-radius: 50%;
            width: 35px;
            height: 35px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #007bff;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .profile-name {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }
        .profile-email {
            color: #6c757d;
            margin-bottom: 20px;
        }
        .profile-menu {
            list-style: none;
            padding: 0;
            margin: 20px 0 0 0;
        }
        .profile-menu li {
            margin-bottom: 10px;
        }
        .profile-menu a {
            display: block;
            padding: 12px 20px;
            color: #333;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .profile-menu a:hover,
        .profile-menu a.active {
            background-color: #007bff;
            color: white;
        }
        .profile-menu i {
            margin-right: 10px;
            width: 20px;
        }
        .profile-content {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .section-title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #007bff;
        }
        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
            box-shadow: 0 3px 10px rgba(0, 123, 255, 0.3);
        }
        .btn-outline-secondary {
            border: 2px solid #6c757d;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
        }
        .alert {
            border-radius: 8px;
            border: none;
            padding: 12px 20px;
        }
        .nav-tabs {
            border-bottom: 2px solid #e9ecef;
            margin-bottom: 25px;
        }
        .nav-tabs .nav-link {
            border: none;
            color: #6c757d;
            padding: 12px 24px;
            font-weight: 600;
            border-bottom: 3px solid transparent;
            transition: all 0.3s ease;
        }
        .nav-tabs .nav-link:hover {
            border-color: transparent;
            color: #007bff;
        }
        .nav-tabs .nav-link.active {
            color: #007bff;
            background-color: transparent;
            border-bottom: 3px solid #007bff;
        }
        .navbar-brand {
            font-size: 24px;
            font-weight: bold;
            color: #007bff !important;
        }
        
        /* News Management Cards Hover Effect */
        .news-management-card {
            transition: all 0.3s ease;
        }
        
        .news-management-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,.2) !important;
        }
    </style>
</head>
<body>
    <!-- Header Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom sticky-top">
        <div class="container">
            <a class="navbar-brand" href="home" style="font-size: 32px;">
                THANH NIÊN
            </a>
            
            <div class="ml-auto">
                <a href="home" class="btn btn-sm btn-outline-primary">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
            </div>
        </div>
    </nav>

    <!-- Profile Container -->
    <div class="profile-container">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="profile-sidebar">
                    <div class="profile-avatar">
                        <%= session.getAttribute("fullname") != null ? 
                            session.getAttribute("fullname").toString().substring(0, 1).toUpperCase() : "P" %>
                        <div class="camera-icon">
                            <i class="fas fa-camera"></i>
                        </div>
                    </div>
                    <div class="profile-name"><%= session.getAttribute("fullname") %></div>
                    <div class="profile-email"><%= session.getAttribute("username") %></div>
                    
                    <ul class="profile-menu">
                        <li>
                            <a href="#" class="active" data-tab="profile">
                                <i class="fas fa-user"></i> Thông tin tài khoản
                            </a>
                        </li>
                        <li>
                            <a href="#" data-tab="password">
                                <i class="fas fa-lock"></i> Đổi mật khẩu
                            </a>
                        </li>
                        <% 
                        String userRole = (String) session.getAttribute("role");
                        if ("EDITOR".equals(userRole) || "ADMIN".equals(userRole)) { 
                        %>
                        <li>
                            <a href="#" data-tab="news-management">
                                <i class="fas fa-newspaper"></i> Quản lý tin tức
                            </a>
                        </li>
                        <% } %>
                        <li>
                            <a href="logout" class="text-danger">
                                <i class="fas fa-sign-out-alt"></i> Đăng xuất
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Content -->
            <div class="col-md-9">
                <div class="profile-content">
                    <!-- Alert Messages -->
                    <% if (request.getAttribute("profileSuccess") != null) { %>
                        <div class="alert alert-success alert-dismissible fade show">
                            <i class="fas fa-check-circle"></i> <%= request.getAttribute("profileSuccess") %>
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                        </div>
                    <% } %>
                    
                    <% if (request.getAttribute("profileError") != null) { %>
                        <div class="alert alert-danger alert-dismissible fade show">
                            <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("profileError") %>
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                        </div>
                    <% } %>
                    
                    <% if (request.getAttribute("passwordSuccess") != null) { %>
                        <div class="alert alert-success alert-dismissible fade show">
                            <i class="fas fa-check-circle"></i> <%= request.getAttribute("passwordSuccess") %>
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                        </div>
                    <% } %>
                    
                    <% if (request.getAttribute("passwordError") != null) { %>
                        <div class="alert alert-danger alert-dismissible fade show">
                            <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("passwordError") %>
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                        </div>
                    <% } %>

                    <!-- Tab Content -->
                    <div class="tab-content-wrapper">
                        <!-- Profile Tab -->
                        <div id="profileTab" class="tab-panel <%= "password".equals(request.getAttribute("activeTab")) || "activity".equals(request.getAttribute("activeTab")) || "saved".equals(request.getAttribute("activeTab")) ? "d-none" : "" %>">
                            <h3 class="section-title">Thông tin tài khoản</h3>
                            
                            <form action="profile" method="post">
                                <input type="hidden" name="action" value="updateProfile">
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Tên hiển thị <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" name="fullname" 
                                                   value="<%= request.getAttribute("profile") != null ? ((com.poly.beans.ProfileBean)request.getAttribute("profile")).getFullname() : session.getAttribute("fullname") %>" 
                                                   placeholder="Nhập tên hiển thị" required>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Giới tính</label>
                                            <select class="form-control" name="gender">
                                                <option value="">Khác</option>
                                                <option value="Nam">Nam</option>
                                                <option value="Nữ">Nữ</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Email <span class="text-danger">*</span></label>
                                            <input type="email" class="form-control" name="email" 
                                                   value="<%= request.getAttribute("profile") != null ? ((com.poly.beans.ProfileBean)request.getAttribute("profile")).getEmail() : ((com.poly.entities.Users)session.getAttribute("user")).getEmail() %>" 
                                                   placeholder="Nhập email" required>
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Điện thoại</label>
                                            <input type="tel" class="form-control" name="phone" 
                                                   value="<%= request.getAttribute("profile") != null ? ((com.poly.beans.ProfileBean)request.getAttribute("profile")).getPhone() : ((com.poly.entities.Users)session.getAttribute("user")).getPhone() %>" 
                                                   placeholder="Nhập số điện thoại">
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Ngày sinh</label>
                                            <input type="date" class="form-control" name="birthDate">
                                        </div>
                                    </div>
                                    
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label class="form-label">Địa chỉ</label>
                                            <input type="text" class="form-control" name="address" 
                                                   placeholder="Nhập địa chỉ">
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group mt-4">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save"></i> Lưu thay đổi
                                    </button>
                                    <button type="reset" class="btn btn-outline-secondary ml-2">
                                        <i class="fas fa-undo"></i> Hủy
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- Password Tab -->
                        <div id="passwordTab" class="tab-panel <%= "password".equals(request.getAttribute("activeTab")) ? "" : "d-none" %>">
                            <h3 class="section-title">Đổi mật khẩu</h3>
                            
                            <form action="profile" method="post">
                                <input type="hidden" name="action" value="changePassword">
                                
                                <div class="form-group">
                                    <label class="form-label">Mật khẩu hiện tại <span class="text-danger">*</span></label>
                                    <input type="password" class="form-control" name="oldPassword" 
                                           placeholder="Nhập mật khẩu hiện tại" required>
                                </div>
                                
                                <div class="form-group">
                                    <label class="form-label">Mật khẩu mới <span class="text-danger">*</span></label>
                                    <input type="password" class="form-control" name="newPassword" 
                                           placeholder="Nhập mật khẩu mới (ít nhất 6 ký tự)" required minlength="6">
                                </div>
                                
                                <div class="form-group">
                                    <label class="form-label">Xác nhận mật khẩu mới <span class="text-danger">*</span></label>
                                    <input type="password" class="form-control" name="confirmPassword" 
                                           placeholder="Nhập lại mật khẩu mới" required minlength="6">
                                </div>
                                
                                <div class="form-group mt-4">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-key"></i> Đổi mật khẩu
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- News Management Tab (for EDITOR/ADMIN only) -->
                        <% if ("EDITOR".equals(userRole) || "ADMIN".equals(userRole)) { %>
                        <div id="news-managementTab" class="tab-panel <%= "news-management".equals(request.getAttribute("activeTab")) ? "" : "d-none" %>">
                            <h3 class="section-title">Quản lý tin tức</h3>
                            
                            <div class="row mb-4">
                                <div class="col-md-4 mb-3">
                                    <a href="<%= request.getContextPath() %>/news/create" class="card news-management-card text-center p-4 text-decoration-none" style="border: 2px solid #007bff; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,.1);">
                                        <i class="fas fa-plus-circle" style="font-size: 48px; color: #007bff; margin-bottom: 15px;"></i>
                                        <h5 style="color: #007bff; margin: 0;">Đăng tin mới</h5>
                                        <p class="text-muted mt-2 mb-0" style="font-size: 14px;">Tạo bài viết tin tức mới</p>
                                    </a>
                                </div>
                                
                                <div class="col-md-4 mb-3">
                                    <a href="<%= request.getContextPath() %>/news/list" class="card news-management-card text-center p-4 text-decoration-none" style="border: 2px solid #28a745; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,.1);">
                                        <i class="fas fa-list" style="font-size: 48px; color: #28a745; margin-bottom: 15px;"></i>
                                        <h5 style="color: #28a745; margin: 0;">Danh sách tin</h5>
                                        <p class="text-muted mt-2 mb-0" style="font-size: 14px;">Xem và quản lý tin của bạn</p>
                                    </a>
                                </div>
                                
                                <div class="col-md-4 mb-3">
                                    <a href="<%= request.getContextPath() %>/home" class="card news-management-card text-center p-4 text-decoration-none" style="border: 2px solid #17a2b8; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,.1);">
                                        <i class="fas fa-chart-line" style="font-size: 48px; color: #17a2b8; margin-bottom: 15px;"></i>
                                        <h5 style="color: #17a2b8; margin: 0;">Xem tin công khai</h5>
                                        <p class="text-muted mt-2 mb-0" style="font-size: 14px;">Xem tin tức trên trang chủ</p>
                                    </a>
                                </div>
                            </div>
                            
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle"></i> 
                                <strong>Hướng dẫn:</strong>
                                <ul class="mb-0 mt-2">
                                    <li>Nhấn <strong>"Đăng tin mới"</strong> để tạo bài viết tin tức với tiêu đề, nội dung, hình ảnh</li>
                                    <li>Nhấn <strong>"Danh sách tin"</strong> để xem, chỉnh sửa hoặc xóa các tin đã đăng</li>
                                    <li>Hình ảnh sẽ được tải lên Cloudinary tự động khi bạn chọn file</li>
                                </ul>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Handle tab switching
        $('.profile-menu a[data-tab]').click(function(e) {
            e.preventDefault();
            
            // Remove active class from all menu items
            $('.profile-menu a').removeClass('active');
            $(this).addClass('active');
            
            // Hide all tab panels
            $('.tab-panel').addClass('d-none');
            
            // Show selected tab panel
            var tab = $(this).data('tab');
            $('#' + tab + 'Tab').removeClass('d-none');
        });
    </script>
</body>
</html>
