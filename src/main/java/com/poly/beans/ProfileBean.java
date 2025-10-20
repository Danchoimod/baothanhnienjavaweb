package com.poly.beans;

public class ProfileBean {
	private String fullname;
	private String email;
	private String phone;
	private String address;
	private String gender;
	private String birthDate;
	private String oldPassword;
	private String newPassword;
	private String confirmPassword;
	
	// Constructors
	public ProfileBean() {
	}
	
	public ProfileBean(String fullname, String email, String phone, String address, String gender, String birthDate) {
		this.fullname = fullname;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.gender = gender;
		this.birthDate = birthDate;
	}
	
	// Getters and Setters
	public String getFullname() {
		return fullname;
	}
	
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getGender() {
		return gender;
	}
	
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public String getBirthDate() {
		return birthDate;
	}
	
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}
	
	public String getOldPassword() {
		return oldPassword;
	}
	
	public void setOldPassword(String oldPassword) {
		this.oldPassword = oldPassword;
	}
	
	public String getNewPassword() {
		return newPassword;
	}
	
	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	
	public String getConfirmPassword() {
		return confirmPassword;
	}
	
	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}
	
	// Validation methods
	public boolean isValidProfile() {
		return fullname != null && !fullname.trim().isEmpty()
				&& email != null && !email.trim().isEmpty()
				&& isValidEmail(email);
	}
	
	public boolean isValidPasswordChange() {
		return oldPassword != null && !oldPassword.trim().isEmpty()
				&& newPassword != null && !newPassword.trim().isEmpty()
				&& confirmPassword != null && !confirmPassword.trim().isEmpty()
				&& newPassword.equals(confirmPassword)
				&& newPassword.length() >= 6;
	}
	
	public String getProfileErrorMessage() {
		if (fullname == null || fullname.trim().isEmpty()) {
			return "Vui lòng nhập họ và tên";
		}
		if (email == null || email.trim().isEmpty()) {
			return "Vui lòng nhập email";
		}
		if (!isValidEmail(email)) {
			return "Email không hợp lệ";
		}
		return null;
	}
	
	public String getPasswordErrorMessage() {
		if (oldPassword == null || oldPassword.trim().isEmpty()) {
			return "Vui lòng nhập mật khẩu hiện tại";
		}
		if (newPassword == null || newPassword.trim().isEmpty()) {
			return "Vui lòng nhập mật khẩu mới";
		}
		if (newPassword.length() < 6) {
			return "Mật khẩu mới phải có ít nhất 6 ký tự";
		}
		if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
			return "Vui lòng xác nhận mật khẩu mới";
		}
		if (!newPassword.equals(confirmPassword)) {
			return "Mật khẩu xác nhận không khớp";
		}
		return null;
	}
	
	private boolean isValidEmail(String email) {
		String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
		return email.matches(emailRegex);
	}
	
	// Helper method to compare strings ignoring case and null
	private boolean equalsIgnoreCase(String a, String b) {
		if (a == null && b == null) return true;
		if (a == null || b == null) return false;
		return a.trim().equalsIgnoreCase(b.trim());
	}
	
	public boolean isChanged(ProfileBean old) {
		return !equalsIgnoreCase(this.fullname, old.fullname)
			|| !equalsIgnoreCase(this.email, old.email)
			|| !equalsIgnoreCase(this.phone, old.phone)
			|| !equalsIgnoreCase(this.address, old.address)
			|| !equalsIgnoreCase(this.gender, old.gender)
			|| !equalsIgnoreCase(this.birthDate, old.birthDate);
	}
	
	public String getNoChangeMessage(ProfileBean old) {
		if (!isChanged(old)) {
			return "Không có gì thay đổi.";
		}
		return null;
	}

}
