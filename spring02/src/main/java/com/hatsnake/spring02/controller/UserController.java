package com.hatsnake.spring02.controller;

import java.security.Principal;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hatsnake.spring02.common.security.ShaEncoder;
import com.hatsnake.spring02.dao.UserDAO;
import com.hatsnake.spring02.domain.UserDTO;

@Controller
public class UserController {
	@Inject
	private ShaEncoder shaEncoder;

	@Inject
	private UserDAO userDao;
	
	//로그인 페이지 이동
	@RequestMapping(value="/user/login")
	public String login(HttpServletRequest request) {
		String referrer = request.getHeader("Referer");
		request.getSession().setAttribute("prevPage", referrer);

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
							 @RequestParam String name, @RequestParam String email, Model model) {
		
			boolean useridCheck = userid.equals("");
			boolean passwdCheck = passwd.equals("");
			boolean nameCheck = name.equals("");
			boolean emailCheck = email.equals("");
			
			if(useridCheck || passwdCheck || nameCheck || emailCheck) {
				model.addAttribute("userid", userid);
				model.addAttribute("passwd", passwd);
				model.addAttribute("name", name);
				model.addAttribute("email", email);
				
				return "user/join";
			} else {
				//비밀번호 암호화
				String dbpw = shaEncoder.saltEncoding(passwd, userid);
				Map<String, String> map = new HashMap<>();
				map.put("userid", userid);
				map.put("passwd", dbpw);
				map.put("name", name);
				map.put("email", email);
				
				int result = userDao.insertUser(map);
				
				return "user/login";
			}
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
			UserDTO userDto = (UserDTO) user;
			String username = user.getUsername();
			String password = user.getPassword();
			String name = userDto.getName();
			String email = userDto.getEmail();
			Date regDate = userDto.getRegDate();
			Date updateDate = userDto.getUpdateDate();
			
			Collection<GrantedAuthority> auth = user.getAuthorities();
			
			model.addAttribute("username", username);
			model.addAttribute("auth", auth);
			model.addAttribute("name", name);
			model.addAttribute("email", email);
			model.addAttribute("regDate", regDate);
			model.addAttribute("updateDate", updateDate);
		}
		
		return "user/profile";
	}
	
	//사용자 아이디 체크
	@RequestMapping(value="/user/useridCheck", method=RequestMethod.POST)
	@ResponseBody
	public String useridCheck(String userid) throws Exception {
			int result = userDao.idCheck(userid);
			
			if(result != 0) {
				return "fail";
			} else {
				return "success";
			}
			
	}
	
}
