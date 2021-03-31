<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
<title>메인 화면</title>

<style type="text/css">

</style>

<%@ include file="../include/util.jsp" %>

<script type="text/javascript">
	$(document).ready(function() {

		listReplyRest('1');
		//listReply2();

		
		$(".replyCheck").on("click", function() {
			replyJson(); 
			//reply();
		});

		//게시글 삭제
		$(".delete").on("click", function() {
			//댓글이 존재하는 게시물의 삭제처리 방지
			var count = "${count}";
			//댓글의 수가 0보다 크면 팝업, 함수 종료
			if(count > 0) {
				alert("댓글이 있는 게시글은 삭제할 수 없습니다.");
				return;
			}
			if(confirm("삭제하시겠습니까?")) {
				document.form1.action = "${path}/board/delete";
				document.form1.submit();
			}
		});

		//게시글 수정 이동
		$(".update").on("click", function() {
			var bno = $("#bno").val();
			location.href="${path}/board/update?bno="+bno;
		});		

		//게시글 목록 이동 버튼이벤트
		$(".list").on("click", function() {
			location.href="${path}/board/list?curPage=${curPage}&searchOption=${searchOption}&keyword=${keyword}";
		});				
	});
	
	//댓글작성 1번째 (폼데이터로 입력)
	function reply() {
		var replytext = $("#replytext").val();
		var bno="${dto.bno}";
		var secretReply = "n";
		if($("#secretReply").is(":checked")) {
			secretReply = "y";
		}
		var param="replytext="+replytext+"&bno="+bno+"&secretReply="+secretReply;
		$.ajax({
			type : "post",
			url : "${path}/reply/insert",
			data : param,
			success : function() {
				alert("댓글이 등록되었습니다. (폼데이터 방식)");
				//listReply2();
				listReply('1');
			},
		   	error:function(){
				alert("댓글 작성에 실패하였습니다.");
			}
		});
	}

	//댓글작성 2번째 (json 방식) *사용중
	function replyJson() {
		var replytext = $("#replytext").val();
		var bno = "${dto.bno}"
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
				secretReply : secretReply
			}),
			success: function() {
				alert("댓글이 등록되었습니다. (json방식)");
				listReplyRest('1');
			}
		});
	}	

	//controller방식 (댓글 목록1)
	function listReply(num) {
		$.ajax({
			type : "get",
			url : "${path}/reply/list?bno=${dto.bno}&curPage="+num,
			success : function(result) {
				$("#listReply").html(result);
			}
		});
	}

	//RestController방식 (댓글 목록2, json)
	function listReply2() {
		$.ajax({
			type : "get",
			url : "${path}/reply/listJson?bno=${dto.bno}",
			success : function(result) {
				var output = "<table>";
				for(var i in result) {
					output += "<tr>";
					output += "<td>"+result[i].replyer;
					output += "("+changeDate(result[i].regdate)+")<br>";
					output += result[i].replytext+"</td>";
					output += "<tr>";
				}
				output += "</table>";
				$("#listReply").html(output);
			}
		});
	}

	//날짜 변환 함수 작성
	function changeDate(date) {
		date = new Date(parseInt(date));
		year = date.getFullYear();
		month = date.getMonth();
		day = date.getDate();
		hour = date.getHours();
		minute = date.getMinutes();
		second = date.getSeconds();
		strDate = year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
		return strDate;
	}

	//댓글 목록 - (Rest방식) *사용중
	function listReplyRest(num) {
		$.ajax({
			type: "get",
			url: "${path}/reply/list/${dto.bno}/"+num,
			success: function(result) {
				$("#listReply").html(result);
			}
		})
	}

	//댓글 수정화면 생성 *사용중
	function showReplyModify(rno) {
		$.ajax({
			type: "get",
			url: "${path}/reply/detail/"+rno,
			success: function(result) {
				$("#modifyReply").html(result);
				$("#modifyReply").css("visibility", "visible");
			}
		})
	}
</script>

<style type="text/css">
#modifyReply {
	width:600px;
	height:130px;
	background-color:gray;
	padding:10px;
	z-index:10;
	visibility:hidden;
}
</style>

</head>
<body>

	<%@ include file="../include/header.jsp" %>
	
	<h2>게시글 보기</h2>
	
	<c:choose>	
		<c:when test="${dto.show == 'y'}">
			<form name="form1" method="post">
				<div>
					작성일자 : <fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd a HH:mm:ss"/>
				</div>
				<div>
					조회수 : ${dto.viewcnt}
				</div>
				<div>
					제목 : ${dto.title}
				</div>
				<div>
					내용 : ${dto.content}
				</div>
				<div>
					이름 : ${dto.writer}
				</div>
				
				<input type="hidden" name="bno" id="bno" value="${dto.bno}">
				<c:if test="${username == dto.writer}">
					<button type="button" class="update">수정</button>
					<button type="button" class="delete">삭제</button>
				</c:if>
				<button type="button" class="list">목록</button>
			</form>
		</c:when>
		<c:otherwise>
				삭제된 게시글입니다.
		</c:otherwise>
	</c:choose>
	
	<div style="width:650px; text-align:center;">
		<br>
		<!-- 로그인한 회원에게만 댓글 작성폼이 보이게 처리 -->
		<s:authorize access="isAuthenticated()">
			<textarea rows="5" cols="80" id="replytext" placeholder="댓글을 작성해주세요"></textarea>
			<br>
			<!-- 비밀댓글 체크박스 -->
			<input type="checkbox" id="secretReply">비밀댓글
			<button type="button" class="replyCheck">댓글 작성</button>
		</s:authorize>
		<!-- 댓글 목록 출력할 위치 -->
		<div id="listReply"></div>
	</div>
	
	
	<%@ include file="../include/footer.jsp" %>

</body>
</html>	