package com.hatsnake.spring02.service;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.hatsnake.spring02.dao.BoardDAO;
import com.hatsnake.spring02.domain.BoardDTO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO boardDao;

	//게시글 전체 조회
	@Override
	public List<BoardDTO> listAll() throws Exception {
		return boardDao.listAll();
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
		if(current_time - update_time > 5*1000) {
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
	}

	//게시글 수정
	@Override
	public void update(BoardDTO dto) throws Exception {
		boardDao.update(dto);
	}

	//게시글 삭제
	@Override
	public void delete(int bno) throws Exception {
		boardDao.delete(bno);
	}

}