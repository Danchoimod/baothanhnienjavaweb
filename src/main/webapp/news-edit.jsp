<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.poly.entities.Category" %>
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
    
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    NewsEntity news = (NewsEntity) request.getAttribute("news");
    String error = (String) request.getAttribute("error");
    
    if (news == null) {
        response.sendRedirect(request.getContextPath() + "/news/list");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa tin tức - Thanh Niên</title>
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
        
        .content-wrapper {
            max-width: 900px;
            margin: 30px auto;
            padding: 0 15px;
        }
        
        .form-card {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
        }
        
        .form-card h2 {
            margin-bottom: 30px;
            color: #333;
        }
        
        .form-group label {
            font-weight: 500;
            color: #333;
        }
        
        .form-control, .custom-select {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px 15px;
        }
        
        .form-control:focus, .custom-select:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }
        
        .image-upload-container {
            border: 2px dashed #ddd;
            border-radius: 8px;
            padding: 30px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            background-color: #fafafa;
        }
        
        .image-upload-container:hover {
            border-color: #007bff;
            background-color: #f0f8ff;
        }
        
        .image-upload-container.uploading {
            pointer-events: none;
            opacity: 0.6;
        }
        
        .image-preview {
            max-width: 100%;
            max-height: 400px;
            margin-top: 20px;
            border-radius: 8px;
            cursor: pointer;
        }
        
        .upload-icon {
            font-size: 48px;
            color: #007bff;
            margin-bottom: 15px;
        }
        
        .upload-text {
            color: #666;
            margin-bottom: 10px;
        }
        
        .upload-progress {
            display: none;
            margin-top: 15px;
        }
        
        .btn-submit {
            background-color: #28a745;
            color: white;
            padding: 12px 40px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-submit:hover {
            background-color: #218838;
        }
        
        .btn-submit:disabled {
            background-color: #6c757d;
            cursor: not-allowed;
        }
        
        .btn-cancel {
            background-color: #6c757d;
            color: white;
            padding: 12px 40px;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }
        
        .btn-cancel:hover {
            background-color: #5a6268;
            color: white;
            text-decoration: none;
        }
        
        textarea {
            min-height: 200px;
        }
        
        .char-count {
            font-size: 12px;
            color: #999;
            text-align: right;
            margin-top: 5px;
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
        
        .current-image-container {
            text-align: center;
            margin-bottom: 20px;
        }
        
        .change-image-text {
            color: #007bff;
            font-size: 14px;
            margin-top: 10px;
            cursor: pointer;
        }
        
        .change-image-text:hover {
            text-decoration: underline;
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
        <div class="form-card">
            <h2><i class="fas fa-edit"></i> Chỉnh sửa tin tức</h2>
            
            <% if (error != null) { %>
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i> <%= error %>
                </div>
            <% } %>
            
            <form id="newsForm" method="post" action="<%= request.getContextPath() %>/news/edit?id=<%= news.getId() %>">
                <div class="form-group">
                    <label>Tiêu đề <span class="text-danger">*</span></label>
                    <input type="text" name="title" class="form-control" 
                           placeholder="Nhập tiêu đề tin tức (tối thiểu 10 ký tự)" 
                           value="<%= news.getTitle() %>"
                           required maxlength="200" id="titleInput">
                    <div class="char-count">
                        <span id="titleCount">0</span>/200 ký tự
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Danh mục <span class="text-danger">*</span></label>
                    <select name="categoryId" class="custom-select" required>
                        <option value="">-- Chọn danh mục --</option>
                        <% if (categories != null) {
                            for (Category category : categories) { %>
                            <option value="<%= category.getId() %>" 
                                    <%= (category.getId() == news.getCategoryId()) ? "selected" : "" %>>
                                <%= category.getName() %>
                            </option>
                        <% 
                            }
                        } %>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Tóm tắt <span class="text-danger">*</span></label>
                    <textarea name="summary" class="form-control" 
                              placeholder="Nhập tóm tắt ngắn gọn về tin tức" 
                              required maxlength="500" id="summaryInput"><%= news.getSummary() %></textarea>
                    <div class="char-count">
                        <span id="summaryCount">0</span>/500 ký tự
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Nội dung <span class="text-danger">*</span></label>
                    <textarea name="content" class="form-control" 
                              placeholder="Nhập nội dung chi tiết (tối thiểu 50 ký tự)" 
                              required id="contentInput"><%= news.getContent() %></textarea>
                    <div class="char-count">
                        <span id="contentCount">0</span> ký tự
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Hình ảnh</label>
                    
                    <% if (news.getImage() != null && !news.getImage().isEmpty()) { %>
                        <div class="current-image-container" id="currentImageContainer">
                            <img src="<%= news.getImage() %>" class="image-preview" id="imagePreview">
                            <p class="change-image-text" onclick="showUploadContainer()">
                                <i class="fas fa-sync-alt"></i> Thay đổi hình ảnh
                            </p>
                        </div>
                    <% } %>
                    
                    <div class="image-upload-container" id="uploadContainer" 
                         style="<%= (news.getImage() != null && !news.getImage().isEmpty()) ? "display: none;" : "" %>"
                         onclick="document.getElementById('fileInput').click()">
                        <div id="uploadPlaceholder">
                            <i class="fas fa-cloud-upload-alt upload-icon"></i>
                            <p class="upload-text">Nhấn vào đây để tải ảnh lên</p>
                            <small class="text-muted">Hỗ trợ: JPG, PNG, GIF (tối đa 10MB)</small>
                        </div>
                        <div class="upload-progress">
                            <div class="spinner-border text-primary" role="status">
                                <span class="sr-only">Đang tải...</span>
                            </div>
                            <p class="mt-2">Đang tải ảnh lên...</p>
                        </div>
                    </div>
                    <input type="file" id="fileInput" accept="image/*" style="display: none;">
                    <input type="hidden" name="image" id="imageUrl" value="<%= news.getImage() != null ? news.getImage() : "" %>">
                </div>
                
                <div class="form-group text-center mt-4">
                    <button type="submit" class="btn-submit" id="submitBtn">
                        <i class="fas fa-save"></i> Lưu thay đổi
                    </button>
                    <a href="<%= request.getContextPath() %>/news/list" class="btn-cancel ml-3">
                        <i class="fas fa-times"></i> Hủy
                    </a>
                </div>
            </form>
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
        
        function showUploadContainer() {
            document.getElementById('currentImageContainer').style.display = 'none';
            document.getElementById('uploadContainer').style.display = 'block';
        }

        // Character count
        function updateCharCount(inputId, countId, maxLength) {
            const input = document.getElementById(inputId);
            const count = document.getElementById(countId);
            
            function update() {
                const length = input.value.length;
                count.textContent = length;
                if (maxLength && length > maxLength) {
                    count.parentElement.style.color = '#dc3545';
                } else {
                    count.parentElement.style.color = '#999';
                }
            }
            
            input.addEventListener('input', update);
            update();
        }
        
        updateCharCount('titleInput', 'titleCount', 200);
        updateCharCount('summaryInput', 'summaryCount', 500);
        updateCharCount('contentInput', 'contentCount');

        // Cloudinary upload
        const fileInput = document.getElementById('fileInput');
        const uploadContainer = document.getElementById('uploadContainer');
        const uploadPlaceholder = document.getElementById('uploadPlaceholder');
        const uploadProgress = document.querySelector('.upload-progress');
        const imagePreview = document.getElementById('imagePreview');
        const imageUrl = document.getElementById('imageUrl');
        const submitBtn = document.getElementById('submitBtn');
        const currentImageContainer = document.getElementById('currentImageContainer');
        
        fileInput.addEventListener('change', async function(e) {
            const file = e.target.files[0];
            if (!file) return;
            
            // Validate file type
            if (!file.type.startsWith('image/')) {
                alert('Vui lòng chọn file hình ảnh!');
                return;
            }
            
            // Validate file size (10MB)
            if (file.size > 10 * 1024 * 1024) {
                alert('Kích thước file không được vượt quá 10MB!');
                return;
            }
            
            // Show uploading state
            uploadContainer.classList.add('uploading');
            uploadPlaceholder.style.display = 'none';
            uploadProgress.style.display = 'block';
            submitBtn.disabled = true;
            
            try {
                const formData = new FormData();
                formData.append('file', file);
                formData.append('upload_preset', 'unsigned_upload');
                
                const response = await fetch('https://api.cloudinary.com/v1_1/dhdke5ku8/image/upload', {
                    method: 'POST',
                    body: formData
                });
                
                if (!response.ok) {
                    throw new Error('Upload failed');
                }
                
                const data = await response.json();
                
                // Set image URL
                imageUrl.value = data.secure_url;
                imagePreview.src = data.secure_url;
                
                // Show image preview
                uploadContainer.style.display = 'none';
                currentImageContainer.style.display = 'block';
                
            } catch (error) {
                console.error('Upload error:', error);
                alert('Tải ảnh lên thất bại! Vui lòng thử lại.');
                
                // Reset state
                uploadPlaceholder.style.display = 'block';
                uploadProgress.style.display = 'none';
                uploadContainer.classList.remove('uploading');
            } finally {
                submitBtn.disabled = false;
            }
        });
    </script>
</body>
</html>
