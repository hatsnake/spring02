<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
<%@ include file="../include/util.jsp" %>
	
<script type="text/javascript">
//글쓰기 페이지 이동
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

    <div class="wrapper">
		<%@ include file="../include/sidebar.jsp" %>

        <!-- Page Content  -->
        <div id="content">

			<%@ include file="../include/header.jsp" %>
		
			<div class="container">
				<!-- 글 목록 -->
				<h1 style="margin-left:15px;">인기글</h1>
				<div style="padding:20px !important; background:white; border-radius: 25px; box-shadow:1px 1px 5px gray;">
					<!-- 검색 -->
					<form class="form-inline" name="form1" method="post" action="${path}/board/list">
						<div class="input-group mt-3 mb-3" style="max-width:600px;">
						  <div class="input-group-prepend">
						    <select name="searchOption">
								<!--  c:out태그에 삼항연산자 사용 -->
								<option value="all" <c:out value="${map.searchOption == 'all'?'selected':''}"/>>제목+이름+제목</option>
								<option value="writer" <c:out value="${map.searchOption == 'writer'?'selected':''}"/>>이름</option>
								<option value="content" <c:out value="${map.searchOption == 'content'?'selected':''}"/>>내용</option>
								<option value="title" <c:out value="${map.searchOption == 'title'?'selected':''}"/>>제목</option>
							</select>
						  </div>
						  <input type="text" name="keyword" class="form-control" value="${map.keyword}">
						    <div class="input-group-append">
							    <input type="submit" class="btn btn-primary" value="조회">
							 </div>
						</div>
						
					</form>
					
					<!-- 레코드 갯수 출력 -->
					<div>
						${map.count}개의 게시글이 있습니다.
					</div>
					
					<!-- 로그인 상태에서만 글쓰기 가능 -->
					<s:authorize access="isAuthenticated()">
						<div>
							<button type="button" class="btn btn-primary write" style="float:right;">글쓰기</button>
						</div>
					</s:authorize>
						
					
					<table class="table table-hover">
						<thead style="background:white;">
							<tr>
								<th scope="col" class="text-center" style="width:55%;">제목</th>
								<th scope="col" class="text-center" style="width:15%;">글쓴이</th>
								<th scope="col" class="text-center" style="width:15%;">조회수</th>
								<th scope="col" class="text-center" style="width:15%;">날짜</th>
							</tr>
						</thead>
						<tbody style="background:white;">
							<!-- 글목록 출력 -->
							<c:forEach var="row" items="${map.list}">
								<c:choose>
									<c:when test="${row.show == 'y'}">
										<tr>
											<td>
												<a href="${path}/board/view?bno=${row.bno}&curPage=${map.boardPager.curPage}
													&searchOption=${map.searchOption}&keyword=${map.keyword}">
													<div style="overflow:hidden; white-space:nowrap; text-overflow:ellipsis; width:150px;">
														${row.title}
													</div>
													<!-- 댓글이 있으면 게시글 이름 옆에 댓글 수 출력 -->
													<c:if test="${row.recnt > 0}">
														<span style="color:red; font-size:17px;">
															<i class="far fa-comment-dots"></i> 
															${row.recnt}
														</span>
													</c:if>
												</a>
											</td>
											<td style="word-break:break-all;">${row.writer}</td>
											<td style="word-break:break-all;">${row.viewcnt}</td>
											<td style="word-break:break-all;">
												<fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5" align="left">
												<c:if test="${row.recnt > 0}">
													<a href="${path}/board/view?bno=${row.bno}&curPage=${map.boardPager.curPage}&searchOption=${map.searchOption}&keyword=${map.keyword}">
														삭제된 게시글입니다.
														<span style="color:red; font-size:17px;">
															<i class="far fa-comment-dots"></i> 
															${row.recnt}
														</span>
													</a>
												</c:if>
												<c:if test="${row.recnt == 0}">
													삭제된 게시글입니다.
												</c:if>
											</td>
										</tr>									
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
						</tbody>
					</table>
		
					<!-- 페이지 네이션 -->
					<nav aria-label="...">
						<ul class="pagination d-flex justify-content-center">
							<!-- 처음페이지로 이동 : 현재페이지가 1보다 크면 [처음]나옴  -->
							<c:if test="${map.boardPager.curBlock > 1}">
								<li class="page-item">
									<a class="page-link" href="javascript:list('1')">
										<span class="page-link">&laquo;</span>
									</a>
								</li>
							</c:if>
							
							<!-- 이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]나옴 -->
							<c:if test="${map.boardPager.curPage > 1}">
								<li class="page-item">
									<a class="page-link" href="javascript:list('${map.boardPager.prevPage}')">
										<span class="page-link">&lt;</span>
									</a>
								</li>
							</c:if>
							
							<!-- 하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
							<c:forEach var="num" begin="${map.boardPager.blockBegin}" end="${map.boardPager.blockEnd}">
								<!-- 현재페이지 하이퍼링크 제거 -->
								<c:choose>
									<%-- 현재 페이지 (링크x) --%>
									<c:when test="${num == map.boardPager.curPage}">
										<li class="page-item active">
											<span class="page-link">${num}</span>
										</li>
									</c:when>
									<%-- 다른 페이지 --%>
									<c:otherwise>
										<li class="page-item"><a class="page-link" href="javascript:list('${num}')">${num}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
				
							<!-- 다음페이지 블록으로 이동 : 현재페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]나옴 -->
							<c:if test="${map.boardPager.curPage <= map.boardPager.totalPage}">
								<li class="page-item">
									<a class="page-link" href="javascript:list('${map.boardPager.nextPage}')">
										&gt;
									</a>
								</li>
							</c:if>
							
							<!-- 끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]나옴 -->
							<c:if test="${map.boardPager.curPage <= map.boardPager.totalPage}">
								<li class="page-item">
									<a class="page-link" href="javascript:list('${map.boardPager.totalPage}')">
										&raquo;
									</a>
								</li>
							</c:if>
						</ul>
					</nav>
				</div>
			</div>
			<!-- /글 목록 -->
	
			<%@ include file="../include/footer.jsp" %>

        </div>


    </div>

    <div class="overlay"></div>

</body>

</html>