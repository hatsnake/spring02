package com.hatsnake.spring02.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.hatsnake.spring02.domain.BoardDTO;
import com.hatsnake.spring02.service.BoardService;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	private BoardService boardService;
	
	//시작 페이지 이동
	@RequestMapping(value="/")
	public ModelAndView home() throws Exception {
		
		List<BoardDTO> list = boardService.listLimit();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("user/home");
		mav.addObject("list", list);
		
		return mav;
	}	
	
}
