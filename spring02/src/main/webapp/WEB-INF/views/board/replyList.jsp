<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- 태그 라이브러리 선언 -->
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 
uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<!-- 컨텍스트 패스 설정 -->
<c:set var="path" value="${pageContext.request.contextPath}"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"></script>  

<table style="width:700px">
	<c:forEach var="row" items="${list}">
		<tr>
			<td>
				${row.replyer}(<fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/>)
				<br>
				${row.replytext}
				<br>
				
				<c:if test="${username == row.replyer}">
					<input type="button" id="btnModify" value="수정" onclick="showReplyModify('${row.rno}')">
				</c:if>
				<hr>
			</td>
		</tr>
	</c:forEach>
	
	<!-- 페이징 처리 -->
	<tr>
		<td>
			<!-- 현재 페이지 블록이 1보다 크면 처음으로 이동 -->
			<c:if test="${replyPager.curBlock > 1}">
				<a href="javascript:listReply('1')">[처음]</a>
			</c:if>
			<!-- 현재 페이지 블록이 1보다 크면 이전 페이지 블록으로 이동 -->
			<c:if test="${replyPager.curPage > 1}">
				<a href="javascript:listReply('${replyPager.prevPage}')">[이전]</a>
			</c:if>
			<!-- 페이지 블록 처음부터 마지막 블록까지 1씩 증가하는 페이지 출력 -->
			<c:forEach var="num" begin="${replyPager.blockBegin}" end="${replyPager.blockEnd}">
				<c:choose>
					<c:when test="${num == replyPager.curPage}">
						${num}&nbsp;
					</c:when>
					<c:otherwise>
						<a href="javascript:listReply('${num}')">${num}</a>&nbsp;
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<!-- 현재 페이지 블록이 전체 페이지 블록보다 작거나 같으면 다음 페이지로 이동 -->
			<c:if test="${replyPager.curPage <= replyPager.totalPage}">
				<a href="javascript:listReply('${replyPager.nextPage}')">[다음]</a>
			</c:if>
			<!-- 현재 페이지 블록이 전체 페이지 블록보다 작거나 같으면 끝으로 이동 -->
			<c:if test="${replyPager.curPage <= replyPager.totalPage}">
				<a href="javascript:listReply('${replyPager.totalPage}')">[다음]</a>
			</c:if>
		</td>
	</tr>
</table>

<!-- 댓글 수정 영역 -->
<div id="modifyReply"></div>