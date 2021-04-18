package com.hatsnake.spring02.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.hatsnake.spring02.domain.BoardDTO;

public interface BoardService {

	
	// public List<BoardDTO> listAll() throws Exception;
	
	public BoardDTO read(int bno) throws Exception;
	
	public void increaseViewcnt(int bno, HttpSession session) throws Exception;
	
	public void create(BoardDTO dto) throws Exception;
	
	public void update(BoardDTO dto) throws Exception;
	
	public void delete(int bno) throws Exception;

	public List<BoardDTO> listAll(int start, int end, String searchOption, String keyword) throws Exception;

	public int countArticle(String searchOption, String keyword) throws Exception;

	public List<String> getAttach(int bno);
	
	public void deleteFile(String fullname);
}
