<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>로그인 화면</title>

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

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<style type="text/css">
html,
body {
  height: 100%;
}
body {
  display: grid;
  align-items: end;
  padding-top: 40px;
  padding-bottom: 0px;
  background-color: #f5f5f5;
}
.form-signin {
  width: 100%;
  max-width: 366px;
  padding: 22px;
  margin: auto;
  background: #fbfbfb;
  box-shadow: 2px 2px 5px #c3bbbb;
}
.form-signin .checkbox {
  font-weight: 400;
}
.form-signin .form-floating:focus-within {
  z-index: 2;
}
.form-signin input[type="email"] {
  margin-bottom: -1px;
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
}
.form-signin input[type="password"] {
  margin-bottom: 10px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}
.login {
  margin-bottom:5px;
}
.userid {
  margin-bottom:5px;
}
.form-check .form-check-input {
  float:none !important;
}
</style>

</head>

<body>
    
    <%@ include file="../include/header.jsp" %>
	
    <div class="container">
		<main class="form-signin">
		  <s:authorize access="isAuthenticated()">
			<h1>회원정보</h1>
			<div>아이디 : ${username}</div>
			<div>이름 : ${name}</div>
			<div>권한 :  
			  	<c:choose>
			  		<c:when test="${auth == '[ROLE_USER]'}">
			  			사용자
			  		</c:when>
			  		<c:when test="${auth == '[ROLE_ADMIN]'}">
			  			관리자
			  		</c:when>
			  		<c:otherwise>
			  			알수 없는 사용자입니다.
			  		</c:otherwise>
			  	</c:choose>		 
		  	</div> 	
		  </s:authorize>
		</main>
	</div>

	<%@ include file="../include/footer.jsp" %>

</body>

</html>


