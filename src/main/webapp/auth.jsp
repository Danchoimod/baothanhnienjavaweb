<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập / Đăng ký - Java3 News</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .auth-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            overflow: hidden;
            max-width: 450px;
            width: 100%;
            border: 1px solid #e9ecef;
        }
        .auth-header {
            background-color: #007bff;
            color: white;
            padding: 30px;
            text-align: center;
        }
        .auth-header h2 {
            margin: 0;
            font-size: 28px;
            font-weight: bold;
        }
        .auth-header p {
            margin: 10px 0 0 0;
            opacity: 0.9;
        }
        .auth-body {
            padding: 30px;
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
        .form-group label {
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
        .input-group-text {
            background: #f8f9fa;
            border: 2px solid #e9ecef;
            border-right: none;
            border-radius: 8px 0 0 8px;
        }
        .input-group .form-control {
            border-left: none;
            border-radius: 0 8px 8px 0;
        }
        .btn-auth {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 8px;
            font-weight: 600;
            width: 100%;
            transition: all 0.3s ease;
            margin-top: 10px;
        }
        .btn-auth:hover {
            background: linear-gradient(135deg, #0056b3 0%, #003d82 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.4);
            color: white;
        }
        .divider {
            text-align: center;
            margin: 25px 0;
            position: relative;
        }
        .divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: #e9ecef;
        }
        .divider span {
            background: white;
            padding: 0 15px;
            position: relative;
            color: #6c757d;
            font-size: 14px;
        }
        .social-login {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        .btn-social {
            flex: 1;
            padding: 10px;
            border-radius: 8px;
            border: 2px solid #e9ecef;
            background: white;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            font-weight: 600;
        }
        .btn-social:hover {
            transform: translateY(-2px);
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        .btn-google {
            color: #DB4437;
        }
        .btn-facebook {
            color: #4267B2;
        }
        .btn-zalo {
            color: #0068FF;
        }
        .alert {
            border-radius: 8px;
            border: none;
            padding: 12px 15px;
            margin-bottom: 20px;
        }
        .forgot-password {
            text-align: right;
            margin-top: -10px;
            margin-bottom: 15px;
        }
        .forgot-password a {
            color: #007bff;
            font-size: 14px;
            text-decoration: none;
        }
        .forgot-password a:hover {
            text-decoration: underline;
        }
        .back-home {
            text-align: center;
            margin-top: 20px;
        }
        .back-home a {
            color: #007bff;
            text-decoration: none;
            font-weight: 600;
        }
        .back-home a:hover {
            text-decoration: underline;
        }
        .password-toggle {
            cursor: pointer;
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }
        .password-wrapper {
            position: relative;
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-header">
            <h2><i class="fas fa-newspaper"></i> THANH NIÊN</h2>
            <p>Đăng nhập để trải nghiệm đầy đủ</p>
        </div>
        
        <div class="auth-body">
            <!-- Alert Messages -->
            <% if (request.getAttribute("loginError") != null) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("loginError") %>
                </div>
            <% } %>
            
            <% if (request.getAttribute("registerError") != null) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("registerError") %>
                </div>
            <% } %>
            
            <% if (request.getAttribute("registerSuccess") != null) { %>
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> <%= request.getAttribute("registerSuccess") %>
                </div>
            <% } %>
            
            <!-- Tabs -->
            <ul class="nav nav-tabs" id="authTabs" role="tablist">
                <li class="nav-item">
                    <a class="nav-link <%= "register".equals(request.getAttribute("activeTab")) ? "" : "active" %>" 
                       id="login-tab" data-toggle="tab" href="#login" role="tab">
                        Đăng nhập
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <%= "register".equals(request.getAttribute("activeTab")) ? "active" : "" %>" 
                       id="register-tab" data-toggle="tab" href="#register" role="tab">
                        Đăng ký
                    </a>
                </li>
            </ul>
            
            <div class="tab-content" id="authTabContent">
                <!-- Login Tab -->
                <div class="tab-pane fade <%= "register".equals(request.getAttribute("activeTab")) ? "" : "show active" %>" 
                     id="login" role="tabpanel">
                    <form action="login" method="post">
                        <div class="form-group">
                            <label>Email hoặc tên đăng nhập</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-user"></i>
                                    </span>
                                </div>
                                <input type="text" class="form-control" name="username" 
                                       placeholder="Nhập email hoặc tên đăng nhập" required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>Mật khẩu</label>
                            <div class="password-wrapper">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="fas fa-lock"></i>
                                        </span>
                                    </div>
                                    <input type="password" class="form-control" id="loginPassword" 
                                           name="password" placeholder="Nhập mật khẩu" required>
                                </div>
                                <i class="fas fa-eye password-toggle" onclick="togglePassword('loginPassword')"></i>
                            </div>
                        </div>
                        
                        <div class="forgot-password">
                            <a href="#">Quên mật khẩu?</a>
                        </div>
                        
                        <button type="submit" class="btn btn-auth">
                            <i class="fas fa-sign-in-alt"></i> Đăng nhập
                        </button>
                    </form>
                    
                    <div class="divider">
                        <span>Hoặc đăng nhập bằng</span>
                    </div>
                    
                    <div class="social-login">
                        <button class="btn-social btn-google">
                            <i class="fab fa-google"></i> Google
                        </button>
                        <button class="btn-social btn-facebook">
                            <i class="fab fa-facebook-f"></i> Facebook
                        </button>
                        <button class="btn-social btn-zalo">
                            <img src="https://img.icons8.com/color/24/000000/zalo.png" alt="Zalo" style="width: 20px;"> Zalo
                        </button>
                    </div>
                </div>
                
                <!-- Register Tab -->
                <div class="tab-pane fade <%= "register".equals(request.getAttribute("activeTab")) ? "show active" : "" %>" 
                     id="register" role="tabpanel">
                    <form action="register" method="post">
                        <div class="form-group">
                            <label>Tên đăng nhập <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-user"></i>
                                    </span>
                                </div>
                                <input type="text" class="form-control" name="username" 
                                       placeholder="Nhập tên đăng nhập (ít nhất 4 ký tự)" 
                                       value="<%= request.getAttribute("registerData") != null ? ((com.poly.beans.RegisterBean)request.getAttribute("registerData")).getUsername() : "" %>"
                                       required minlength="4">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>Email <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-envelope"></i>
                                    </span>
                                </div>
                                <input type="email" class="form-control" name="email" 
                                       placeholder="Nhập email" 
                                       value="<%= request.getAttribute("registerData") != null ? ((com.poly.beans.RegisterBean)request.getAttribute("registerData")).getEmail() : "" %>"
                                       required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>Họ và tên <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-id-card"></i>
                                    </span>
                                </div>
                                <input type="text" class="form-control" name="fullname" 
                                       placeholder="Nhập họ và tên" 
                                       value="<%= request.getAttribute("registerData") != null ? ((com.poly.beans.RegisterBean)request.getAttribute("registerData")).getFullname() : "" %>"
                                       required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>Số điện thoại</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-phone"></i>
                                    </span>
                                </div>
                                <input type="tel" class="form-control" name="phone" 
                                       placeholder="Nhập số điện thoại" 
                                       value="<%= request.getAttribute("registerData") != null ? ((com.poly.beans.RegisterBean)request.getAttribute("registerData")).getPhone() : "" %>">
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Ngày sinh</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-calendar"></i>
                                    </span>
                                </div>
                                <input type="date" class="form-control" name="birthDate"
                                       value="<%= request.getAttribute("registerData") != null ? ((com.poly.beans.RegisterBean)request.getAttribute("registerData")).getBirthDate() : "" %>">
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Địa chỉ</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">
                                        <i class="fas fa-map-marker-alt"></i>
                                    </span>
                                </div>
                                <input type="text" class="form-control" name="address" 
                                       placeholder="Nhập địa chỉ"
                                       value="<%= request.getAttribute("registerData") != null ? ((com.poly.beans.RegisterBean)request.getAttribute("registerData")).getAddress() : "" %>">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>Mật khẩu <span class="text-danger">*</span></label>
                            <div class="password-wrapper">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="fas fa-lock"></i>
                                        </span>
                                    </div>
                                    <input type="password" class="form-control" id="registerPassword" 
                                           name="password" placeholder="Nhập mật khẩu (ít nhất 6 ký tự)" 
                                           required minlength="6">
                                </div>
                                <i class="fas fa-eye password-toggle" onclick="togglePassword('registerPassword')"></i>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>Xác nhận mật khẩu <span class="text-danger">*</span></label>
                            <div class="password-wrapper">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="fas fa-lock"></i>
                                        </span>
                                    </div>
                                    <input type="password" class="form-control" id="confirmPassword" 
                                           name="confirmPassword" placeholder="Nhập lại mật khẩu" 
                                           required minlength="6">
                                </div>
                                <i class="fas fa-eye password-toggle" onclick="togglePassword('confirmPassword')"></i>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-auth">
                            <i class="fas fa-user-plus"></i> Đăng ký
                        </button>
                    </form>
                </div>
            </div>
            
            <div class="back-home">
                <a href="home"><i class="fas fa-arrow-left"></i> Quay lại trang chủ</a>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function togglePassword(inputId) {
            const input = document.getElementById(inputId);
            const icon = input.parentElement.parentElement.nextElementSibling;
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
        
        // Validate confirm password
        document.querySelector('form[action="register"]').addEventListener('submit', function(e) {
            const password = document.getElementById('registerPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Mật khẩu xác nhận không khớp!');
            }
        });
    </script>
</body>
</html>
