<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인 화면</title>

<%@ include file="../include/util.jsp" %>

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
.loginCheck {
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
		  <form action="${path}/user/login_check" method="post">
		  	<!--  
		    <img class="mb-4" src="/docs/5.0/assets/brand/bootstrap-logo.svg" alt="" width="72" height="57">
		    -->
		    <h1 class="h3 mb-3 fw-normal text-center">로그인</h1>
		    <span style="color:red;">${errMsg}</span>
		
		    <div class="form-floating">
		      <input type="text" name="userid" class="form-control userid" id="floatingInput" placeholder="아이디">
		      <label for="floatingInput">아이디</label>
		    </div>
		    <div class="form-floating">
		      <input type="password" name="passwd" class="form-control passwd" id="floatingPassword" placeholder="비밀번호">
		      <label for="floatingPassword">비밀번호</label>
		    </div>
		
		    <div class="form-check form-switch mb-3">
		        <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault" 
		        	   name="_spring_security_remember_me"> 
		       	<label class="form-check-label" for="flexSwitchCheckDefault">자동 로그인</label>
		    </div>
		    
		    <button class="w-100 btn btn-md btn-primary loginCheck" type="submit">로그인</button>
		    <button class="w-100 btn btn-md btn-secondary join" type="button">회원가입</button>    
		    <p class="mt-4 mb-3 text-muted"></p>
		  </form>
		</main>
	</div>

	<%@ include file="../include/footer.jsp" %>

</body>

</html>


