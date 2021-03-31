package com.hatsnake.spring02.service;

import java.security.Principal;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;

import com.hatsnake.spring02.dao.ReplyDAO;
import com.hatsnake.spring02.domain.ReplyDTO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO replyDao;
	
	//댓글 목록
	@Override
	public List<ReplyDTO> list(Integer bno, int start, int end, String username) {
		List<ReplyDTO> items = replyDao.list(bno, start, end);
		
		for(ReplyDTO dto : items) {
			if(dto.getSecretReply().equals("y")) {
				if(username == null) {
					dto.setReplytext("비밀 댓글입니다.");
				} else {
					String writer = dto.getWriter();
					String replyer = dto.getReplytext();
					//로그인한 사용자가 게시물의 작성자x 댓글 작성자x 비밀댓글로 처리
					if(!username.equals(writer) && !username.equals(replyer)) {
						dto.setReplytext("비밀 댓글입니다.");
					}
				}
			}
			
		}

		return items;
	}

	//댓글 작성
	@Override
	public void create(ReplyDTO dto) {
		replyDao.create(dto);
	}
	
	//댓글 상세보기
	@Override
	public ReplyDTO detail(Integer rno) {
		return replyDao.detail(rno);
	}

	//댓글 수정
	@Override
	public void update(ReplyDTO dto) {
		replyDao.update(dto);
	}

	//댓글 삭제
	@Override
	public void delete(Integer rno) {
		replyDao.delete(rno);
	}

	@Override
	public int count(Integer bno) {
		// TODO Auto-generated method stub
		return replyDao.count(bno);
	}

}
