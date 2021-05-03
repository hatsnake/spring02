package com.hatsnake.spring02.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.hatsnake.spring02.domain.BoardDTO;
import com.hatsnake.spring02.domain.ReplyDTO;
import com.hatsnake.spring02.domain.ReplyPager;
import com.hatsnake.spring02.service.BoardService;
import com.hatsnake.spring02.service.ReplyService;

@RestController
@RequestMapping("/reply")
public class ReplyController {
	
	@Inject
	private ReplyService replyService;
	
	@Inject
	private BoardService boardService;
	
	//댓글 입력
	@RequestMapping("/insert")
	public void insert(Principal principal, @ModelAttribute ReplyDTO dto) {
		
		if(principal != null) {
			User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String username = user.getUsername();
			
			dto.setReplyer(username);
		}
				
		replyService.create(dto);
	}
	
	@RequestMapping(value="insertRest", method=RequestMethod.POST)
	public ResponseEntity<String> insertRest(Principal principal, @RequestBody ReplyDTO dto) {
		ResponseEntity<String> entity = null;
		try {
			User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String username = user.getUsername();
			dto.setReplyer(username);
			replyService.create(dto);
			// 댓글 입력이 성공하면 성공메시지 저장
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			//댓글입력이 실패하면 실패메시지 저장
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		//입력처리 HTTP 상태 메시지 리턴
		return entity;
	}
	
	//댓글 목록(@Controller방식 : view를 리턴)
	@RequestMapping("/list")
	public ModelAndView list(@RequestParam int bno, @RequestParam(defaultValue="1") int curPage,
					   ModelAndView mav, Principal principal) {
		
		String username = null;
		
		if(principal != null) {
		// 스프링 시큐리티 세션 아이디
			User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			username = user.getUsername();
		}
		
		// 페이징 처리
		int count = replyService.count(bno);
		ReplyPager replyPager = new ReplyPager(count, curPage);
		int start = replyPager.getPageBegin();
		int end = replyPager.getPageEnd();
		List<ReplyDTO> list = replyService.list(bno, start, end, username);
		
		mav.setViewName("board/replyList");
		mav.addObject("list", list);
		mav.addObject("replyPager", replyPager);
		
		return mav;
	}
	
	/*
	//댓글 목록(@RestController Json방식으로 처리 : 데이터를 리턴)
	@RequestMapping("/listJson")
	@ResponseBody //리턴데이터를 json으로 변환
	public List<ReplyDTO> listJson(@RequestParam int bno) {
		List<ReplyDTO> list = replyService.list(bno);
		
		return list;
	}
	*/
	
	/*---------------------------------*/
	/* Rest방식으로 댓글 목록, 수정, 삭제 처리 */
	
	//댓글 목록 (Rest방식)
	@RequestMapping(value="/list/{bno}/{curPage}", method=RequestMethod.GET)
	public ModelAndView replyList(@PathVariable("bno") int bno, @PathVariable int curPage,
					   ModelAndView mav, Principal principal) throws Exception {
		
		String username = null;
		
		if(principal != null) {
			// 스프링 시큐리티 세션 아이디
			User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			username = user.getUsername();
			mav.addObject("username", username);
		}
		
		// 페이징 처리
		int count = replyService.count(bno);
		ReplyPager replyPager = new ReplyPager(count, curPage);
		int start = replyPager.getPageBegin();
		int end = replyPager.getPageEnd();
		List<ReplyDTO> list = replyService.list(bno, start, end, username);
		BoardDTO board = boardService.read(bno);
		
		mav.setViewName("board/replyList");
		mav.addObject("list", list);
		mav.addObject("replyCount", count);
		mav.addObject("replyPager", replyPager);
		mav.addObject("username", username);
		mav.addObject("bno", bno);
		mav.addObject("writer", board.getWriter());
		
		return mav;
	}
	
	//댓글 상세 보기 (페이지방식, Rest방식)
	/*
	@RequestMapping(value="/detail/{rno}", method=RequestMethod.GET)
	public ModelAndView replyDetail(@PathVariable("rno") Integer rno, ModelAndView  mav) {
		ReplyDTO dto = replyService.detail(rno);
		mav.setViewName("board/replyDetail");
		mav.addObject("dto", dto);
		
		return mav;
	}
	*/
	
	//댓글 상세보기 (모달방식)
	@RequestMapping(value="/detail/{rno}", method=RequestMethod.GET)
	public Map<String, Object> replyDetail(@PathVariable("rno") Integer rno) {
		Map<String, Object> replyData = new HashMap<String, Object>();
		ReplyDTO dto = replyService.detail(rno);
		
		replyData.put("rno", dto.getRno());
		replyData.put("replytext", dto.getReplytext());
		
		return replyData;
	}
	
	//댓글 수정 처리 - PUT:전체 수정, PATCH:일부수정
	@RequestMapping(value="/update/{rno}", method={RequestMethod.PUT, RequestMethod.PATCH})
	public ResponseEntity<String> replyUpdate(@PathVariable("rno") Integer rno, @RequestBody ReplyDTO dto) {
		ResponseEntity<String> entity = null;
		try {
			dto.setRno(rno);
			replyService.update(dto);
			//댓글 수정 성공시 성공 상태 메시지 저장
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			//댓글 수정 실패시 실패 상태 메시지 저장
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		//수정 처리 HTTP 상태 메시지 리턴
		return entity;
	}
	
	//댓글 삭제 처리
	@RequestMapping(value="/delete/{rno}")
	public ResponseEntity<String> replyDelete(@PathVariable("rno") Integer rno) {
		ResponseEntity<String> entity = null;
		try {
			replyService.delete(rno);
			entity = new ResponseEntity<String>("success", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}
