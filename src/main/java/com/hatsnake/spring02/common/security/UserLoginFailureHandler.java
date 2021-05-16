package com.hatsnake.spring02.common.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Service;

@Service
public class UserLoginFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		String errMsg = "";
		String userid = request.getParameter("userid");
		String passwd = request.getParameter("passwd");
		
		if(exception instanceof UsernameNotFoundException) {
			errMsg = "존재하지 않는 아이디입니다.";
		} else if(exception instanceof BadCredentialsException) {
			errMsg = "아이디 또는 비밀번호가 잘못 입력되었습니다.";
		}
		
		request.setAttribute("errMsg", errMsg);
		request.setAttribute("userid", userid);
		request.setAttribute("passwd", passwd);
	
		//request.getRequestDispatcher("/user/login").forward(request, response);
		response.sendRedirect("/user/login?error=true");
		
	}

}
