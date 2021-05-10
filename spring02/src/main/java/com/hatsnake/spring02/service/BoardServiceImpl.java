package com.hatsnake.spring02.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hatsnake.spring02.dao.BoardDAO;
import com.hatsnake.spring02.domain.BoardDTO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Inject
	private BoardDAO boardDao;

	/*
	//게시글 전체 조회
	@Override
	public List<BoardDTO> listAll() throws Exception {
		return boardDao.listAll();
	}
	*/

	@Override
	public List<BoardDTO> listLimit() throws Exception {
		return boardDao.listLimit();
	}
	
	//게시글 전체 조회 (검색)
	@Override
	public List<BoardDTO> listAll(int start, int end, String searchOption, String keyword) throws Exception {
		return boardDao.listAll(start, end, searchOption, keyword);
	}

	//게시글 레코드 갯수
	@Override
	public int countArticle(String searchOption, String keyword) throws Exception {
		return boardDao.countArticle(searchOption, keyword);
	}	
	
	//게시글 상세 보기
	@Override
	public BoardDTO read(int bno) throws Exception {
		return boardDao.read(bno);
	}

	//조회수 증가
	@Override
	public void increaseViewcnt(int bno, HttpSession session) throws Exception {
		long update_time = 0;
		//세션에 저장된 조회시간 검색
		//최초로 조회할 경우 세션에 저장된 값이 없기 때문에 if문은 실행x
		if(session.getAttribute("update_time_"+bno) != null) {
			//세션에서 읽어오기
			update_time = (long)session.getAttribute("update_time_"+bno);
		}
		//시스템의 현재시간을 current_time에 저장
		long current_time = System.currentTimeMillis();
		//일정시간이 경과 후 조회수 증가 처리 (24*60*60*1000 - 24시간)
		//열람시간 > 일정시간 = 조회수 증가
		if(current_time - update_time > 1000*60*60*24) {
			boardDao.increaseViewctn(bno);
			//세션에 시간을 저장 : "update_time_"+bno는 다른변수와 중복되지 않게 명명
			session.setAttribute("update_time_"+bno, current_time);
		}
	}

	//게시글 작성
	@Override
	public void create(BoardDTO dto) throws Exception {
		String title = dto.getTitle();
		String content = dto.getContent();
		String writer = dto.getWriter();
		
		//태그 문자 처리 - replace(A, B) : A를 B로 변경
		title = title.replace("<", "&lt;");
		title = title.replace(">", "&gt;");
		writer = writer.replace("<", "&lt;");
		writer = writer.replace(">", "&gt;");
		//공백문자 처리
		title = title.replace(" ", "&nbsp;&nbsp;");
		writer = writer.replace(" ", "&nbsp;&nbsp;");
		//줄바꿈문자 처리
		content = content.replace("\n", "<br>");
		dto.setTitle(title);
		dto.setContent(content);
		dto.setWriter(writer);
		boardDao.create(dto);
		
		//게시물의 첨부파일 정보 등록
		String[] files = dto.getFiles(); //첨부파일 배열
		if(files == null) return; //첨부파일이 없으면 메소드 종료
		//첨부파일들의 정보를 attach_board테이블에 insert
		for(String name : files) {
			boardDao.addAttach(name);
		}
	}

	//게시글 수정
	@Transactional
	@Override
	public void update(BoardDTO dto) throws Exception {
		boardDao.update(dto);
		//첨부파일 정보 등록
		String[] files = dto.getFiles(); //첨부파일 배열
		//첨부파일이 없으면 종료
		if(files == null) return;
		//첨부파일들의 정보를 attach_board 테이블에 insert
		for(String name : files) {
			boardDao.updateAttach(name, dto.getBno());
		}
	}

	//게시글 삭제
	@Override
	public void delete(int bno) throws Exception {
		boardDao.delete(bno);
	}

	@Override
	public List<String> getAttach(int bno) {
		return boardDao.getAttach(bno);
	}

	@Override
	public void deleteFile(String fullname) {
		boardDao.deleteFile(fullname);
	}

	//좋아요 있는지 체크
	@Override
	public Map<String, Object> likeCheck(Map<String, Object> commandMap) {
		return boardDao.likeCheck(commandMap);
	}

	//좋아요 추가
	@Override
	public void insertLikeBtn(Map<String, Object> commandMap) {
		boardDao.insertLikeBtn(commandMap);
	}

	//좋아요 갯수 증가
	@Override
	public void updateLikeCntPlus(Map<String, Object> commandMap) {
		boardDao.updateLikeCntPlus(commandMap);
	}

	//좋아요 갯수 감소
	@Override
	public void updateLikeCntMinus(Map<String, Object> commandMap) {
		boardDao.updateLikeCntMinus(commandMap);
	}

	//좋아요 1로 바꾸기
	@Override
	public void updateLikeBtn(Map<String, Object> commandMap) {
		boardDao.updateLikeBtn(commandMap);
	}

	//좋아요 갯수 가져오기
	@Override
	public int getLikeCnt(Map<String, Object> commandMap) {
		return boardDao.getLikeCnt(commandMap);
	}

	//게시글 좋아요 갯수
	@Override
	public int getLikeCntByBno(int bno) {
		return boardDao.getLikeCntByBno(bno);
	}

	//게시글 사용자 좋아요 여부
	@Override
	public Map<String, Object> likeCheckByMap(Map<String, Object> map) {
		return boardDao.likeCheckByMap(map);
	}

}
