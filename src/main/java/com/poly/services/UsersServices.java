package com.poly.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;

import com.poly.config.DatabaseConnect;
import com.poly.entities.Users;

public class UsersServices {
	
	// Đăng nhập
	public Users login(String username, String password) {
		String sql = "SELECT * FROM Users WHERE username = ? AND password = ? AND isActive = 1";
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setString(1, username);
			ps.setString(2, password);
			
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				Users user = new Users();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setEmail(rs.getString("email"));
				user.setFullname(rs.getString("fullname"));
				user.setPhone(rs.getString("phone"));
				user.setCreateDate(rs.getDate("createDate"));
				user.setActive(rs.getBoolean("isActive"));
				user.setRole(rs.getString("role"));
				return user;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// Đăng ký
	public boolean register(Users user) {
		String sql = "INSERT INTO Users (username, password, email, fullname, phone, createDate, isActive, role) VALUES (?, ?, ?, ?, ?, GETDATE(), 1, 'USER')";
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getEmail());
			ps.setString(4, user.getFullname());
			ps.setString(5, user.getPhone());
			
			int result = ps.executeUpdate();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// Kiểm tra username đã tồn tại
	public boolean isUsernameExists(String username) {
		String sql = "SELECT COUNT(*) FROM Users WHERE username = ?";
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setString(1, username);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// Kiểm tra email đã tồn tại
	public boolean isEmailExists(String email) {
		String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// Lấy thông tin user theo id
	public Users getUserById(int id) {
		String sql = "SELECT * FROM Users WHERE id = ?";
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				Users user = new Users();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setEmail(rs.getString("email"));
				user.setFullname(rs.getString("fullname"));
				user.setPhone(rs.getString("phone"));
				user.setCreateDate(rs.getDate("createDate"));
				user.setActive(rs.getBoolean("isActive"));
				user.setRole(rs.getString("role"));
				return user;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// Cập nhật thông tin profile
	public boolean updateUserProfile(Users user) {
		String sql = "UPDATE Users SET fullname = ?, email = ?, phone = ? WHERE id = ?";
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setString(1, user.getFullname());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPhone());
			ps.setInt(4, user.getId());
			
			int result = ps.executeUpdate();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// Đổi mật khẩu
	public boolean changePassword(int userId, String newPassword) {
		String sql = "UPDATE Users SET password = ? WHERE id = ?";
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setString(1, newPassword);
			ps.setInt(2, userId);
			
			int result = ps.executeUpdate();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
