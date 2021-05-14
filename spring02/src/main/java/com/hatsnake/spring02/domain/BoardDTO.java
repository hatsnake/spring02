package com.hatsnake.spring02.domain;

import java.util.Arrays;
import java.util.Date;

public class BoardDTO {
	private int bno; //게시글 번호
	private String title; //게시글 제목
	private String content; //게시글 내용
	private String writer; //게시글 작성자
	private Date regdate; //게시글 작성일자
	private int viewcnt; //게시글 조회수
	private int recnt; //게시글 댓글 수
	private String show; //게시글 삭제 상태 유무(y,n)
	private String[] files;
	private int categoryid;
	private String categoryname;
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	public int getRecnt() {
		return recnt;
	}
	public void setRecnt(int recnt) {
		this.recnt = recnt;
	}
	public String getShow() {
		return show;
	}
	public void setShow(String show) {
		this.show = show;
	}
	public String[] getFiles() {
		return files;
	}
	public void setFiles(String[] files) {
		this.files = files;
	}
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
		return "BoardDTO [bno=" + bno + ", title=" + title + ", content=" + content + ", writer=" + writer + ", regdate="
				+ regdate + ", viewcnt=" + viewcnt + ", recnt=" + recnt + ", show=" + show + ", files=" + Arrays.toString(files)
				+ ", categoryid=" + categoryid + ", categoryname=" + categoryname + "]";
	}
	
}
