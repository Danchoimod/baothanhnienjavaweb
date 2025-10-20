package com.poly.beans;

public class NewsBean {
	private String title;
	private String content;
	private String summary;
	private String image;
	private int categoryId;
	
	// Constructors
	public NewsBean() {
	}
	
	public NewsBean(String title, String content, String summary, String image, int categoryId) {
		this.title = title;
		this.content = content;
		this.summary = summary;
		this.image = image;
		this.categoryId = categoryId;
	}
	
	// Getters and Setters
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getSummary() {
		return summary;
	}
	
	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	public String getImage() {
		return image;
	}
	
	public void setImage(String image) {
		this.image = image;
	}
	
	public int getCategoryId() {
		return categoryId;
	}
	
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	
	// Validation methods
	public boolean isValid() {
		return title != null && !title.trim().isEmpty()
				&& content != null && !content.trim().isEmpty()
				&& categoryId > 0;
	}
	
	public String getErrorMessage() {
		if (title == null || title.trim().isEmpty()) {
			return "Vui lòng nhập tiêu đề tin tức";
		}
		if (title.length() < 10) {
			return "Tiêu đề phải có ít nhất 10 ký tự";
		}
		if (content == null || content.trim().isEmpty()) {
			return "Vui lòng nhập nội dung tin tức";
		}
		if (content.length() < 50) {
			return "Nội dung phải có ít nhất 50 ký tự";
		}
		if (categoryId <= 0) {
			return "Vui lòng chọn danh mục";
		}
		return null;
	}
}
