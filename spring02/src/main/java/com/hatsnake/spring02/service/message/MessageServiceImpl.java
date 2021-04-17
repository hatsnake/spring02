package com.hatsnake.spring02.service.message;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hatsnake.spring02.dao.MessageDAO;
import com.hatsnake.spring02.dao.PointDAO;
import com.hatsnake.spring02.domain.MessageVO;

@Service
public class MessageServiceImpl implements MessageService {

	@Inject
	MessageDAO messageDao;
	
	@Inject
	PointDAO pointDao;
	
	//메시지 작성(DB저장, 포인트 적립)
	@Transactional
	@Override
	public void addMessage(MessageVO vo) {
		//공통업무 - 로그 확인
		
		//핵심업무 - 메시지 저장, 회원 포인트 적립
		//메시지를 테이블에 저장
		messageDao.create(vo);
		//메시지를 발송한 사용자에게 10포인트 적립
		pointDao.updatePoint(vo.getSender(), 10);
	}

	//메시지 열람
	@Override
	public MessageVO readMessage(String userid, int mid) {
		return null;
	}

}
