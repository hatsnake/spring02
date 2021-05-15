package com.hatsnake.spring02.domain;

public class CategoryDTO {
	private int categoryid;
	private String categoryname;
	
	public int getCategoryid() {
		return categoryid;
	}
	public void setCategoryid(int categoryid) {
		this.categoryid = categoryid;
	}
	public String getCategoryname() {
		return categoryname;
	}
	public void setCategoryname(String categoryname) {
		this.categoryname = categoryname;
	}
	
	@Override
	public String toString() {
		return "CategoryDTO [categoryid=" + categoryid + ", categoryname=" + categoryname + "]";
	}

}
