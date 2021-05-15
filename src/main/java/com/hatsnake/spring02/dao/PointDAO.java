package com.hatsnake.spring02.dao;

public interface PointDAO {
	//회원 포인트 갱신(메시지 발신)
	public void updatePoint(String userid, int upoint);
}
