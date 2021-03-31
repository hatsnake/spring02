<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<html>
<head>
<title>메인 화면</title>

<style type="text/css">

</style>

<%@ include file="../include/util.jsp" %>

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