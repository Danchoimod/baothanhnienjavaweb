package com.poly;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.poly.entities.NewsEntity;
import com.poly.services.NewsServices;


@WebServlet("/home")
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private NewsServices newsServices = new NewsServices();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// Lấy danh sách tất cả tin tức đã được phê duyệt (isActive = 1)
		List<NewsEntity> allNews = newsServices.getAllActiveNews();
		
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
