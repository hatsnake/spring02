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
	$(".writeCheck").click(function() {
		var title = $("#title").val();
		var content = $("#content").val();
		var writer = $("#writer").val();
		if(title == "") {
			alert("제목을 입력해주세요");
			document.form1.title.focus();
			return;
		}
		if(content == "") {
			alert("제목을 입력해주세요");
			document.form1.content.focus();
			return;
		}
		if(writer == "") {
			alert("이름을 입력해주세요");
			return;
		}	
		document.form1.submit();			
	});	
});
</script>

</head>
<body>

	<%@ include file="../include/header.jsp" %>
	
	<h2>게시글 작성</h2>
	<form name="form1" method="post" action="${path}/board/insert">
		<div>
			제목 : <input type="text" name="title" id="title" size="80" placeholder="제목을 입력해주세요">
		</div>
		
		<div>
			내용 : <textarea name="content" id="content" rows="4" cols="80" placeholder="제목을 입력해주세요"></textarea>
		</div>
		
		<div>
			이름 : ${username}
			<input type="hidden" name="writer" id="writer" value="${username}">
		</div>
		<div style="width:650px; text-align:center;">
			<button type="button" class="writeCheck">등록</button>
			<button type="reset">취소</button>
		</div>
						
	</form>
	
	
	<%@ include file="../include/footer.jsp" %>

</body>
</html>	