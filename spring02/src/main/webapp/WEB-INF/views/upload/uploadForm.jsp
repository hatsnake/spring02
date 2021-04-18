<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../include/util.jsp" %>
<style type="text/css">
iframe {
	width:600px;
	height:100px;
	border:1px;
	border-style:solid;
}
</style>
</head>

<body>
    <div class="wrapper">
    	<%@ include file="../include/sidebar.jsp" %>

		<%@ include file="../include/header.jsp" %>

		<!-- enctype="multipart/form-data" 파일업로드 필수 옵션 -->
		<!-- application/x-www-form-urlencoded 기본옵션 -->
		<form id="form1" target="iframePhoto" action="${path}/upload/uploadForm" method="post" enctype="multipart/form-data">
			<input type="file" name="file">
			<input type="submit" value="업로드">
		</form>
		<!-- form data가 이곳으로 이동 -->
		<iframe name="iframePhoto"></iframe>

		<%@ include file="../include/footer.jsp" %>


    </div>

    <div class="overlay"></div>

	<script>
		function addFilePath(msg) {
			console.log(msg);
			//iframe에 업로드결과를 출력후 form에 저장된 데이터 초기화
			document.getElementById("form1").reset();
		}
	</script>

</body>

</html>