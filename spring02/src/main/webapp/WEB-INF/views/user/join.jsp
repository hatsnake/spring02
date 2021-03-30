<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>로그인 화면</title>

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
.form-signin input[type="text"] {
  margin-bottom: 8px;
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
}
.form-signin input[type="password"] {
  margin-bottom: 8px;
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
		  <form action="${path}/user/insertUser" method="post">
		  	<!--  
		    	<img class="mb-4" src="/docs/5.0/assets/brand/bootstrap-logo.svg" alt="" width="72" height="57">
		    -->
		    <h1 class="h3 mb-3 fw-normal text-center">회원가입</h1>
		    <!--
		    	<span style="color:red;">${errMsg}</span>
		    -->
		
		    <div class="form-floating">
		      <input type="text" name="userid" class="form-control userid" id="floatingInput" placeholder="아이디">
		      <label for="floatingInput">아이디</label>
		    </div>
		    
		    <div class="form-floating">
		      <input type="password" name="passwd" class="form-control passwd" id="floatingPassword" placeholder="비밀번호">
		      <label for="floatingPassword">비밀번호</label>
		    </div>

		    <div class="form-floating">
		      <input type="password" name="passwd2" class="form-control passwd" id="floatingPassword" placeholder="비밀번호 확인">
		      <label for="floatingPassword">비밀번호 확인</label>
		    </div>

		    <div class="form-floating">
		      <input type="text" name="name" class="form-control userid" id="floatingInput" placeholder="이름">
		      <label for="floatingInput">이름</label>
		    </div>
		    
		    <button class="w-100 btn btn-md btn-secondary join" type="submit">회원가입</button> 
		    <p class="mt-4 mb-3 text-muted"></p>
		  </form>
		</main>
	</div>

	<%@ include file="../include/footer.jsp" %>

</body>
</html>
