<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<%@ include file="../include/util.jsp" %>

<link rel="stylesheet" href="/resources/css/formsign.css">
<script>
var email_able = false;

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

  /* 인증번호 이메일 전송 */
  $(".mail_check_button").click(function(){
	 		emailRegex();
	  
			if(email_able) {
	      var email = $(".mail_input").val();        // 입력한 이메일
	      var checkBox = $(".mail_check_input");      // 인증번호 입력란
	      var boxWrap = $(".mail_check_input_box");		// 인증번호 입력란 박스
	      var mail_button = $(".mail_button");
	      $.ajax({
	          type:"GET",
	          url:"/mailCheck?email=" + email,
	          beforeSend:function() {
							mail_button.html("<span class='spinner-border spinner-border-sm'></span>");
		        },
	          success:function(data) {
		          alert("이메일이 전송되었습니다. 확인해주세요.");
		          mail_button.html("인증번호 전송");
							checkBox.attr("disabled", false);
							boxWrap.attr("id", "mail_check_input_box_true");
							code = data;
		        }      
	      });
			} else {
				alert("보낼 수 있는 이메일이 아닙니다. 확인해주세요.");
			}
  });

  /* 인증번호 비교 */
  $(".mail_check_input").on("blur propertychange change keyup paste input", function(){
    var inputCode = $(".mail_check_input").val();        // 입력코드    
    var checkResult = $("#mail_check_input_box_warn");    // 비교 결과
		var mailButton = $(".mail_button");
    if(inputCode == code){                            // 일치할 경우
        checkResult.html("인증번호가 일치합니다.");
        checkResult.attr("class", "correct");    
        email_check = true;  
    } else {                                          // 일치하지 않을 경우
        checkResult.html("인증번호를 다시 확인해주세요.");
        checkResult.attr("class", "incorrect");
        email_check = false;
    }   
    
  });
	
});

function cancleAccount() {
	if(window.confirm("정말 회원탈퇴하시겠습니까?")) {
		$("#form2").submit();
		return false;
	};
}

function emailRegex() {
  var email = "${email}";
	
	var emailRegex = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var emailCheck = emailRegex.test(email);

	if(email != "") {
		if(emailCheck) {
			email_able = true;
		} else {
			email_able = false;
		}
	} else {
		email_able = false;
	}
}
</script>
<style>
#changePasswordBox {
	display:none;
}
#mail_check_input_box_false{
    background-color:#ebebe4;
}
 
#mail_check_input_box_true{
    background-color:white;
}
.correct{
    color : green;
}
.incorrect{
    color : red;
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

									<!-- 이메일 테스트 -->
									<div class="mail_wrap">
									
										<div class="input-group mail_input_box mb-2">
											
											<input type="email" name="email" class="form-control email mail_input"  id="email_input" placeholder="이메일" value="${email}" style="float:left;" required disabled>
											<div class="mail_check_button" style="float:left;">
												<span class="btn btn-success mail_button">인증번호 전송</span>
											</div>
											<div class="clearfix"></div>
										</div>
										
										<div class="mail_check_wrap">
											<div class="mail_check_input_box" id="mail_check_input_box_false">
												<input type="text" class="form-control mail_check_input" disabled="disabled">
											</div>
											<span id="mail_check_input_box_warn"></span>
										</div>
										
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