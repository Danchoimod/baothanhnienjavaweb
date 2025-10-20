package com.poly.entities;

import java.sql.Date;

public class NewsEntity {
	private int id;
	private String title;
	private String content;
	private String summary;
	private String image;
	private Date createDate;
	private Date updateDate;
	private int userId;
	private String authorName;
	private int categoryId;
	private String categoryName;
	private int viewCount;
	private boolean isActive;
	
	// Constructors
	public NewsEntity() {
	}
	
	public NewsEntity(int id, String title, String content, String summary, String image, Date createDate, Date updateDate, 
			int userId, String authorName, int categoryId, String categoryName, int viewCount, boolean isActive) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.summary = summary;
		this.image = image;
		this.createDate = createDate;
		this.updateDate = updateDate;
		this.userId = userId;
		this.authorName = authorName;
		this.categoryId = categoryId;
		this.categoryName = categoryName;
		this.viewCount = viewCount;
		this.isActive = isActive;
	}
	
	// Getters and Setters
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
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
	
	public Date getCreateDate() {
		return createDate;
	}
	
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	public Date getUpdateDate() {
		return updateDate;
	}
	
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	
	public int getUserId() {
		return userId;
	}
	
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public String getAuthorName() {
		return authorName;
	}
	
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}
	
	public int getCategoryId() {
		return categoryId;
	}
	
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	
	public String getCategoryName() {
		return categoryName;
	}
	
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
	public int getViewCount() {
		return viewCount;
	}
	
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	
	public boolean isActive() {
		return isActive;
	}
	
	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}
}
