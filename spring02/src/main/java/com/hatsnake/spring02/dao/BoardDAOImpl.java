package com.hatsnake.spring02.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.hatsnake.spring02.domain.BoardDTO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession sqlSession;
	
	//게시글 목록 조회
	@Override
	public List<BoardDTO> listAll() {
		return sqlSession.selectList("board.listAll");
	}

	//게시글 상세 보기
	@Override
	public BoardDTO read(int bno) {
		return sqlSession.selectOne("board.view", bno);
	}

	//게시글 조회수 처리
	@Override
	public void increaseViewctn(int bno) {
		sqlSession.update("board.increaseViewcnt", bno);
	}

	//게시글 작성 처리
	@Override
	public void create(BoardDTO dto) {
		sqlSession.insert("board.insert", dto);
	}

	//게시글 삭제 처리
	@Override
	public void delete(int bno) {
		sqlSession.delete("board.deleteArticle", bno);
	}

	//게시글 수정 처리
	@Override
	public void update(BoardDTO dto) {
		sqlSession.update("board.updateArticle", dto);
	}

}
