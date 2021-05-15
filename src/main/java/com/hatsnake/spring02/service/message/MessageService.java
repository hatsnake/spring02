package com.hatsnake.spring02.service.message;

import org.springframework.transaction.annotation.Transactional;

import com.hatsnake.spring02.domain.MessageVO;

public interface MessageService {

	//메시지 작성(DB저장, 포인트 적립)
	public void addMessage(MessageVO vo);
	//메시지 열람
	public MessageVO readMessage(String userid, int mid);
	
}
