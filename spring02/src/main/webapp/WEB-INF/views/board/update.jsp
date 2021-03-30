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
	$(".updateCheck").on("click", function() {
		var title = $("#title").val();
		var content = $("#content").val();
		if(title == "") {
			alert("제목을 입력하세요");
			document.form1.title.focus();
			return;
		}
		
		if(content == "") {
			alert("내용을 입력하세요");
			document.form1.content.focus();
			return;
		}	
		document.form1.action="${path}/board/update";
		document.form1.submit();
	});
});
</script>

</head>
<body>

	<%@ include file="../include/header.jsp" %>

	<h2>게시글 작성</h2>
	<form name="form1" method="post">
		<div>
			제목 : <input type="text" name="title" id="title" size="80" placeholder="제목을 입력해주세요" value="${dto.title}">
		</div>
		
		<div>
			내용 : <textarea name="content" id="content" rows="4" cols="80" placeholder="제목을 입력해주세요">${dto.content}</textarea>
		</div>
		
		<div>
			이름 : ${dto.writer}
			<input type="hidden" name="writer" id="writer" value="${dto.writer}">
		</div>
		<div style="width:650px; text-align:center;">
			<input type="hidden" name="bno" id="bno" value="${dto.bno}">
			<button type="button" class="updateCheck">수정</button>
			<button type="reset">취소</button>
		</div>
						
	</form>	
	
	<%@ include file="../include/footer.jsp" %>

</body>
</html>	