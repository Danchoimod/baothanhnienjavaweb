package com.poly.services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.poly.config.DatabaseConnect;
import com.poly.entities.Category;
import com.poly.entities.NewsEntity;

public class NewsServices {
	
	// Lấy tất cả danh mục
	public List<Category> getAllCategories() {
		List<Category> categories = new ArrayList<>();
		String sql = "SELECT * FROM Category WHERE isActive = 1 ORDER BY name";
		
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			
			while (rs.next()) {
				Category category = new Category();
				category.setId(rs.getInt("id"));
				category.setName(rs.getString("name"));
				category.setDescription(rs.getString("description"));
				category.setActive(rs.getBoolean("isActive"));
				categories.add(category);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return categories;
	}

	// ADMIN: Lấy tất cả danh mục (bao gồm inactive)
	public List<Category> getAllCategoriesAdmin() {
		List<Category> categories = new ArrayList<>();
		String sql = "SELECT * FROM Category ORDER BY isActive DESC, name";
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				Category category = new Category();
				category.setId(rs.getInt("id"));
				category.setName(rs.getString("name"));
				category.setDescription(rs.getString("description"));
				category.setActive(rs.getBoolean("isActive"));
				categories.add(category);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return categories;
	}

	// ADMIN: Tạo danh mục
	public boolean createCategory(Category category) {
		String sql = "INSERT INTO Category (name, description, isActive) VALUES (?, ?, 1)";
		try (Connection con = DatabaseConnect.dbConnection();
		     PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, category.getName());
			ps.setString(2, category.getDescription());
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// ADMIN: Cập nhật danh mục
	public boolean updateCategory(Category category) {
		String sql = "UPDATE Category SET name = ?, description = ?, isActive = ? WHERE id = ?";
		try (Connection con = DatabaseConnect.dbConnection();
		     PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, category.getName());
			ps.setString(2, category.getDescription());
			ps.setBoolean(3, category.isActive());
			ps.setInt(4, category.getId());
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// ADMIN: Xóa (vô hiệu hóa) danh mục
	public boolean deleteCategory(int categoryId) {
		String sql = "UPDATE Category SET isActive = 0 WHERE id = ?";
		try (Connection con = DatabaseConnect.dbConnection();
		     PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, categoryId);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// ADMIN: Xóa vĩnh viễn danh mục (hard delete)
	public boolean deleteCategoryHard(int categoryId) {
		String sql = "DELETE FROM Category WHERE id = ?";
		try (Connection con = DatabaseConnect.dbConnection();
		     PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, categoryId);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			// Có thể thất bại do ràng buộc khóa ngoại với News
			e.printStackTrace();
		}
		return false;
	}
	
	// Tạo tin tức mới
	public boolean createNews(NewsEntity news) {
		String sql = "INSERT INTO News (title, content, summary, image, userId, categoryId, createDate, isActive) " +
					 "VALUES (?, ?, ?, ?, ?, ?, GETDATE(), 1)";
		
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setString(1, news.getTitle());
			ps.setString(2, news.getContent());
			ps.setString(3, news.getSummary());
			ps.setString(4, news.getImage());
			ps.setInt(5, news.getUserId());
			ps.setInt(6, news.getCategoryId());
			
			int result = ps.executeUpdate();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// Cập nhật tin tức
	public boolean updateNews(NewsEntity news) {
		String sql = "UPDATE News SET title = ?, content = ?, summary = ?, image = ?, " +
					 "categoryId = ?, updateDate = GETDATE() WHERE id = ?";
		
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setString(1, news.getTitle());
			ps.setString(2, news.getContent());
			ps.setString(3, news.getSummary());
			ps.setString(4, news.getImage());
			ps.setInt(5, news.getCategoryId());
			ps.setInt(6, news.getId());
			
			int result = ps.executeUpdate();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// Lấy danh sách tin tức của một user
	public List<NewsEntity> getNewsByUserId(int userId) {
		List<NewsEntity> newsList = new ArrayList<>();
		String sql = "SELECT n.*, c.name as categoryName, u.fullname as authorName " +
					 "FROM News n " +
					 "INNER JOIN Category c ON n.categoryId = c.id " +
					 "INNER JOIN Users u ON n.userId = u.id " +
					 "WHERE n.userId = ? " +
					 "ORDER BY n.createDate DESC";
		
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				NewsEntity news = new NewsEntity();
				news.setId(rs.getInt("id"));
				news.setTitle(rs.getString("title"));
				news.setContent(rs.getString("content"));
				news.setSummary(rs.getString("summary"));
				news.setImage(rs.getString("image"));
				news.setCreateDate(rs.getDate("createDate"));
				news.setUpdateDate(rs.getDate("updateDate"));
				news.setUserId(rs.getInt("userId"));
				news.setAuthorName(rs.getString("authorName"));
				news.setCategoryId(rs.getInt("categoryId"));
				news.setCategoryName(rs.getString("categoryName"));
				news.setViewCount(rs.getInt("viewCount"));
				news.setActive(rs.getBoolean("isActive"));
				newsList.add(news);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return newsList;
	}
	
	// Lấy tin tức theo ID
	public NewsEntity getNewsById(int newsId) {
		String sql = "SELECT n.*, c.name as categoryName, u.fullname as authorName " +
					 "FROM News n " +
					 "INNER JOIN Category c ON n.categoryId = c.id " +
					 "INNER JOIN Users u ON n.userId = u.id " +
					 "WHERE n.id = ?";
		
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setInt(1, newsId);
			ResultSet rs = ps.executeQuery();
			
			if (rs.next()) {
				NewsEntity news = new NewsEntity();
				news.setId(rs.getInt("id"));
				news.setTitle(rs.getString("title"));
				news.setContent(rs.getString("content"));
				news.setSummary(rs.getString("summary"));
				news.setImage(rs.getString("image"));
				news.setCreateDate(rs.getDate("createDate"));
				news.setUpdateDate(rs.getDate("updateDate"));
				news.setUserId(rs.getInt("userId"));
				news.setAuthorName(rs.getString("authorName"));
				news.setCategoryId(rs.getInt("categoryId"));
				news.setCategoryName(rs.getString("categoryName"));
				news.setViewCount(rs.getInt("viewCount"));
				news.setActive(rs.getBoolean("isActive"));
				return news;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// Xóa tin tức (soft delete)
	public boolean deleteNews(int newsId) {
		String sql = "UPDATE News SET isActive = 0 WHERE id = ?";
		
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setInt(1, newsId);
			int result = ps.executeUpdate();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// Xóa tin tức (hard delete)
	public boolean deleteNewsHard(int newsId) {
		String sql = "DELETE FROM News WHERE id = ?";
		try (Connection con = DatabaseConnect.dbConnection();
		     PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, newsId);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// Lấy tất cả tin tức đang hoạt động (cho trang chủ)
	public List<NewsEntity> getAllActiveNews() {
		List<NewsEntity> newsList = new ArrayList<>();
		String sql = "SELECT n.*, c.name as categoryName, u.fullname as authorName " +
					 "FROM News n " +
					 "INNER JOIN Category c ON n.categoryId = c.id " +
					 "INNER JOIN Users u ON n.userId = u.id " +
					 "WHERE n.isActive = 1 " +
					 "ORDER BY n.createDate DESC";
		
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			
			while (rs.next()) {
				NewsEntity news = new NewsEntity();
				news.setId(rs.getInt("id"));
				news.setTitle(rs.getString("title"));
				news.setContent(rs.getString("content"));
				news.setSummary(rs.getString("summary"));
				news.setImage(rs.getString("image"));
				news.setCreateDate(rs.getDate("createDate"));
				news.setUpdateDate(rs.getDate("updateDate"));
				news.setUserId(rs.getInt("userId"));
				news.setAuthorName(rs.getString("authorName"));
				news.setCategoryId(rs.getInt("categoryId"));
				news.setCategoryName(rs.getString("categoryName"));
				news.setViewCount(rs.getInt("viewCount"));
				news.setActive(rs.getBoolean("isActive"));
				newsList.add(news);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return newsList;
	}
	
	// Tăng số lượt xem tin tức
	public boolean incrementViewCount(int newsId) {
		String sql = "UPDATE News SET viewCount = viewCount + 1 WHERE id = ?";
		
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setInt(1, newsId);
			int result = ps.executeUpdate();
			return result > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// Lấy tin tức liên quan (cùng danh mục, khác ID)
	public List<NewsEntity> getRelatedNews(int newsId, int categoryId, int limit) {
		List<NewsEntity> newsList = new ArrayList<>();
		String sql = "SELECT TOP " + limit + " n.*, c.name as categoryName, u.fullname as authorName " +
					 "FROM News n " +
					 "INNER JOIN Category c ON n.categoryId = c.id " +
					 "INNER JOIN Users u ON n.userId = u.id " +
					 "WHERE n.isActive = 1 AND n.categoryId = ? AND n.id != ? " +
					 "ORDER BY n.viewCount DESC, n.createDate DESC";
		
		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			
			ps.setInt(1, categoryId);
			ps.setInt(2, newsId);
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				NewsEntity news = new NewsEntity();
				news.setId(rs.getInt("id"));
				news.setTitle(rs.getString("title"));
				news.setContent(rs.getString("content"));
				news.setSummary(rs.getString("summary"));
				news.setImage(rs.getString("image"));
				news.setCreateDate(rs.getDate("createDate"));
				news.setUpdateDate(rs.getDate("updateDate"));
				news.setUserId(rs.getInt("userId"));
				news.setAuthorName(rs.getString("authorName"));
				news.setCategoryId(rs.getInt("categoryId"));
				news.setCategoryName(rs.getString("categoryName"));
				news.setViewCount(rs.getInt("viewCount"));
				news.setActive(rs.getBoolean("isActive"));
				newsList.add(news);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return newsList;
	}

	// Lấy tin tức đang hoạt động theo danh mục
	public List<NewsEntity> getActiveNewsByCategory(int categoryId) {
		List<NewsEntity> newsList = new ArrayList<>();
		String sql = "SELECT n.*, c.name as categoryName, u.fullname as authorName " +
					 "FROM News n " +
					 "INNER JOIN Category c ON n.categoryId = c.id " +
					 "INNER JOIN Users u ON n.userId = u.id " +
					 "WHERE n.isActive = 1 AND n.categoryId = ? " +
					 "ORDER BY n.createDate DESC";

		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, categoryId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				NewsEntity news = new NewsEntity();
				news.setId(rs.getInt("id"));
				news.setTitle(rs.getString("title"));
				news.setContent(rs.getString("content"));
				news.setSummary(rs.getString("summary"));
				news.setImage(rs.getString("image"));
				news.setCreateDate(rs.getDate("createDate"));
				news.setUpdateDate(rs.getDate("updateDate"));
				news.setUserId(rs.getInt("userId"));
				news.setAuthorName(rs.getString("authorName"));
				news.setCategoryId(rs.getInt("categoryId"));
				news.setCategoryName(rs.getString("categoryName"));
				news.setViewCount(rs.getInt("viewCount"));
				news.setActive(rs.getBoolean("isActive"));
				newsList.add(news);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return newsList;
	}

	// Lấy tất cả tin tức (ADMIN - cả active và inactive)
	public List<NewsEntity> getAllNews() {
		List<NewsEntity> newsList = new ArrayList<>();
		String sql = "SELECT n.*, c.name as categoryName, u.fullname as authorName " +
				 "FROM News n " +
				 "INNER JOIN Category c ON n.categoryId = c.id " +
				 "INNER JOIN Users u ON n.userId = u.id " +
				 "ORDER BY n.createDate DESC";

		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				NewsEntity news = new NewsEntity();
				news.setId(rs.getInt("id"));
				news.setTitle(rs.getString("title"));
				news.setContent(rs.getString("content"));
				news.setSummary(rs.getString("summary"));
				news.setImage(rs.getString("image"));
				news.setCreateDate(rs.getDate("createDate"));
				news.setUpdateDate(rs.getDate("updateDate"));
				news.setUserId(rs.getInt("userId"));
				news.setAuthorName(rs.getString("authorName"));
				news.setCategoryId(rs.getInt("categoryId"));
				news.setCategoryName(rs.getString("categoryName"));
				news.setViewCount(rs.getInt("viewCount"));
				news.setActive(rs.getBoolean("isActive"));
				newsList.add(news);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return newsList;
	}

	// Lấy top tin xem nhiều
	public List<NewsEntity> getMostViewed(int limit) {
		List<NewsEntity> newsList = new ArrayList<>();
		String sql = "SELECT TOP " + limit + " n.*, c.name as categoryName, u.fullname as authorName " +
				 "FROM News n " +
				 "INNER JOIN Category c ON n.categoryId = c.id " +
				 "INNER JOIN Users u ON n.userId = u.id " +
				 "WHERE n.isActive = 1 " +
				 "ORDER BY n.viewCount DESC, n.createDate DESC";

		try (Connection con = DatabaseConnect.dbConnection();
			 PreparedStatement ps = con.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				NewsEntity news = new NewsEntity();
				news.setId(rs.getInt("id"));
				news.setTitle(rs.getString("title"));
				news.setContent(rs.getString("content"));
				news.setSummary(rs.getString("summary"));
				news.setImage(rs.getString("image"));
				news.setCreateDate(rs.getDate("createDate"));
				news.setUpdateDate(rs.getDate("updateDate"));
				news.setUserId(rs.getInt("userId"));
				news.setAuthorName(rs.getString("authorName"));
				news.setCategoryId(rs.getInt("categoryId"));
				news.setCategoryName(rs.getString("categoryName"));
				news.setViewCount(rs.getInt("viewCount"));
				news.setActive(rs.getBoolean("isActive"));
				newsList.add(news);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return newsList;
	}
}
