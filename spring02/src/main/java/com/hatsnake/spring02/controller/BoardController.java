package com.hatsnake.spring02.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hatsnake.spring02.domain.BoardDTO;
import com.hatsnake.spring02.domain.BoardPager;
import com.hatsnake.spring02.domain.CategoryDTO;
import com.hatsnake.spring02.service.BoardService;
import com.hatsnake.spring02.service.ReplyService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
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
		
		User user = null;
		String username = null;
		
		if(principal != null) {
			user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			username = user.getUsername();	
		}
		
		List<CategoryDTO> categoryList = boardService.getCategoryList();

		model.addAttribute("categoryList", categoryList);
		model.addAttribute("username", username);
		
		return "board/write";
	}
	
	//게시글 작성처리
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public String insert(@ModelAttribute BoardDTO dto) throws Exception {
		boardService.create(dto);
		
		return "redirect:/board/list";
	}

	//게시글 첨부파일 목록
	@ResponseBody
	@RequestMapping("/getAttach/{bno}")
	public List<String> getAttach(@PathVariable("bno") int bno) {
		return boardService.getAttach(bno);
	}
	
	//게시글 상세조회, 조회수 증가 처리
	@RequestMapping(value="/view", method=RequestMethod.GET)
	public ModelAndView view(ModelAndView mav, Principal principal, @RequestParam int bno, 
					   @RequestParam(defaultValue="1") int curPage, @RequestParam(defaultValue="all") String searchOption,
					   @RequestParam(defaultValue="") String keyword, HttpSession session) throws Exception {
		
		String username = null;
		
		if(principal != null) {
			User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			username = user.getUsername();
		}
		
		try {
			//조회수 증가 처리
			boardService.increaseViewcnt(bno, session);
		
			mav.setViewName("board/view");
			mav.addObject("count", replyService.count(bno));
			mav.addObject("dto", boardService.read(bno));
			mav.addObject("bno", bno);
			mav.addObject("curPage", curPage);
			mav.addObject("searchOption", searchOption);
			mav.addObject("keyword", keyword);
			
			String userid = username;
			Map<String, Object> map = new HashMap<>();
			map.put("userid", userid);
			map.put("bno", bno);
			
			int likeCnt = boardService.getLikeCntByBno(bno); //게시글에 좋아요 갯수
			
			if(userid != null) {
				Map<String, Object> likeCheckMap = boardService.likeCheckByMap(map); //사용자의 좋아요 여부
				System.out.println("likeCheckMap 넘어감");
				
				
				if(likeCheckMap == null) {
					mav.addObject("likeCheck", 0);
				} else {
					mav.addObject("likeCheck", Integer.parseInt(likeCheckMap.get("LIKE_CHECK").toString()));
				}
			}
			
			mav.addObject("likeCnt", likeCnt);
			
			mav.addObject("username", username);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	/*
	//메인에서 상세보기로 이동
	@RequestMapping(value="/viewLimit", method=RequestMethod.GET)
	public ModelAndView viewLimit(ModelAndView mav, Principal principal, @RequestParam int bno, HttpSession session) throws Exception {
		
		User user = null;
		String username = null;
		
		
		try {
			//조회수 증가 처리
			boardService.increaseViewcnt(bno, session);
		
			mav.setViewName("board/view");
			mav.addObject("count", replyService.count(bno));
			mav.addObject("dto", boardService.read(bno));
			mav.addObject("bno", bno);
			//mav.addObject("curPage", curPage);
			//mav.addObject("searchOption", searchOption);
			//mav.addObject("keyword", keyword);
			
			if(principal != null) {
				user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				username = user.getUsername();
			}
			
			String userid = username;
			Map<String, Object> map = new HashMap<>();
			map.put("userid", userid);
			map.put("bno", bno);
			
			Map<String, Object> likeCheckMap = boardService.likeCheckByMap(map); //사용자의 좋아요 여부
			int likeCnt = boardService.getLikeCntByBno(bno); //게시글에 좋아요 갯수
			if(likeCheckMap == null) {
				mav.addObject("likeCheck", 0);
			} else {
				mav.addObject("likeCheck", likeCheckMap.get("LIKE_CHECK"));
			}
			
			mav.addObject("likeCnt", likeCnt);
			
			mav.addObject("username", username);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}	
	*/
	
	//게시글 수정화면
	@RequestMapping(value="/update", method=RequestMethod.GET)
	public String update(Model model, @RequestParam int bno) throws Exception {
		model.addAttribute("getCategoryList", boardService.getCategoryList());
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
	
	//좋아요 기능
	@RequestMapping("/clickLike")
	@ResponseBody
	public Map<String, Object> clickLike(@RequestParam Map<String, Object> commandMap){
		int resultCode = 1;
		int likeCheck = 1;
		
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			//좋아요 컬럼이 있는지 체크
			map = boardService.likeCheck(commandMap);
			
			if(map == null) {
				boardService.insertLikeBtn(commandMap);
				boardService.updateLikeCntPlus(commandMap);
				resultCode = 1;
			} else if(Integer.parseInt(map.get("LIKE_CHECK").toString()) == 0) {
				commandMap.put("likeCheck", likeCheck);
				boardService.updateLikeBtn(commandMap); //좋아요 테이블 업데이트
				boardService.updateLikeCntPlus(commandMap); // 좋아요 갯수 +1
				resultCode = 1;
			} else {
				likeCheck = 0;
				commandMap.put("likeCheck", likeCheck);
				boardService.updateLikeBtn(commandMap);			
				boardService.updateLikeCntMinus(commandMap);		
				resultCode = 0;
			}
			resultMap.put("likeCnt", boardService.getLikeCnt(commandMap));
			resultMap.put("likeCheck", likeCheck);
		} catch(Exception e) {
			e.printStackTrace();
			resultCode = -1;
		}
		
		logger.info("2차 cnt - "+boardService.getLikeCnt(commandMap));
		resultMap.put("resultCode", resultCode);
		return resultMap;
	}
	
}
