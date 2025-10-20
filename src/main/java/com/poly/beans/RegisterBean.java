package com.poly.beans;

public class RegisterBean {
	private String username;
	private String password;
	private String confirmPassword;
	private String email;
	private String fullname;
	private String phone;
	
	// Constructors
	public RegisterBean() {
	}
	
	public RegisterBean(String username, String password, String confirmPassword, String email, String fullname, String phone) {
		this.username = username;
		this.password = password;
		this.confirmPassword = confirmPassword;
		this.email = email;
		this.fullname = fullname;
		this.phone = phone;
	}
	
	// Getters and Setters
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getConfirmPassword() {
		return confirmPassword;
	}
	
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getFullname() {
		return fullname;
	}
	
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	// Validation methods
	public boolean isValid() {
		return username != null && !username.trim().isEmpty()
				&& password != null && !password.trim().isEmpty()
				&& confirmPassword != null && !confirmPassword.trim().isEmpty()
				&& email != null && !email.trim().isEmpty()
				&& fullname != null && !fullname.trim().isEmpty()
				&& password.equals(confirmPassword)
				&& isValidEmail(email);
	}
	
	public String getErrorMessage() {
		if (username == null || username.trim().isEmpty()) {
			return "Vui lòng nhập tên đăng nhập";
		}
		if (username.length() < 4) {
			return "Tên đăng nhập phải có ít nhất 4 ký tự";
		}
		if (password == null || password.trim().isEmpty()) {
			return "Vui lòng nhập mật khẩu";
		}
		if (password.length() < 6) {
			return "Mật khẩu phải có ít nhất 6 ký tự";
		}
		if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
			return "Vui lòng xác nhận mật khẩu";
		}
		if (!password.equals(confirmPassword)) {
			return "Mật khẩu xác nhận không khớp";
		}
		if (email == null || email.trim().isEmpty()) {
			return "Vui lòng nhập email";
		}
		if (!isValidEmail(email)) {
			return "Email không hợp lệ";
		}
		if (fullname == null || fullname.trim().isEmpty()) {
			return "Vui lòng nhập họ và tên";
		}
		return null;
	}
	
	private boolean isValidEmail(String email) {
		String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
		return email.matches(emailRegex);
	}
}
