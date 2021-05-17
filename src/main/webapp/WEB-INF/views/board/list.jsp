<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/subpages/utils.jsp" %>

<style>
.boardDate {
	font-size:0.9rem;
}
a:link .readed {
	color:black;
}
a:visited .readed {
	color:#989191;
}
</style>
<script type="text/javascript">
//글쓰기 페이지 이동
$(document).ready(function() {
	$(".write").on("click", function() {
		location.href="${path}/board/write";
	});

	
	var boardDate = document.querySelectorAll(".boardDate");

	for(var i = 0; i<boardDate.length; i++) {
		var regdate = boardDate[i].innerText;
		var createdAt = new Date(regdate);
		var result = displayedAt(createdAt);

		$(".boardDate:eq("+i+")").html(result);
	}
});

//원하는 페이지로 이동시 검색조건, 키워드 값 유지를 위한 함수
function list(page) {
	location.href="${path}/board/list?curPage="+page+"&searchOption=${map.searchOption}"+"&keyword=${map.keyword}";
}


function displayedAt(createdAt) {
	var milliSeconds = new Date() - createdAt;
	var seconds = milliSeconds / 1000;
	if(seconds < 60) 
		return "방금전";
	var minutes = seconds / 60;
	if(minutes < 60) 
		return Math.floor(minutes)+"분전";
	var hours = minutes / 60;
	if(hours < 24) 
		return Math.floor(hours)+"시간전";
	var days = hours / 24;
	if(days < 7) 
		return Math.floor(days)+"일전";
	var weeks = days / 7;
	if(weeks < 5) 
		return Math.floor(weeks)+"주전";
	else 
		return formatDate(createdAt);
}

function formatDate(date) { 
	var d = new Date(date), 
		month = '' + (d.getMonth() + 1), 
		day = '' + d.getDate(), 
		year = d.getFullYear(); 
	if (month.length < 2) month = '0' + month; 
	if (day.length < 2) day = '0' + day; 
	return year+"년"+month+"월"+day+"일"; 
}

</script>	

