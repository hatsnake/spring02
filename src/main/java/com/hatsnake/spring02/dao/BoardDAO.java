package com.hatsnake.spring02.dao;

import java.util.List;
import java.util.Map;

import com.hatsnake.spring02.domain.BoardDTO;
import com.hatsnake.spring02.domain.CategoryDTO;

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

	public Map<String, Object> likeCheck(Map<String, Object> commandMap);

	public void insertLikeBtn(Map<String, Object> commandMap);

	public void updateLikeCntPlus(Map<String, Object> commandMap);

	public void updateLikeCntMinus(Map<String, Object> commandMap);

	public void updateLikeBtn(Map<String, Object> commandMap);

	public int getLikeCnt(Map<String, Object> commandMap);

	public int getLikeCntByBno(int bno);

	public Map<String, Object> likeCheckByMap(Map<String, Object> map);

	public List<CategoryDTO> getCategoryList();

}
