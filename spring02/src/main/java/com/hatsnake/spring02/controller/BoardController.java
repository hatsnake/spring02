package com.hatsnake.spring02.controller;

import java.security.Principal;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hatsnake.spring02.domain.BoardDTO;
import com.hatsnake.spring02.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Inject
	private BoardService boardService;
	
	//게시글 목록화면
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String list(Model model) throws Exception {
		List<BoardDTO> list = boardService.listAll();
		model.addAttribute("list", list);
		
		return "board/list";
	}
	
	//게시글 작성화면
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public String write(Model model, Principal principal) {
		
		if(principal != null) {
			User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String username = user.getUsername();
			
			model.addAttribute("username", username);
		}
		
		return "board/write";
	}
	
	//게시글 작성처리
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insert(@ModelAttribute BoardDTO dto) throws Exception {
		boardService.create(dto);
		
		return "redirect:/board/list";
	}
	
	//게시글 상세조회, 조회수 증가 처리
	@RequestMapping(value="/view", method=RequestMethod.GET)
	public String view(Model model, Principal principal, @RequestParam int bno, HttpSession session) throws Exception {
		//조회수 증가 처리
		boardService.increaseViewcnt(bno, session);
		model.addAttribute("dto", boardService.read(bno));
		
		if(principal != null) {
			User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String username = user.getUsername();
			
			model.addAttribute("username", username);
		}
		
		return "board/view";
	}
	
	//게시글 수정화면
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public String update(Model model, @RequestParam int bno) throws Exception {
		model.addAttribute("dto", boardService.read(bno));
		
		return "board/update";
	}
	
	//게시글 수정 처리
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public String update(@ModelAttribute BoardDTO dto) throws Exception {
		boardService.update(dto);
		
		return "redirect:/board/list";
	}	
	
	//게시글 삭제
	@RequestMapping(value="/delete")
	public String delete(@RequestParam int bno) throws Exception {
		boardService.delete(bno);
		
		return "redirect:/board/list";
	}
}
