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

<script>
//댓글 수정
$("#btnReplyUpdate").on("click", function() {
	var detailReplytext = $("#detailReplytext").val();
	$.ajax({
		type: "put",
		url: "${path}/reply/update/${dto.rno}",
		headers: {
			"Content-Type" : "application/json"
		},
		dataType:"text",
		success: function(result) {
			if(result == "success") {
				$("modifyReply").css("visibility", "hidden");
				listReplyRest('1');
			}
		}
	});
});

//댓글 상세화면 닫기
$("#btnReplyClose").on("click", function() {
	$("#modifyReply").css("visibility", "hidden");
});

//댓글 삭제
$("#btnReplyDelete").on("click", function() {
	if(confirm()) {
		$.ajax({
			type: "delete",
			url: "${path}/reply/delete/${dto.rno}",
			success: function(result) {
				if(result == "success") {
					alert("삭제되었습니다.");
					$("#modifyReply").css("visibility", "hidden");
					listReplyRest('1');
				}
			}
		});
	}
});
</script>

댓글 번호 : ${dto.rno}<br>
<textarea id="detailReplytext" rows="5" cols="82">${dto.replytext}</textarea>
<div style="text-align:center;">
	<!-- 본인 댓글만 수정,삭제 가능하도록 처리 -->

		<button type="button" id="btnReplyUpdate">수정</button>
		<button type="button" id="btnReplyDelete">삭제</button>

	<button type="button" id="btnReplyClose">닫기</button>
</div>