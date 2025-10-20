                                                                                              package com.poly;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.poly.beans.NewsBean;
import com.poly.entities.Category;
import com.poly.entities.NewsEntity;
import com.poly.entities.Users;
import com.poly.services.NewsServices;

@WebServlet({"/news/create", "/news/edit", "/news/list", "/news/delete"})
public class NewsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NewsServices newsServices = new NewsServices();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession(false);
		
		// Kiểm tra đăng nhập
		if (session == null || session.getAttribute("user") == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}
		
		Users currentUser = (Users) session.getAttribute("user");
		String role = currentUser.getRole();
		
		// Kiểm tra quyền EDITOR hoặc ADMIN
		if (!"EDITOR".equals(role) && !"ADMIN".equals(role)) {
			resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này!");
			return;
		}
		
		String path = req.getServletPath();
		
		if (path.equals("/news/create")) {
			showCreatePage(req, resp);
		} else if (path.equals("/news/edit")) {
			showEditPage(req, resp);
		} else if (path.equals("/news/list")) {
			showNewsList(req, resp, currentUser);
		} else if (path.equals("/news/delete")) {
			handleDelete(req, resp);
		}
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
		
		Users currentUser = (Users) session.getAttribute("user");
		String role = currentUser.getRole();
		
		// Kiểm tra quyền EDITOR hoặc ADMIN
		if (!"EDITOR".equals(role) && !"ADMIN".equals(role)) {
			resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này!");
			return;
		}
		
		String path = req.getServletPath();
		
		if (path.equals("/news/create")) {
			handleCreate(req, resp, currentUser);
		} else if (path.equals("/news/edit")) {
			handleEdit(req, resp, currentUser);
		}
	}
	
	private void showCreatePage(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// Lấy danh sách danh mục
		List<Category> categories = newsServices.getAllCategories();
		req.setAttribute("categories", categories);
		req.getRequestDispatcher("/news-create.jsp").forward(req, resp);
	}
	
	private void showEditPage(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String newsIdParam = req.getParameter("id");
		if (newsIdParam == null || newsIdParam.isEmpty()) {
			resp.sendRedirect(req.getContextPath() + "/news/list");
			return;
		}
		
		int newsId = Integer.parseInt(newsIdParam);
		NewsEntity news = newsServices.getNewsById(newsId);
		
		if (news == null) {
			resp.sendRedirect(req.getContextPath() + "/news/list");
			return;
		}
		
		// Lấy danh sách danh mục
		List<Category> categories = newsServices.getAllCategories();
		req.setAttribute("categories", categories);
		req.setAttribute("news", news);
		req.getRequestDispatcher("/news-edit.jsp").forward(req, resp);
	}
	
	private void showNewsList(HttpServletRequest req, HttpServletResponse resp, Users currentUser)
			throws ServletException, IOException {
		// Lấy danh sách tin tức của user
		List<NewsEntity> newsList = newsServices.getNewsByUserId(currentUser.getId());
		req.setAttribute("newsList", newsList);
		req.getRequestDispatcher("/news-list.jsp").forward(req, resp);
	}
	
	private void handleCreate(HttpServletRequest req, HttpServletResponse resp, Users currentUser)
			throws ServletException, IOException {
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String summary = req.getParameter("summary");
		String image = req.getParameter("image");
		String categoryIdParam = req.getParameter("categoryId");
		
		int categoryId = 0;
		try {
			categoryId = Integer.parseInt(categoryIdParam);
		} catch (Exception e) {
		}
		
		NewsBean newsBean = new NewsBean(title, content, summary, image, categoryId);
		
		// Validate
		if (!newsBean.isValid()) {
			List<Category> categories = newsServices.getAllCategories();
			req.setAttribute("categories", categories);
			req.setAttribute("error", newsBean.getErrorMessage());
			req.setAttribute("newsBean", newsBean);
			req.getRequestDispatcher("/news-create.jsp").forward(req, resp);
			return;
		}
		
		// Tạo tin tức mới
		NewsEntity news = new NewsEntity();
		news.setTitle(title);
		news.setContent(content);
		news.setSummary(summary);
		news.setImage(image);
		news.setUserId(currentUser.getId());
		news.setCategoryId(categoryId);
		
		boolean success = newsServices.createNews(news);
		
		if (success) {
			resp.sendRedirect(req.getContextPath() + "/news/list?success=create");
		} else {
			List<Category> categories = newsServices.getAllCategories();
			req.setAttribute("categories", categories);
			req.setAttribute("error", "Đăng tin tức thất bại! Vui lòng thử lại.");
			req.setAttribute("newsBean", newsBean);
			req.getRequestDispatcher("/news-create.jsp").forward(req, resp);
		}
	}
	
	private void handleEdit(HttpServletRequest req, HttpServletResponse resp, Users currentUser)
			throws ServletException, IOException {
		String newsIdParam = req.getParameter("id");
		if (newsIdParam == null || newsIdParam.isEmpty()) {
			resp.sendRedirect(req.getContextPath() + "/news/list");
			return;
		}
		
		int newsId = Integer.parseInt(newsIdParam);
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String summary = req.getParameter("summary");
		String image = req.getParameter("image");
		String categoryIdParam = req.getParameter("categoryId");
		
		int categoryId = 0;
		try {
			categoryId = Integer.parseInt(categoryIdParam);
		} catch (Exception e) {
		}
		
		NewsBean newsBean = new NewsBean(title, content, summary, image, categoryId);
		
		// Validate
		if (!newsBean.isValid()) {
			List<Category> categories = newsServices.getAllCategories();
			NewsEntity news = newsServices.getNewsById(newsId);
			req.setAttribute("categories", categories);
			req.setAttribute("news", news);
			req.setAttribute("error", newsBean.getErrorMessage());
			req.getRequestDispatcher("/news-edit.jsp").forward(req, resp);
			return;
		}
		
		// Cập nhật tin tức
		NewsEntity news = new NewsEntity();
		news.setId(newsId);
		news.setTitle(title);
		news.setContent(content);
		news.setSummary(summary);
		news.setImage(image);
		news.setCategoryId(categoryId);
		
		boolean success = newsServices.updateNews(news);
		
		if (success) {
			resp.sendRedirect(req.getContextPath() + "/news/list?success=update");
		} else {
			List<Category> categories = newsServices.getAllCategories();
			NewsEntity newsData = newsServices.getNewsById(newsId);
			req.setAttribute("categories", categories);
			req.setAttribute("news", newsData);
			req.setAttribute("error", "Cập nhật tin tức thất bại! Vui lòng thử lại.");
			req.getRequestDispatcher("/news-edit.jsp").forward(req, resp);
		}
	}
	
	private void handleDelete(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		String newsIdParam = req.getParameter("id");
		if (newsIdParam != null && !newsIdParam.isEmpty()) {
			int newsId = Integer.parseInt(newsIdParam);
			newsServices.deleteNews(newsId);
		}
		resp.sendRedirect(req.getContextPath() + "/news/list?success=delete");
	}
}
