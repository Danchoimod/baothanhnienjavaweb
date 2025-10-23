package com.poly;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.poly.entities.NewsEntity;
import com.poly.entities.Category;
import com.poly.services.NewsServices;


@WebServlet("/home")
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NewsServices newsServices = new NewsServices();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// Lấy danh sách danh mục để hiển thị bộ lọc
		List<Category> categories = newsServices.getAllCategories();
		req.setAttribute("categories", categories);

		// Lọc theo danh mục nếu có tham số categoryId
		String categoryIdParam = req.getParameter("categoryId");
		Integer selectedCategoryId = null;
		List<NewsEntity> allNews;
		if (categoryIdParam != null && !categoryIdParam.isEmpty()) {
			try {
				selectedCategoryId = Integer.parseInt(categoryIdParam);
				allNews = newsServices.getActiveNewsByCategory(selectedCategoryId);
			} catch (NumberFormatException e) {
				// Nếu tham số không hợp lệ, vẫn hiển thị tất cả
				allNews = newsServices.getAllActiveNews();
				selectedCategoryId = null;
			}
		} else {
			allNews = newsServices.getAllActiveNews();
		}
		req.setAttribute("selectedCategoryId", selectedCategoryId);
		
		// Tin nổi bật (tin mới nhất)
		NewsEntity featuredNews = null;
		if (allNews != null && !allNews.isEmpty()) {
			featuredNews = allNews.get(0);
		}
		
		req.setAttribute("featuredNews", featuredNews);
		req.setAttribute("allNews", allNews);
		
		// dòng trỏ về giao diện này phải nằm cuối phương thức
		req.getRequestDispatcher("/home.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doGet(req, resp);
	}
}
