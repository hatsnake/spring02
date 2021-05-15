package com.hatsnake.spring02.common.security;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.hatsnake.spring02.domain.UserDTO;

@Service
public class UserAuthenticationService implements UserDetailsService {
	private SqlSessionTemplate sqlSession;

	public UserAuthenticationService() {
		
	}
	
	public UserAuthenticationService(SqlSessionTemplate sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//비밀번호 체크는 코드로 보이지 않아도 메소드 실행시 알아서 처리
	@Override
	public UserDetails loadUserByUsername(String userid) throws UsernameNotFoundException {
		//사용자 아이디 확인
		Map<String, Object> user = sqlSession.selectOne("user.selectUser", userid);
		
		//아이디가 없으면 예외 발생시킴 (throw)
		if(user == null)
			throw new UsernameNotFoundException(userid);
		
		//사용권한 목록
		List<GrantedAuthority> authority = new ArrayList<>();
		
		//오라클은 테이블 자바코드에서 테이블 필드명 대문자로 해야됨
		authority.add(new SimpleGrantedAuthority(user.get("AUTHORITY").toString()));
		
		return new UserDTO(user.get("USERNAME").toString(),
                user.get("PASSWORD").toString(),
                (Integer)Integer.valueOf(user.get("ENABLED").toString())==1,
                true,true,true,authority, user.get("NAME").toString(), user.get("EMAIL").toString(), (Date)user.get("REGDATE"), (Date)user.get("UPDATEDATE"));
	}
	

	
	
}
