package com.hatsnake.spring02.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Service;

import com.hatsnake.spring02.domain.UserDTO;

@Service
public class UserLoginSuccessHandler implements AuthenticationSuccessHandler {

	//로그인처리 성공시 코드
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		//인증된 사용자의 정보 리턴
		UserDTO dto = (UserDTO)auth.getPrincipal();
		String msg = auth.getName()+"님 환영합니다.";
		request.setAttribute("msg", msg);
		RequestDispatcher rd = request.getRequestDispatcher("/");
		rd.forward(request, response);
		
	}

}
