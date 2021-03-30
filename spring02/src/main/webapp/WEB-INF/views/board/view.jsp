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
		$(".delete").on("click", function() {
			if(confirm("삭제하시겠습니까?")) {
				document.form1.action = "${path}/board/delete";
				document.form1.submit();
			}
		});

		$(".update").on("click", function() {
			var bno = $("#bno").val();
			location.href="${path}/board/update?bno="+bno;
		});		
	});
</script>

</head>
<body>

	<%@ include file="../include/header.jsp" %>
	
	<h2>게시글 보기</h2>
	
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
	</form>
	
	<%@ include file="../include/footer.jsp" %>

</body>
</html>	