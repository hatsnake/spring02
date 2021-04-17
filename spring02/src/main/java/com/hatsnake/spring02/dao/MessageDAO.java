package com.hatsnake.spring02.dao;

import com.hatsnake.spring02.domain.MessageVO;

public interface MessageDAO {
	//메시지 작성
	public void create(MessageVO vo);
	//메시지 열람
	public MessageVO readMessage(int mid);
	//메시지 열람시간 갱신
	public void updateMessage(int mid);
}
