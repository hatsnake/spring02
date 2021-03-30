<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>메인 화면</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"></script>  

<style type="text/css">

</style>

<script type="text/javascript">
$(document).ready(function() {
	$(".write").on("click", function() {
		location.href="${path}/board/write";
	});
});

//원하는 페이지로 이동시 검색조건, 키워드 값 유지를 위한 함수
function list(page) {
	location.href="${path}/board/list?curPage="+page+"&searchOption=${map.searchOption}"+"&keyword=${map.keyword}";
}
</script>

</head>
<body>

	<%@ include file="../include/header.jsp" %>
	
	<div class="container" style="max-width:960px; margin:20px auto;">
		<form name="form1" method="post" action="${path}/board/list">
			<select name="searchOption">
				<!--  c:out태그에 삼항연산자 사용 -->
				<option value="all" <c:out value="${map.searchOption == 'all'?'selected':''}"/>>제목+이름+제목</option>
				<option value="writer" <c:out value="${map.searchOption == 'writer'?'selected':''}"/>>이름</option>
				<option value="content" <c:out value="${map.searchOption == 'content'?'selected':''}"/>>내용</option>
				<option value="title" <c:out value="${map.searchOption == 'title'?'selected':''}"/>>제목</option>
			</select>
			<input name="keyword" value="${map.keyword}">
			<input type="submit" value="조회">
			
			<!-- 로그인 상태에서만 글쓰기 가능 -->
			<s:authorize access="isAuthenticated()">
				<button type="button" class="write">글쓰기</button>
			</s:authorize>
		</form>

		<!-- 레코드 갯수 출력 -->
		${map.count}개의 게시글이 있습니다.
		<table border="1" width="600px">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>이름</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<c:forEach var="row" items="${map.list}">
				<tr>
					<td>${row.bno}</td>
					<td>
						<a href="${path}/board/view?bno=${row.bno}&curPage=${map.boardPager.curPage}&searchOption=${map.searchOption}&keyword=${map.keyword}">${row.title}</a>
					</td>
					<td>${row.writer}</td>
					<td>
						<!-- fmt태그 사용 -->
						<fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
					<td>${row.viewcnt}</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="5">
					<!-- 처음페이지로 이동 : 현재페이지가 1보다 크면 [처음]나옴  -->
					<c:if test="${map.boardPager.curBlock > 1}">
						<a href="javascript:list('1')">[처음]</a>
					</c:if>
					
					<!-- 이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]나옴 -->
					<c:if test="${map.boardPager.curPage > 1}">
						<a href="javascript:list('${map.boardPager.prevPage}')">[이전]</a>
					</c:if>
					
					<!-- 하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
					<c:forEach var="num" begin="${map.boardPager.blockBegin}" end="${map.boardPager.blockEnd}">
						<!-- 현재페이지 하이퍼링크 제거 -->
						<c:choose>
							<c:when test="${num == map.boardPager.curPage}">
								<span style="color:red">${num}</span>&nbsp;
							</c:when>
							<c:otherwise>
								<a href="javascript:list('${num}')">${num}</a>&nbsp;
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<!-- 다음페이지 블록으로 이동 : 현재페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]나옴 -->
					<c:if test="${map.boardPager.curPage <= map.boardPager.totalPage}">
						<a href="javascript:list('${map.boardPager.nextPage}')">[다음]</a>
					</c:if>
					
					<!-- 끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]나옴 -->
					<c:if test="${map.boardPager.curPage <= map.boardPager.totalPage}">
						<a href="javascript:list('${map.boardPager.totalPage}')">[끝]</a>
					</c:if>
				</td>
			</tr>
		</table>
	</div>
	
	<%@ include file="../include/footer.jsp" %>

</body>
</html>	