<body class="g-sidenav-show   bg-gray-100">
  <%@ include file="../include/subpages/sidebar.jsp" %>

  <main class="main-content mt-1 border-radius-lg">
    <%@ include file="../include/subpages/header.jsp" %>

    <div class="container-fluid py-4">

    <!-- CONTENTS -->
     <div class="row">
       <div class="col-12">
         <div class="card mb-4" style="padding:30px;">
           <div class="pb-0">
             <h5>Authors table</h5>
           </div>

           <form class="form-inline" name="form1" method="post" action="${path}/board/list">
             <div class="input-group mt-3 mb-3" style="max-width:600px;">
               <div class="input-group">
                 <select name="searchOption" class="form-select" id="button-addon1 inputGroupSelect04" aria-label="Example select with button addon" style="max-width:100px;">
                   <!--  c:out태그에 삼항연산자 사용 -->
                   <option value="all" <c:out value="${map.searchOption == 'all'?'selected':''}"/>>전체</option>
                   <option value="writer" <c:out value="${map.searchOption == 'writer'?'selected':''}"/>>이름</option>
                   <option value="content" <c:out value="${map.searchOption == 'content'?'selected':''}"/>>내용</option>
                   <option value="title" <c:out value="${map.searchOption == 'title'?'selected':''}"/>>제목</option>
                 </select>
               
                 <input type="text" name="keyword" class="form-control" value="${map.keyword}" aria-describedby="button-addon1">
               
                 <input type="submit" class="btn btn-primary" value="조회">
               </div>
             </div>
             
           </form>
           
           <div class="row">
	           <!-- 레코드 갯수 출력 -->
	           <div class="col-md-6 d-flex align-items-center">
	             ${map.count}개의 게시글이 있습니다.
	           </div>
	           
	           <!-- 로그인 상태에서만 글쓰기 가능 -->
	           <s:authorize access="isAuthenticated()">
	             <div class="col-md-6 text-right">
	               <button type="button" class="btn btn-primary write" style="float:right;">글쓰기</button>
	             </div>
	           </s:authorize>
           </div>

           <div class="card-body px-0 pt-0 pb-2">
             <div class="table-responsive p-0">
               <table class="table align-items-center mb-5 table-hover">
                 <thead>
                   <tr>
                     <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">제목</th>
                     <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">글쓴이</th>
                     <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">조회수</th>
                     <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">날짜</th>
                   </tr>
                 </thead>
                 <tbody>
                   <c:forEach var="row" items="${map.list}">
                     <c:choose>
                       <c:when test="${row.show == 'y'}">
                         <tr>
                           <td>
                             <a href="${path}/board/view?bno=${row.bno}&curPage=${map.boardPager.curPage}
												&searchOption=${map.searchOption}&keyword=${map.keyword}">
                               <div class="d-flex px-2 py-1">
                                 <div class="d-flex flex-column justify-content-center" style="overflow:hidden; white-space:nowrap; text-overflow:ellipsis; width:150px;">
                                   <p class="text-xs text-secondary mb-0">[${row.categoryname}]</p>
                                   <h6 class="mb-0 text-sm" >${row.title}</h6>

                                   <c:if test="${row.recnt > 0}">
                                     <span style="color:red; font-size:17px;">
                                       <i class="far fa-comment-dots"></i> 
                                       ${row.recnt}
                                     </span>
                                   </c:if>
                                 </div>
                               </div>
                             </a>
                           </td>
                           <td>
                             <p class="text-xs font-weight-bold mb-0">${row.writer}</p>
                             <p class="text-xs text-secondary mb-0">Organization</p>
                           </td>
                           <td class="align-middle text-center text-sm">
                             <span class="badge badge-sm bg-gradient-success">${row.viewcnt}</span>
                           </td>
                           <td class="align-middle text-center">
                             <span class="text-secondary text-xs font-weight-bold boardDate">
                               <fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                             </span>
                           </td>
                         </tr>
                       </c:when>
                       <c:otherwise>

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
												&laquo;
											</a>
										</li>
									</c:if>
									
									<!-- 이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]나옴 -->
									<c:if test="${map.boardPager.curPage > 1}">
										<li class="page-item">
											<a class="page-link" href="javascript:list('${map.boardPager.prevPage}')">
												&lt;
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
         </div>
       </div>
      </div>
      <!-- END CONTENTS -->     

      <%@ include file="../include/subpages/footer.jsp" %>

    </div>

  </main>
  <div class="fixed-plugin">
    <a class="fixed-plugin-button text-dark position-fixed px-3 py-2">
      <i class="fa fa-cog py-2"> </i>
    </a>
    <div class="card shadow-lg ">
      <div class="card-header pb-0 pt-3 ">
        <div class="float-start">
          <h5 class="mt-3 mb-0">Soft UI Configurator</h5>
          <p>See our dashboard options.</p>
        </div>
        <div class="float-end mt-4">
          <button class="btn btn-link text-dark p-0 fixed-plugin-close-button">
            <i class="fa fa-close"></i>
          </button>
        </div>
        <!-- End Toggle Button -->
      </div>
      <hr class="horizontal dark my-1">
      <div class="card-body pt-sm-3 pt-0">
        <!-- Sidebar Backgrounds -->
        <div>
          <h6 class="mb-0">Sidebar Colors</h6>
        </div>
        <a href="javascript:void(0)" class="switch-trigger background-color">
          <div class="badge-colors my-2 text-start">
            <span class="badge filter bg-gradient-primary active" data-color="primary" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-dark" data-color="dark" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-info" data-color="info" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-success" data-color="success" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-warning" data-color="warning" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-danger" data-color="danger" onclick="sidebarColor(this)"></span>
          </div>
        </a>
        <!-- Sidenav Type -->
        <div class="mt-3">
          <h6 class="mb-0">Sidenav Type</h6>
          <p class="text-sm">Choose between 2 different sidenav types.</p>
        </div>
        <div class="d-flex">
          <button class="btn bg-gradient-primary w-100 px-3 mb-2 active" data-class="bg-transparent" onclick="sidebarType(this)">Transparent</button>
          <button class="btn bg-gradient-primary w-100 px-3 mb-2 ms-2" data-class="bg-white" onclick="sidebarType(this)">White</button>
        </div>
        <p class="text-sm d-xl-none d-block mt-2">You can change the sidenav type just on desktop view.</p>
        <!-- Navbar Fixed -->
        <div class="mt-3">
          <h6 class="mb-0">Navbar Fixed</h6>
        </div>
        <div class="form-check form-switch ps-0">
          <input class="form-check-input mt-1 ms-auto" type="checkbox" id="navbarFixed" onclick="navbarFixed(this)">
        </div>
        <hr class="horizontal dark my-sm-4">
        <a class="btn bg-gradient-dark w-100" href="https://www.creative-tim.com/product/soft-ui-dashboard">Free download</a>
        <a class="btn btn-outline-dark w-100" href="https://www.creative-tim.com/learning-lab/bootstrap/license/soft-ui-dashboard">View documentation</a>
        <div class="w-100 text-center">
          <a class="github-button" href="https://github.com/creativetimofficial/soft-ui-dashboard" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star creativetimofficial/soft-ui-dashboard on GitHub">Star</a>
          <h6 class="mt-3">Thank you for sharing!</h6>
          <a href="https://twitter.com/intent/tweet?text=Check%20Soft%20UI%20Dashboard%20made%20by%20%40CreativeTim%20%23webdesign%20%23dashboard%20%23bootstrap5&amp;url=https%3A%2F%2Fwww.creative-tim.com%2Fproduct%2Fsoft-ui-dashboard" class="btn btn-dark mb-0 me-2" target="_blank">
            <i class="fab fa-twitter me-1" aria-hidden="true"></i> Tweet
          </a>
          <a href="https://www.facebook.com/sharer/sharer.php?u=https://www.creative-tim.com/product/soft-ui-dashboard" class="btn btn-dark mb-0 me-2" target="_blank">
            <i class="fab fa-facebook-square me-1" aria-hidden="true"></i> Share
          </a>
        </div>
      </div>
    </div>
  </div>

  <%@ include file="../include/subpages/footerScript.jsp" %>
  
</body>

</html>