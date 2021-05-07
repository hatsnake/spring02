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
				<main class="form-signin" style="min-height:380px;">
					<s:authorize access="isAuthenticated()">
						<h1 style="text-align:center;">회원정보</h1>
						<div>아이디 : ${username}</div>
						<div>이름 : ${name}</div>
						<div>이메일 : ${email}</div>
						<div>가입일 : ${regDate}</div>
						<div>수정일 : ${updateDate}</div>						
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
        </div>
    </div>

    <div class="overlay"></div>

</body>

</html>