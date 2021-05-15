<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="../include/util.jsp" %>
<style type="text/css">

</style>
</head>

<body>
    <div class="wrapper">
    	<%@ include file="../include/sidebar.jsp" %>

		<%@ include file="../include/header.jsp" %>

		파일이 업로드 되었습니다.
		파일명 : ${savedName}

		<%@ include file="../include/footer.jsp" %>


    </div>

    <div class="overlay"></div>

	<script>
		var result = "${savedName}";
		parent.addFilePath(result); //파일명을 부모페이지로 전달
	</script>

</body>

</html>