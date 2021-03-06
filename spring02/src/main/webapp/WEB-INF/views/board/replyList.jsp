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
<style>
.boardDate {
	font-size: 0.9rem;
}
</style>
<script>
$(document).ready(function() {
	
	$(".replyCheck").on("click", function() {
		replyJson(); 
		//reply();
	});

	var boardDate = document.querySelectorAll(".boardDate");

	for(var i = 0; i<boardDate.length; i++) {
		var regdate = boardDate[i].innerText;
		var createdAt = new Date(regdate);
		var result = displayedAt(createdAt);

		$(".boardDate:eq("+i+")").html(result);
	}
	
});

//시간측정
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

//댓글작성 2번째 (json 방식) *사용중
function replyJson() {
	var replytext = $("#replytext").val();
	var bno = "${bno}";
	var writer = "${writer}";
	//비밀댓글 체크여부
	var secretReply = "n";
	//비밀댓글 체크 true or false
	if($("#secretReply").is(":checked")) {
		secretReply = "y";
	}
	
	$.ajax({
		type: "post",
		url: "${path}/reply/insertRest",
		headers: {
			"Content-Type" : "application/json"
		},
		dateType: "text",
		data: JSON.stringify({
			bno : bno,
			replytext : replytext,
			secretReply : secretReply,
			writer : writer
		}),
		success: function() {
			alert("댓글이 등록되었습니다. (json방식)");
			listReplyRest('1');
		}
	});
}	

//댓글 목록 - (Rest방식) *사용중
function listReplyRest(num) {
	$.ajax({
		type: "get",
		url: "${path}/reply/list/${bno}/"+num,
		success: function(result) {
			$("#listReply").html(result);
		}
	})
}

//댓글 수정
$("#replyUpdate").on("click", function() {

	if(confirm("댓글을 수정하시겠습니까?")) {
		var modifyReplytext = $("#modify_replytext").val();
		var rno = $("#modify_rno").text();
	
		$.ajax({
			type: "put",
			url: "${path}/reply/update/"+rno,
			headers: {
				"Content-Type" : "application/json"
			},
			data: JSON.stringify({
				replytext : modifyReplytext
			}),
			dataType:"text",
			success: function(result) {
				if(result == "success") {
					alert("댓글 수정이 완료되었습니다.")
					listReplyRest('1');
				}
			}
		});
	}
	
});

</script>

<!-- 댓글 갯수 -->
<div class="card-body">
	<h4 class="card-title"><i class="far fa-comment-dots"></i> 댓글</h4>
	<h6 class="card-subtitle">${replyCount}개의 댓글이 있습니다</h6>
</div>

<!-- 댓글입력 -->
<s:authorize access="isAuthenticated()">
	<div style="padding:10px; background:#e2dcdc; max-width:600px;">
	  <div style="padding-left:10px;">
	  	<span>${username}</span>
	  </div>
	  <textarea class="form-control" id="replytext" placeholder="댓글을 작성해주세요" style="height: 100px"></textarea>
	  <div style="padding-left:10px;">
	    <div class="form-check" style="float:left">
		  <input class="form-check-input" type="checkbox" value="" id="secretReply">
		  <label class="form-check-label" for="flexCheckDefault">
		    비밀댓글
		  </label>
		</div>
		
	  	<button type="button" class="btn btn-primary replyCheck" style="float:right; margin-top:5px;">등록</button>
	  	<div style="clear:both"></div>
	  </div>
	</div>
</s:authorize>

<c:forEach var="row" items="${list}">
	<div class="d-flex flex-row comment-row">
		<div class="p-2"><span class="round"><img src="https://i.imgur.com/uIgDDDd.jpg" alt="user" width="50"></span></div>
		<div class="comment-text w-100">
			<h5>
				<!-- <span style="font-size:10px;" class="label label-info">일반</span> --> 
				${row.replyer}
			</h5>
			<div class="comment-footer"> 
				<div class="date boardDate"><fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></div> 
				 
				<span class="action-icons"> 
					<c:if test="${username == row.replyer}">
						<span type="button" id="btnModify" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="showReplyModify('${row.rno}')" data-abc="true">
							<i class="far fa-edit"></i>
						</span> 
						
						<span class="far fa-trash-alt" onclick="deleteReply('${row.rno}')"></span>
					</c:if>

				</span> 
			</div>
			<p class="m-b-5 m-t-10 comment-text">${row.replytext}</p>
		</div>
	</div>
</c:forEach>
	

	
<!-- 페이지 네이션 -->
<nav aria-label="...">
	<ul class="pagination d-flex justify-content-center">
		<!-- 처음페이지로 이동 : 현재페이지가 1보다 크면 [처음]나옴  -->
		<c:if test="${replyPager.curBlock > 1}">
			<li class="page-item">
				<a class="page-link" href="javascript:listReplyRest('1')">
					&laquo;
				</a>
			</li>
		</c:if>
		
		<!-- 이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]나옴 -->
		<c:if test="${replyPager.curPage > 1}">
			<li class="page-item">
				<a class="page-link" href="javascript:listReplyRest('${replyPager.prevPage}')">
					&lt;
				</a>
			</li>
		</c:if>
		
		<!-- 하나의 블럭에서 반복문 수행 시작페이지부터 끝페이지까지 -->
		<c:forEach var="num" begin="${replyPager.blockBegin}" end="${replyPager.blockEnd}">
			<!-- 현재페이지 하이퍼링크 제거 -->
			<c:choose>
				<%-- 현재 페이지 (링크x) --%>
				<c:when test="${num == replyPager.curPage}">
					<li class="page-item active">
						<span class="page-link">${num}</span>
					</li>
				</c:when>
				<%-- 다른 페이지 --%>
				<c:otherwise>
					<li class="page-item"><a class="page-link" href="javascript:listReplyRest('${num}')">${num}</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<!-- 다음페이지 블록으로 이동 : 현재페이지 블럭이 전체 페이지 블럭보다 작거나 같으면 [다음]나옴 -->
		<c:if test="${replyPager.curPage <= replyPager.totalPage}">
			<li class="page-item">
				<a class="page-link" href="javascript:listReplyRest('${replyPager.nextPage}')">
					&gt;
				</a>
			</li>
		</c:if>
		
		<!-- 끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]나옴 -->
		<c:if test="${replyPager.curPage <= replyPager.totalPage}">
			<li class="page-item">
				<a class="page-link" href="javascript:listReplyRest('${replyPager.totalPage}')">
					&raquo;
				</a>
			</li>
		</c:if>
	</ul>
</nav>


<!-- 댓글 수정 영역 -->
<div id="modifyReply"></div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        댓글 번호 : <span id="modify_rno"></span><br>
		<textarea id="modify_replytext" rows="5" cols="82"></textarea>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="replyUpdate">수정 저장</button>
      </div>
    </div>
  </div>
</div>