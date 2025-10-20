create database java3;

use java3;

-- Tạo bảng Users
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

-- Thêm dữ liệu mẫu
INSERT INTO Users (username, password, email, fullname, phone, role) 
VALUES 
('admin', '123456', 'admin@java3.com', N'Quản trị viên', '0123456789', 'ADMIN'),
('user1', '123456', 'user1@java3.com', N'Nguyễn Văn A', '0987654321', 'USER'),
('user2', '123456', 'user2@java3.com', N'Trần Thị B', '0912345678', 'USER');
