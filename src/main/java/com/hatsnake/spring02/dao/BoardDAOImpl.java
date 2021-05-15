package com.hatsnake.spring02.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.hatsnake.spring02.domain.BoardDTO;
import com.hatsnake.spring02.domain.CategoryDTO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession sqlSession;
	
	/*
	//게시글 목록 조회
	@Override
	public List<BoardDTO> listAll() {
		return sqlSession.selectList("board.listAll");
	}
	*/
	
	//게시글 목록 조회 (검색)
	@Override
	public List<BoardDTO> listAll(int start, int end, String searchOption, String keyword) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("start", start);
		map.put("end", end);
		
		return sqlSession.selectList("board.listAll", map);
	}
	

	@Override
	public List<BoardDTO> listLimit() throws Exception {
		return sqlSession.selectList("board.listLimit");
	}
	
	//게시글 레코드 갯수
	@Override
	public int countArticle(String searchOption, String keyword) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		
		return sqlSession.selectOne("board.countArticle", map);
	}

	//게시글 상세 보기
	@Override
	public BoardDTO read(int bno) throws Exception {
		return sqlSession.selectOne("board.view", bno);
	}

	//게시글 조회수 처리
	@Override
	public void increaseViewctn(int bno) throws Exception {
		sqlSession.update("board.increaseViewcnt", bno);
	}

	//게시글 작성 처리
	@Override
	public void create(BoardDTO dto) throws Exception {
		sqlSession.insert("board.insert", dto);
	}

	//게시글 삭제 처리
	@Override
	public void delete(int bno) throws Exception {
		sqlSession.update("board.deleteArticle", bno);
	}

	//게시글 수정 처리
	@Override
	public void update(BoardDTO dto) throws Exception {
		sqlSession.update("board.updateArticle", dto);
	}

	//게시글 첨부파일 추가
	@Override
	public void addAttach(String fullname) {
		sqlSession.insert("board.addAttach", fullname);
	}

	//게시글 첨부파일 목록
	@Override
	public List<String> getAttach(int bno) {
		return sqlSession.selectList("board.getAttach", bno);
	}

	//게시글 첨부파일 수정
	@Override
	public void updateAttach(String fullname, int bno) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("fullname", fullname);
		map.put("bno", bno);
		sqlSession.insert("board.updateAttach", map);
	}

	//게시글 첨부파일 삭제
	@Override
	public void deleteFile(String fullname) {
		sqlSession.delete("board.deleteAttach", fullname);
	}

	//좋아요 있는지 체크
	@Override
	public Map<String, Object> likeCheck(Map<String, Object> commandMap) {
		return sqlSession.selectOne("board.likeCheck", commandMap);
	}

	//좋아요 추가
	@Override
	public void insertLikeBtn(Map<String, Object> commandMap) {
		sqlSession.selectOne("board.insertLikeBtn", commandMap);
	}

	//좋아요 갯수 증가
	@Override
	public void updateLikeCntPlus(Map<String, Object> commandMap) {
		sqlSession.update("board.updateLikeCntPlus", commandMap);
	}

	//좋아요 갯수 감소
	@Override
	public void updateLikeCntMinus(Map<String, Object> commandMap) {
		sqlSession.update("board.updateLikeCntMinus", commandMap);
	}

	//좋아요 1로 바꾸기
	@Override
	public void updateLikeBtn(Map<String, Object> commandMap) {
		sqlSession.update("board.updateLikeBtn", commandMap);
	}

	//좋아요 갯수 가져오기
	@Override
	public int getLikeCnt(Map<String, Object> commandMap) {
		return sqlSession.selectOne("board.getLikeCnt", commandMap);
	}

	//게시글 좋아요 갯수
	@Override
	public int getLikeCntByBno(int bno) {
		return sqlSession.selectOne("board.getLikeCntByBno", bno);
	}

	//게시글 사용자 좋아요 여부
	@Override
	public Map<String, Object> likeCheckByMap(Map<String, Object> map) {
		return sqlSession.selectOne("board.likeCheckByMap", map);
	}


	@Override
	public List<CategoryDTO> getCategoryList() {
		return sqlSession.selectList("board.getCategoryList");
	}

}
