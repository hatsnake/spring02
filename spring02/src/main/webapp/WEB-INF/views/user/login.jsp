<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<%@ include file="../include/util.jsp" %>

<link rel="stylesheet" href="/resources/css/formsign.css">
</head>

<body>

    <div class="wrapper">
        <%@ include file="../include/sidebar.jsp" %>

        <!-- Page Content  -->
        <div id="content">

			<%@ include file="../include/header.jsp" %>
			
			<div class="container" style="margin: 10.5rem auto;">
				<main class="form-signin">
					<form action="/user/login_check" method="post">
						<!--  
						<img class="mb-4" src="/docs/5.0/assets/brand/bootstrap-logo.svg" alt="" width="72" height="57">
						-->
						<h1 class="h3 mb-3 fw-normal text-center">로그인</h1>
						<span style="color:red;">${errMsg}</span>
				
						<div class="form-floating">
							<input type="text" name="userid" class="form-control userid" 
								id="floatingInput" placeholder="아이디" value="${userid}">
							<label for="floatingInput">아이디</label>
						</div>
						<div class="form-floating">
							<input type="password" name="passwd" class="form-control passwd" 
								id="floatingPassword" placeholder="비밀번호" value="${passwd}">
							<label for="floatingPassword">비밀번호</label>
						</div>
				
						<div class="form-check form-switch mb-3">
							<input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault" 
									 name="_spring_security_remember_me"> 
							<label class="form-check-label" for="flexSwitchCheckDefault">자동 로그인</label>
						</div>
						
						<button class="w-100 btn btn-md btn-primary loginCheck" type="submit">로그인</button>
						<hr>
						<div class="text-center">
							계정이 없으신가요? <a href="/user/join" style="color:#0d6efd;">회원가입</a>
						</div>
						
						<s:csrfInput />
						
						<p class="mt-4 mb-3 text-muted"></p>
					</form>
				</main>	
			</div>
	
			<%@ include file="../include/footer.jsp" %>
        </div>
    </div>

    <div class="overlay"></div>

</body>
</html>