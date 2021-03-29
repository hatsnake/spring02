package com.hatsnake.spring02.controller;

import java.security.Principal;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hatsnake.spring02.dao.UserDAO;
import com.hatsnake.spring02.service.ShaEncoder;

@Controller
public class UserController {
	@Inject
	private ShaEncoder shaEncoder;

	@Inject
	private UserDAO userDao;
	
	//시작 페이지 이동
	@RequestMapping(value="/")
	public String home(Model model) {
		return "user/home";
	}
	
	//로그인 페이지 이동
	@RequestMapping(value="/user/login")
	public String login() {
		return "user/login";
	}
	
	//회원가입 페이지 이동
	@RequestMapping(value="/user/join")
	public String join() {
		return "user/join";
	}
	
	//회원가입 처리
	@RequestMapping(value="/user/insertUser")
	public String insertUser(@RequestParam String userid, @RequestParam String passwd, 
							 @RequestParam String name) {
		//비밀번호 암호화
		String dbpw = shaEncoder.saltEncoding(passwd, userid);
		Map<String, String> map = new HashMap<>();
		map.put("userid", userid);
		map.put("passwd", dbpw);
		map.put("name", name);
		
		int result = userDao.insertUser(map);
		
		return "user/login";
	}
	
	//관리자 영역 페이지
	@RequestMapping(value="/admin/")
	public String admin() {
		return "admin/main";
	}
	
	//사용자 정보 페이지
	@RequestMapping(value="/user/profile")
	public String profile(Model model, Principal principal) {
		
		if(principal != null) {
			User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String username = user.getUsername();
			String password = user.getPassword();
			Collection<GrantedAuthority> auth = user.getAuthorities();
			String name = principal.getName();
			
			model.addAttribute("username", username);
			model.addAttribute("name", name);
			model.addAttribute("auth", auth);
		}
		
		return "user/profile";
	}
	
}
