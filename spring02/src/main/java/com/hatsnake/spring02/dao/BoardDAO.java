package com.hatsnake.spring02.dao;

import java.util.List;

import com.hatsnake.spring02.domain.BoardDTO;

public interface BoardDAO {

	List<BoardDTO> listAll();

	BoardDTO read(int bno);

	void increaseViewctn(int bno);

	void create(BoardDTO dto);

	void delete(int bno);

	void update(BoardDTO dto);

}
