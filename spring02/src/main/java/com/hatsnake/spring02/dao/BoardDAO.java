package com.hatsnake.spring02.dao;

import java.util.List;

import com.hatsnake.spring02.domain.BoardDTO;

public interface BoardDAO {

	public List<BoardDTO> listAll(int start, int end, String searchOption, String keyword) throws Exception;
	
	public List<BoardDTO> listLimit() throws Exception;
	
	public int countArticle(String searchOption, String keyword) throws Exception;

	public BoardDTO read(int bno) throws Exception;

	public void increaseViewctn(int bno) throws Exception;

	public void create(BoardDTO dto) throws Exception;

	public void delete(int bno) throws Exception;

	public void update(BoardDTO dto) throws Exception;
	
	public void addAttach(String fullName);
	
	public List<String> getAttach(int bno);
	
	public void updateAttach(String fullName, int bno);
	
	public void deleteFile(String fullname);

}
