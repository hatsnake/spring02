<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
<%@ include file="../include/util.jsp" %>
<style type="text/css">

</style>
</head>

<body>
    <div class="wrapper">
    	<%@ include file="../include/sidebar.jsp" %>

		<%@ include file="../include/header.jsp" %>
		<div class="container" style="max-width:500px; height:400px; padding:30px;">
			<h1>${errMsgTitle}</h1>
			<h4>${errMsgContent}</h4>
			<a href="${path}/" class="main_link">메인화면 이동</a>
		</div>
		<%@ include file="../include/footer.jsp" %>


    </div>

    <div class="overlay"></div>

</body>

</html>