package com.poly.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.util.List;

import com.poly.config.DatabaseConnect;
import com.poly.entities.Users;

public class UsersServices {

	// Lấy người dùng theo username
	public Users getUserByUsername(String username) {
		String sql = "SELECT * FROM Users WHERE username = ?";
		try (Connection con = DatabaseConnect.dbConnection();
		     PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, username);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					Users user = new Users();
					user.setId(rs.getInt("id"));
					user.setUsername(rs.getString("username"));
					user.setPassword(rs.getString("password"));
					user.setEmail(rs.getString("email"));
					user.setFullname(rs.getString("fullname"));
					user.setPhone(rs.getString("phone"));
					user.setAddress(rs.getString("address"));
					user.setBirthDate(rs.getDate("birthDate"));
					user.setCreateDate(rs.getDate("createDate"));
					user.setActive(rs.getBoolean("isActive"));
					user.setRole(rs.getString("role"));
					return user;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
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
				user.setAddress(rs.getString("address"));
				user.setBirthDate(rs.getDate("birthDate"));
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
		String sql = "INSERT INTO Users (username, password, email, fullname, phone, address, birthDate, createDate, isActive, role) VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE(), 1, 'USER')";
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getEmail());
			ps.setString(4, user.getFullname());
			ps.setString(5, user.getPhone());
			ps.setString(6, user.getAddress());
			if (user.getBirthDate() != null) {
				ps.setDate(7, user.getBirthDate());
			} else {
				ps.setNull(7, java.sql.Types.DATE);
			}
			
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
				user.setAddress(rs.getString("address"));
				user.setBirthDate(rs.getDate("birthDate"));
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
		String sql = "UPDATE Users SET fullname = ?, email = ?, phone = ?, address = ?, birthDate = ? WHERE id = ?";
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setString(1, user.getFullname());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPhone());
			ps.setString(4, user.getAddress());
			if (user.getBirthDate() != null) {
				ps.setDate(5, user.getBirthDate());
			} else {
				ps.setNull(5, java.sql.Types.DATE);
			}
			ps.setInt(6, user.getId());
			
			int result = ps.executeUpdate();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// Danh sách tất cả người dùng (ADMIN)
	public List<Users> listAllUsers() {
		List<Users> users = new java.util.ArrayList<>();
		String sql = "SELECT * FROM Users ORDER BY createDate DESC";
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				Users u = new Users();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				u.setEmail(rs.getString("email"));
				u.setFullname(rs.getString("fullname"));
				u.setPhone(rs.getString("phone"));
				u.setAddress(rs.getString("address"));
				u.setBirthDate(rs.getDate("birthDate"));
				u.setCreateDate(rs.getDate("createDate"));
				u.setActive(rs.getBoolean("isActive"));
				u.setRole(rs.getString("role"));
				users.add(u);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return users;
	}

	// Tạo người dùng (ADMIN)
	public boolean createUser(Users user) {
		String sql = "INSERT INTO Users (username, password, email, fullname, phone, address, birthDate, createDate, isActive, role) VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE(), ?, ?)";
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getEmail());
			ps.setString(4, user.getFullname());
			ps.setString(5, user.getPhone());
			ps.setString(6, user.getAddress());
			if (user.getBirthDate() != null) {
				ps.setDate(7, user.getBirthDate());
			} else {
				ps.setNull(7, java.sql.Types.DATE);
			}
			ps.setBoolean(8, user.isActive());
			ps.setString(9, user.getRole());
			return ps.executeUpdate() > 0;
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

	// ADMIN: Cập nhật người dùng (không đổi username/password)
	public boolean updateUserAdmin(Users user) {
		String sql = "UPDATE Users SET fullname = ?, email = ?, phone = ?, address = ?, birthDate = ?, role = ?, isActive = ? WHERE id = ?";
		try (Connection con = DatabaseConnect.dbConnection();
		     PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, user.getFullname());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getPhone());
			ps.setString(4, user.getAddress());
			if (user.getBirthDate() != null) {
				ps.setDate(5, user.getBirthDate());
			} else {
				ps.setNull(5, java.sql.Types.DATE);
			}
			ps.setString(6, user.getRole());
			ps.setBoolean(7, user.isActive());
			ps.setInt(8, user.getId());
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// ADMIN: Xóa (vô hiệu hóa) người dùng
	public boolean deleteUser(int userId) {
		String sql = "UPDATE Users SET isActive = 0 WHERE id = ?";
		try (Connection con = DatabaseConnect.dbConnection();
		     PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, userId);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// ADMIN: Cập nhật vai trò
	public boolean updateUserRole(int userId, String role) {
		String sql = "UPDATE Users SET role = ? WHERE id = ?";
		try (Connection con = DatabaseConnect.dbConnection();
		     PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, role);
			ps.setInt(2, userId);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
