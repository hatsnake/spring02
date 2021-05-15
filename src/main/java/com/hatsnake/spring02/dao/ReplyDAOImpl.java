package com.hatsnake.spring02.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.hatsnake.spring02.domain.ReplyDTO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Inject
	private SqlSession sqlSession;
	
	//댓글 목록
	@Override
	public List<ReplyDTO> list(Integer bno, int start, int end) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bno", bno);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("reply.listReply", map);
	}

	//댓글 작성
	@Override
	public void create(ReplyDTO dto) {
		sqlSession.insert("reply.insertReply", dto);
	}
	
	//댓글 상세보기
	@Override
	public ReplyDTO detail(Integer rno) {
		return sqlSession.selectOne("reply.detailReply", rno);
	}

	//댓글 수정
	@Override
	public void update(ReplyDTO dto) {
		sqlSession.update("reply.updateReply", dto);
	}

	//댓글 삭제
	@Override
	public void delete(Integer rno) {
		sqlSession.delete("reply.deleteReply", rno);
	}

	//댓글 갯수
	@Override
	public int count(int bno) {
		return sqlSession.selectOne("reply.countReply", bno);
	}

}
