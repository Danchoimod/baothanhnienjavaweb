package com.poly;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.poly.beans.LoginBean;
import com.poly.beans.RegisterBean;
import com.poly.entities.Users;
import com.poly.services.UsersServices;

@WebServlet({"/login", "/register", "/logout"})
public class AuthController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UsersServices usersServices = new UsersServices();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String path = req.getServletPath();
		
		if (path.equals("/logout")) {
			handleLogout(req, resp);
		} else {
			req.getRequestDispatcher("/auth.jsp").forward(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
		String path = req.getServletPath();
		
		if (path.equals("/login")) {
			handleLogin(req, resp);
		} else if (path.equals("/register")) {
			handleRegister(req, resp);
		}
	}
	
	private void handleLogin(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		
		LoginBean loginBean = new LoginBean(username, password);
		
		// Validate form
		if (!loginBean.isValid()) {
			req.setAttribute("loginError", loginBean.getErrorMessage());
			req.setAttribute("activeTab", "login");
			req.getRequestDispatcher("/auth.jsp").forward(req, resp);
			return;
		}
		
		// Kiểm tra đăng nhập
		Users user = usersServices.login(username, password);
		if (user != null) {
			// Lưu thông tin user vào session
			HttpSession session = req.getSession();
			session.setAttribute("user", user);
			session.setAttribute("username", user.getUsername());
			session.setAttribute("fullname", user.getFullname());
			session.setAttribute("role", user.getRole());
			
			// Redirect về trang chủ
			resp.sendRedirect(req.getContextPath() + "/home");
		} else {
			req.setAttribute("loginError", "Tên đăng nhập hoặc mật khẩu không đúng!");
			req.setAttribute("activeTab", "login");
			req.getRequestDispatcher("/auth.jsp").forward(req, resp);
		}
	}
	
	private void handleRegister(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String confirmPassword = req.getParameter("confirmPassword");
		String email = req.getParameter("email");
		String fullname = req.getParameter("fullname");
		String phone = req.getParameter("phone");
		
		RegisterBean registerBean = new RegisterBean(username, password, confirmPassword, email, fullname, phone);
		
		// Validate form
		if (!registerBean.isValid()) {
			req.setAttribute("registerError", registerBean.getErrorMessage());
			req.setAttribute("activeTab", "register");
			req.setAttribute("registerData", registerBean);
			req.getRequestDispatcher("/auth.jsp").forward(req, resp);
			return;
		}
		
		// Kiểm tra username đã tồn tại
		if (usersServices.isUsernameExists(username)) {
			req.setAttribute("registerError", "Tên đăng nhập đã tồn tại!");
			req.setAttribute("activeTab", "register");
			req.setAttribute("registerData", registerBean);
			req.getRequestDispatcher("/auth.jsp").forward(req, resp);
			return;
		}
		
		// Kiểm tra email đã tồn tại
		if (usersServices.isEmailExists(email)) {
			req.setAttribute("registerError", "Email đã được sử dụng!");
			req.setAttribute("activeTab", "register");
			req.setAttribute("registerData", registerBean);
			req.getRequestDispatcher("/auth.jsp").forward(req, resp);
			return;
		}
		
		// Tạo user mới
		Users newUser = new Users();
		newUser.setUsername(username);
		newUser.setPassword(password);
		newUser.setEmail(email);
		newUser.setFullname(fullname);
		newUser.setPhone(phone);
		
		// Đăng ký
		boolean success = usersServices.register(newUser);
		if (success) {
			req.setAttribute("registerSuccess", "Đăng ký thành công! Vui lòng đăng nhập.");
			req.setAttribute("activeTab", "login");
			req.getRequestDispatcher("/auth.jsp").forward(req, resp);
		} else {
			req.setAttribute("registerError", "Đăng ký thất bại! Vui lòng thử lại.");
			req.setAttribute("activeTab", "register");
			req.setAttribute("registerData", registerBean);
			req.getRequestDispatcher("/auth.jsp").forward(req, resp);
		}
	}
	
	private void handleLogout(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		HttpSession session = req.getSession(false);
		if (session != null) {
			session.invalidate();
		}
		resp.sendRedirect(req.getContextPath() + "/home");
	}
}
