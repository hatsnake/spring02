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

        </div>
    </div>

    <div class="overlay"></div>
</body>
</html>