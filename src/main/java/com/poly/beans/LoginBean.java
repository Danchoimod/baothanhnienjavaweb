package com.poly.beans;

public class LoginBean {
	private String username;
	private String password;
	
	// Constructors
	public LoginBean() {
	}
	
	public LoginBean(String username, String password) {
		this.username = username;
		this.password = password;
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
	
	// Validation methods
	public boolean isValid() {
		return username != null && !username.trim().isEmpty() 
				&& password != null && !password.trim().isEmpty();
	}
	
	public String getErrorMessage() {
		if (username == null || username.trim().isEmpty()) {
			return "Vui lòng nhập tên đăng nhập";
		}
		if (password == null || password.trim().isEmpty()) {
			return "Vui lòng nhập mật khẩu";
		}
		return null;
	}
}
