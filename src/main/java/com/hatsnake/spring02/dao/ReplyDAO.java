package com.hatsnake.spring02.dao;

import java.util.List;

import com.hatsnake.spring02.domain.ReplyDTO;

public interface ReplyDAO {
	//댓글 목록
	public List<ReplyDTO> list(Integer bno, int start, int end);
	//댓글 입력
	public void create(ReplyDTO dto);
	//댓글 상세보기
	public ReplyDTO detail(Integer rno);
	//댓글 수정
	public void update(ReplyDTO dto);
	//댓글 삭제
	public void delete(Integer rno);
	//댓글 갯수
	public int count(int bno);
}
