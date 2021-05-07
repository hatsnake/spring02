package com.hatsnake.spring02.dao;

import java.util.Map;

public interface UserDAO {
	//회원가입 처리
	public int insertUser(Map<String, String> map);
	//로그인 처리 (회원 상세 정보)
	public Map<String, Object> selectUser(String userid);
}
