package com.poly;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.poly.beans.ProfileBean;
import com.poly.entities.Users;
import com.poly.services.UsersServices;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UsersServices usersServices = new UsersServices();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		
		// Kiểm tra đăng nhập
		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}
		
		// Lấy thông tin user từ session
		Users user = (Users) session.getAttribute("user");
		
		// Tạo ProfileBean từ thông tin user
		ProfileBean profileBean = new ProfileBean();
		profileBean.setFullname(user.getFullname());
		profileBean.setEmail(user.getEmail());
		profileBean.setPhone(user.getPhone());
		
		req.setAttribute("profile", profileBean);
		req.getRequestDispatcher("/profile.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
		HttpSession session = req.getSession(false);
		
		// Kiểm tra đăng nhập
		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}
		
		String action = req.getParameter("action");
		
		if ("updateProfile".equals(action)) {
			handleUpdateProfile(req, resp, session);
		} else if ("changePassword".equals(action)) {
			handleChangePassword(req, resp, session);
		}
	}
	
	private void handleUpdateProfile(HttpServletRequest req, HttpServletResponse resp, HttpSession session)
			throws ServletException, IOException {
		Users currentUser = (Users) session.getAttribute("user");
		
		String fullname = req.getParameter("fullname");
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		String address = req.getParameter("address");
		String gender = req.getParameter("gender");
		String birthDate = req.getParameter("birthDate");
		
		ProfileBean profileBean = new ProfileBean();
		profileBean.setFullname(fullname);
		profileBean.setEmail(email);
		profileBean.setPhone(phone);
		profileBean.setAddress(address);
		profileBean.setGender(gender);
		profileBean.setBirthDate(birthDate);
		
		// Validate
		if (!profileBean.isValidProfile()) {
			req.setAttribute("profileError", profileBean.getProfileErrorMessage());
			req.setAttribute("profile", profileBean);
			req.setAttribute("activeTab", "profile");
			req.getRequestDispatcher("/profile.jsp").forward(req, resp);
			return;
		}
		
		// Tạo ProfileBean từ thông tin cũ để so sánh
		ProfileBean oldBean = new ProfileBean();
		oldBean.setFullname(currentUser.getFullname());
		oldBean.setEmail(currentUser.getEmail());
		oldBean.setPhone(currentUser.getPhone());
		oldBean.setAddress(address); // Giả sử address, gender, birthDate không có trong Users hiện tại
		oldBean.setGender(gender);
		oldBean.setBirthDate(birthDate);
		
		// Kiểm tra nếu không có gì thay đổi
		String noChangeMsg = profileBean.getNoChangeMessage(oldBean);
		if (noChangeMsg != null) {
			req.setAttribute("profileError", noChangeMsg);
			req.setAttribute("profile", profileBean);
			req.setAttribute("activeTab", "profile");
			req.getRequestDispatcher("/profile.jsp").forward(req, resp);
			return;
		}
		
		// Cập nhật thông tin
		currentUser.setFullname(fullname);
		currentUser.setEmail(email);
		currentUser.setPhone(phone);
		
		boolean success = usersServices.updateUserProfile(currentUser);
		
		if (success) {
			// Cập nhật lại session
			session.setAttribute("user", currentUser);
			session.setAttribute("fullname", currentUser.getFullname());
			
			req.setAttribute("profileSuccess", "Cập nhật thông tin thành công!");
			req.setAttribute("profile", profileBean);
			req.setAttribute("activeTab", "profile");
		} else {
			req.setAttribute("profileError", "Cập nhật thông tin thất bại!");
			req.setAttribute("profile", profileBean);
			req.setAttribute("activeTab", "profile");
		}
		
		req.getRequestDispatcher("/profile.jsp").forward(req, resp);
	}
	
	private void handleChangePassword(HttpServletRequest req, HttpServletResponse resp, HttpSession session)
			throws ServletException, IOException {
		Users currentUser = (Users) session.getAttribute("user");
		
		String oldPassword = req.getParameter("oldPassword");
		String newPassword = req.getParameter("newPassword");
		String confirmPassword = req.getParameter("confirmPassword");
		
		ProfileBean profileBean = new ProfileBean();
		profileBean.setOldPassword(oldPassword);
		profileBean.setNewPassword(newPassword);
		profileBean.setConfirmPassword(confirmPassword);
		
		// Validate
		if (!profileBean.isValidPasswordChange()) {
			req.setAttribute("passwordError", profileBean.getPasswordErrorMessage());
			req.setAttribute("activeTab", "password");
			req.getRequestDispatcher("/profile.jsp").forward(req, resp);
			return;
		}
		
		// Kiểm tra mật khẩu cũ
		if (!currentUser.getPassword().equals(oldPassword)) {
			req.setAttribute("passwordError", "Mật khẩu hiện tại không đúng!");
			req.setAttribute("activeTab", "password");
			req.getRequestDispatcher("/profile.jsp").forward(req, resp);
			return;
		}
		
		// Cập nhật mật khẩu
		boolean success = usersServices.changePassword(currentUser.getId(), newPassword);
		
		if (success) {
			currentUser.setPassword(newPassword);
			session.setAttribute("user", currentUser);
			
			req.setAttribute("passwordSuccess", "Đổi mật khẩu thành công!");
			req.setAttribute("activeTab", "password");
		} else {
			req.setAttribute("passwordError", "Đổi mật khẩu thất bại!");
			req.setAttribute("activeTab", "password");
		}
		
		req.getRequestDispatcher("/profile.jsp").forward(req, resp);
	}
}
