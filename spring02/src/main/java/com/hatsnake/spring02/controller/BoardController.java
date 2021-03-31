package com.hatsnake.spring02.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;

import com.hatsnake.spring02.domain.BoardDTO;
import com.hatsnake.spring02.domain.BoardPager;
import com.hatsnake.spring02.service.BoardService;
import com.hatsnake.spring02.service.ReplyService;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Inject
	private BoardService boardService;
	
	@Inject
	private ReplyService replyService;
	
	//게시글 목록화면
	@RequestMapping(value="/list")
	public String list(Model model, @RequestParam(defaultValue="all") String searchOption,
					   @RequestParam(defaultValue="") String keyword, 
					   @RequestParam(defaultValue="1") int curPage) throws Exception {
		//레코드 갯수
		int count = boardService.countArticle(searchOption, keyword);
		
		//페이징 처리
		BoardPager boardPager = new BoardPager(count, curPage);
		int start = boardPager.getPageBegin();
		int end = boardPager.getPageEnd();
		
		List<BoardDTO> list = boardService.listAll(start, end, searchOption, keyword);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("count", count);
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("boardPager", boardPager);
	
		model.addAttribute("map", map);
		
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
	public ModelAndView view(Model model, Principal principal, @RequestParam int bno, 
					   @RequestParam int curPage, @RequestParam String searchOption,
					   @RequestParam String keyword, HttpSession session) throws Exception {
		//조회수 증가 처리
		boardService.increaseViewcnt(bno, session);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/view");
		mav.addObject("count", replyService.count(bno));
		mav.addObject("dto", boardService.read(bno));
		mav.addObject("curPage", curPage);
		mav.addObject("searchOption", searchOption);
		mav.addObject("keyword", keyword);
		
		if(principal != null) {
			User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String username = user.getUsername();
			
			mav.addObject("username", username);
		}
		
		return mav;
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
