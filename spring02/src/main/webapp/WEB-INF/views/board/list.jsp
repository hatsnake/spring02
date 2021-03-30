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
</script>

</head>
<body>

	<%@ include file="../include/header.jsp" %>
	
	<div class="container" style="max-width:960px; margin:20px auto;">
		<button type="button" class="write">글쓰기</button>
		
		<table border="1" width="600px">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>이름</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<c:forEach var="row" items="${list}">
				<tr>
					<td>${row.bno}</td>
					<td><a href="${path}/board/view?bno=${row.bno}">${row.title}</a></td>
					<td>${row.writer}</td>
					<td>
						<!-- fmt태그 사용 -->
						<fmt:formatDate value="${row.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
					<td>${row.viewcnt}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<%@ include file="../include/footer.jsp" %>

</body>
</html>	