-- 🔁 XÓA DATABASE CŨ (NẾU ĐÃ TỒN TẠI)
IF DB_ID('java3') IS NOT NULL
BEGIN
    ALTER DATABASE java3 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE java3;
END
GO

-- 🆕 TẠO DATABASE MỚI
CREATE DATABASE java3;
GO

USE java3;
GO

-- 🧑‍💻 TẠO BẢNG Users
CREATE TABLE Users (
    id INT PRIMARY KEY IDENTITY(1,1),
    username NVARCHAR(50) UNIQUE NOT NULL,
    password NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    fullname NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20),
    createDate DATE DEFAULT GETDATE(),
    isActive BIT DEFAULT 1,
    role NVARCHAR(20) DEFAULT 'USER'
);
GO

-- ➕ THÊM DỮ LIỆU MẪU CHO Users
INSERT INTO Users (username, password, email, fullname, phone, role) 
VALUES 
('admin', '123456', 'admin@java3.com', N'Quản trị viên', '0123456789', 'ADMIN'),
('user1', '123456', 'user1@java3.com', N'Nguyễn Văn A', '0987654321', 'USER'),
('user2', '123456', 'user2@java3.com', N'Trần Thị B', '0912345678', 'EDITOR'),
('editor1', '123456', 'editor1@java3.com', N'Biên tập viên 1', '0901234567', 'EDITOR');
GO

-- 🗂️ TẠO BẢNG Category
CREATE TABLE Category (
    id INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(500),
    isActive BIT DEFAULT 1
);
GO

-- ➕ THÊM DỮ LIỆU CHO Category
INSERT INTO Category (name, description) 
VALUES 
(N'Chính trị', N'Tin tức chính trị'),
(N'Thời sự', N'Tin tức thời sự trong ngày'),
(N'Thế giới', N'Tin tức thế giới'),
(N'Kinh tế', N'Tin tức kinh tế'),
(N'Đời sống', N'Tin tức đời sống'),
(N'Sức khỏe', N'Tin tức sức khỏe'),
(N'Giáo dục', N'Tin tức giáo dục'),
(N'Công nghệ', N'Tin tức công nghệ'),
(N'Thể thao', N'Tin tức thể thao'),
(N'Giải trí', N'Tin tức giải trí');
GO

-- 📰 TẠO BẢNG News
CREATE TABLE News (
    id INT PRIMARY KEY IDENTITY(1,1),
    title NVARCHAR(500) NOT NULL,
    content NVARCHAR(MAX) NOT NULL,
    summary NVARCHAR(1000),
    image NVARCHAR(500),
    createDate DATETIME DEFAULT GETDATE(),
    updateDate DATETIME,
    userId INT NOT NULL,
    categoryId INT NOT NULL,
    viewCount INT DEFAULT 0,
    isActive BIT DEFAULT 1,
    FOREIGN KEY (userId) REFERENCES Users(id),
    FOREIGN KEY (categoryId) REFERENCES Category(id)
);
GO

-- ➕ THÊM DỮ LIỆU MẪU CHO News
INSERT INTO News (title, content, summary, image, userId, categoryId, viewCount) 
VALUES 
(N'Cử tri lo ngại trước biến động giá vàng, bất động sản', 
 N'Cử tri và nhân dân lo ngại về tác động của làm phát toàn cầu, cùng với sự biến động khó lường của giá vàng và bất động sản...', 
 N'Cử tri lo ngại về tác động của làm phát toàn cầu', 
 'https://via.placeholder.com/800x400?text=Tin+noi+bat', 
 3, 1, 1250),
(N'Hợp tác quốc phòng Việt Nam – Belarus còn dư địa phát triển', 
 N'Quan hệ hợp tác quốc phòng giữa Việt Nam và Belarus có lịch sử lâu dài...', 
 N'Quan hệ hợp tác quốc phòng VN-Belarus', 
 'https://via.placeholder.com/800x400?text=Quoc+phong', 
 3, 1, 850),
(N'Đề nghị doanh nghiệp hoạt động ở nơi nào thì nộp thuế tại nơi đó', 
 N'Bộ Tài chính đề xuất sửa đổi Luật Quản lý thuế...', 
 N'Đề xuất doanh nghiệp nộp thuế tại nơi hoạt động', 
 'https://via.placeholder.com/800x400?text=Thue', 
 3, 4, 620);
GO
