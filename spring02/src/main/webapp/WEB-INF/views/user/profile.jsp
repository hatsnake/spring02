<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<%@ include file="../include/util.jsp" %>

<link rel="stylesheet" href="/resources/css/formsign.css">
<script>

$(document).ready(function() {
	
	$(".currentPasswordCheck").on("click", function() {
		var currentPassword = $(".currentPassword").val();

		$.ajax({
			type:"post",
			url:"/user/currentPasswordCheck",
			data: {currentPassword : `currentPassoword`},
			success: function(result) {
				if(result == 1) {
					alert("성공");
				} else {
					alert("틀림");
				}
			}, 
			fail: function() {
				alert("에러발생. 다시 시도해주세요.");
			}
		});
		
	});
	
});

function cancleAccount() {
	if(window.confirm("정말 회원탈퇴하시겠습니까?")) {
		$("#form2").submit();
		return false;
	};
}
</script>
<style>
#changePasswordBox {
	display:none;
}
</style>
</head>

<body>

    <div class="wrapper">
		<%@ include file="../include/sidebar.jsp" %>

        <!-- Page Content  -->
        <div id="content">
			<%@ include file="../include/header.jsp" %>
		
			<div class="container" style="margin: 10.5rem auto;">
				
				<!-- 탭방식 네비게이션 -->
				<div class="d-flex align-items-start" style="justify-content: center;">
				  <div class="nav flex-column nav-pills me-3" id="v-pills-tab" role="tablist" aria-orientation="vertical" style="background: #e1e8e1;">
				    <button class="nav-link active" id="v-pills-home-tab" data-bs-toggle="pill" data-bs-target="#v-pills-home" type="button" role="tab" aria-controls="v-pills-home" aria-selected="true">프로필</button>
				    <button class="nav-link" id="v-pills-profile-tab" data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab" aria-controls="v-pills-profile" aria-selected="false">프로필수정</button>
				  </div>
				  <div class="tab-content" id="v-pills-tabContent">
				  	<!-- 프로필 -->
				    <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab">
					    <main class="form-signin" style="min-height:380px; padding:50px;">
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
				    <!-- 사용자 정보 수정 -->
				    <div class="tab-pane fade" id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab">
					    <main class="form-signin" style="min-height:380px; padding:50px;">
								<s:authorize access="isAuthenticated()">
									
									<h2 class="mb-4">비밀번호 변경</h2>

									<div class="mb-3">
									  <label for="exampleFormControlInput1" class="form-label">현재 비밀번호</label>
									  <input type="password" class="form-control currentPassword" id="exampleFormControlInput1" placeholder="현재 비밀번호">
									</div>
									
									<div class="btn btn-success currentPasswordCheck" style="display:block;">확인</div>

									<div id="changePasswordBox">
										<div class="mb-2">
										  <label for="exampleFormControlInput1" class="form-label">바꿀 비밀번호</label>
										  <input type="email" class="form-control" id="exampleFormControlInput1" placeholder="바꿀 비밀번호">
										</div>
										
										<div class="mb-2">
										  <input type="email" class="form-control" placeholder="비밀번호 중복 체크">
										</div>			
										
										<div class="btn btn-warning">비밀번호 변경</div>
									</div>
									
									<hr>						
									
									<h2 class="mb-4">회원 탈퇴</h2>
									<form id="form2" name="form2" action="/user/cancleAccount" method="post">
										<div class="btn btn-danger" style="display:block !important;" onClick="cancleAccount()">회원탈퇴</div>
									</form>
								</s:authorize>
							</main>				    
				    </div>
				    
				  </div>
				</div>
			
				
			</div>

			<%@ include file="../include/footer.jsp" %>
        </div>
    </div>

    <div class="overlay"></div>

</body>

</html>