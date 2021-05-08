<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/util.jsp" %>

<link rel="stylesheet" href="/resources/css/formsign.css">
<style>
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

<script>
	var code = "";
	var userid_check = false;
	var passwd_check = false;
	var passwd_check2 = false;
	var	name_check = false;
	var email_check = false;

	$(document).ready(function() {
	
		//아이디 체크 (빈값, 아이디중복, 정해진문자와 범위 정규식)
		$("#userid_input").on("propertychange change keyup paste input", function() {
			var userid = $("#userid_input").val();

			var useridRegex = /^[a-zA-Z0-9]{5,20}$/;
			var useridCheck = useridRegex.test(userid);
			
			if(userid != "") {
				var data = {userid : userid};
	
				$.ajax({
					type:"post",
					url:"/user/useridCheck",
					data: data,
					success: function(result) {
						if(result == 'success' && useridCheck) {
							userid_check = true;
							$("#userid_input").removeClass('is-valid');
							$("#userid_input").removeClass('is-invalid');
							$("#userid_input").addClass('is-valid');
							$("#userid_success").text("사용가능한 아이디입니다.");			
						} else if(result == 'fail' || useridCheck == false) {
							userid_check = false;
							$("#userid_input").removeClass('is-valid');
							$("#userid_input").removeClass('is-invalid');
							$("#userid_input").addClass('is-invalid');
							$("#userid_fail").text("이미 존재하거나 틀린 아이디입니다.");							
						}
						
					}
				});
			} else {
				$("#userid_input").removeClass('is-valid');
				$("#userid_input").removeClass('is-invalid');
				userid_check = false;
			}
			
		});

		//비밀번호 체크
		$("#passwd_input").on("propertychange change keyup paste input", function() {
			var passwd = $("#passwd_input").val().toUpperCase();
			var passwd2 = $("#passwd2_input").val().toUpperCase();

			var passwdRegex = /^[a-zA-Z0-9!@#$%^&*()?_~]{8,20}$/;
			var passwdCheck = passwdRegex.test(passwd);

			if(passwd != "") {
				if(passwdCheck) {
					passwd_check2 = true;
					$("#passwd_input").removeClass('is-valid');
					$("#passwd_input").removeClass('is-invalid');
					$("#passwd_input").addClass('is-valid');	
				} else {
					passwd_check2 = false;
					$("#passwd_input").removeClass('is-valid');
					$("#passwd_input").removeClass('is-invalid');
					$("#passwd_input").addClass('is-invalid');	
				}
			} else {
				passwd_check2 = false;
				$("#passwd_input").removeClass('is-valid');
				$("#passwd_input").removeClass('is-invalid');
			}

			checkPassword(passwd, passwd2);
		});

		//비밀번호 같은지 체크
		$("#passwd2_input").on("propertychange change keyup paste input", function() {
			var passwd = $("#passwd_input").val().toUpperCase();
			var passwd2 = $("#passwd2_input").val().toUpperCase();

			if(passwd != "" && passwd2 != "") {
				if(passwd == passwd2) {
					$("#passwd2_input").removeClass('is-valid');
					$("#passwd2_input").removeClass('is-invalid');
					$("#passwd2_input").addClass('is-valid');	
					passwd_check = true;			
				} else {
					$("#passwd2_input").removeClass('is-valid');
					$("#passwd2_input").removeClass('is-invalid');
					$("#passwd2_input").addClass('is-invalid');	
					passwd_check = false;	
				}
			} else if(passwd2 == "") {
				$("#passwd2_input").removeClass('is-valid');
				$("#passwd2_input").removeClass('is-invalid');
				passwd_check = false;	
			}
			
		});
		
		function checkPassword(passwd, passwd2) {
	
				if(passwd != "" && passwd2 != "") {
					if(passwd == passwd2) {
						$("#passwd2_input").removeClass('is-valid');
						$("#passwd2_input").removeClass('is-invalid');
						$("#passwd2_input").addClass('is-valid');	
						passwd_check = true;			
					} else {
						$("#passwd2_input").removeClass('is-valid');
						$("#passwd2_input").removeClass('is-invalid');
						$("#passwd2_input").addClass('is-invalid');	
						passwd_check = false;	
					}
				} else if(passwd2 == "") {
					$("#passwd2_input").removeClass('is-valid');
					$("#passwd2_input").removeClass('is-invalid');
					passwd_check = false;	
				}
				
		}
		
		//이름
		$("#name_input").on("propertychange change keyup paste input", function() {
			var name = $("#name_input").val();

			var nameRegex = /^[a-zA-Z가-힣]{2,20}$/;
			var nameCheck = nameRegex.test(name);

			if(name != "") {
				if(nameCheck) {
					name_check = true;
					$("#name_input").removeClass('is-valid');
					$("#name_input").removeClass('is-invalid');
					$("#name_input").addClass('is-valid');	
				} else {
					name_check = false;
					$("#name_input").removeClass('is-valid');
					$("#name_input").removeClass('is-invalid');
					$("#name_input").addClass('is-invalid');				
				}
			} else {
				name_check = false;
				$("#name_input").removeClass('is-valid');
				$("#name_input").removeClass('is-invalid');
			}
			
		});

		//이메일
		$("#email_input").on("propertychange change keyup paste input", function() {
			var email = $("#email_input").val();

			var emailRegex = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			var emailCheck = emailRegex.test(email);

			if(email != "") {
				if(emailCheck) {
					email_check = true;
					$("#email_input").removeClass('is-valid');
					$("#email_input").removeClass('is-invalid');
					$("#email_input").addClass('is-valid');	
				} else {
					email_check = false;
					$("#email_input").removeClass('is-valid');
					$("#email_input").removeClass('is-invalid');
					$("#email_input").addClass('is-invalid');		
				}
			} else {
				email_check = false;
				$("#email_input").removeClass('is-valid');
				$("#email_input").removeClass('is-invalid');
			}
			
		});

	  $("#join_button").on("click", function(event) {
			if(userid_check && passwd_check && passwd_check2 && name_check && email_check) {
				alert("회원가입에 성공하셨습니다.");
				$("#form1").submit();
			} else {
				alert("회원가입에 실패하셨습니다. 틀린곳이 있는지 확인해주세요.");
			}
		});

	  /* 인증번호 이메일 전송 */
	  $(".mail_check_button").click(function(){
	      var email = $(".mail_input").val();        // 입력한 이메일
	      var checkBox = $(".mail_check_input");      // 인증번호 입력란
	      var boxWrap = $(".mail_check_input_box");		// 인증번호 입력란 박스
	      $.ajax({
	          type:"GET",
	          url:"/mailCheck?email=" + email,
	          success:function(data) {
							checkBox.attr("disabled", false);
							boxWrap.attr("id", "mail_check_input_box_true");
							code = data;
		        }      
	      });
	  });

	  /* 인증번호 비교 */
	  $(".mail_check_input").blur(function(){
	    var inputCode = $(".mail_check_input").val();        // 입력코드    
	    var checkResult = $("#mail_check_input_box_warn");    // 비교 결과

	    if(inputCode == code){                            // 일치할 경우
	        checkResult.html("인증번호가 일치합니다.");
	        checkResult.attr("class", "correct");        
	    } else {                                          // 일치하지 않을 경우
	        checkResult.html("인증번호를 다시 확인해주세요.");
	        checkResult.attr("class", "incorrect");
	    }   
	    
	  });
	  
	});
</script>
</head>

<body>

    <div class="wrapper">
		<%@ include file="../include/sidebar.jsp" %>

        <!-- Page Content  -->
        <div id="content">

			<%@ include file="../include/header.jsp" %>
		
			<div class="container" style="margin: 10.5rem auto;">
				<main class="form-signin">
					<form class="needs-validation" action="${path}/user/insertUser" id="form1" method="post" novalidate>
						<!--  
							<img class="mb-4" src="/docs/5.0/assets/brand/bootstrap-logo.svg" alt="" width="72" height="57">
						-->
						<h1 class="h3 mb-3 fw-normal text-center">회원가입</h1>
						<!--
							<span style="color:red;">${errMsg}</span>
						-->
				
						<div class="form-floating mb-3">
							<input type="text" name="userid" class="form-control userid" id="userid_input" placeholder="아이디" value="${userid}" required>
							<label for="floatingInput">아이디</label>
							<div class="valid-feedback" id="userid_success"></div>
							<div class="invalid-feedback" id="userid_fail"></div>
						</div>
						
						<div class="form-floating mb-2">
							<input type="password" name="passwd" class="form-control passwd" id="passwd_input" placeholder="비밀번호" value="${passwd}" required>
							<label for="floatingPassword">비밀번호</label>
							<div class="valid-feedback" id="passwd_success">사용할 수 있는 비밀번호입니다.</div>
							<div class="invalid-feedback" id="passwd_fail">사용할 수 없는 비밀번호입니다.</div>
						</div>

						<div class="form-floating mb-3">
							<input type="password" name="passwd2" class="form-control passwd" id="passwd2_input" placeholder="비밀번호 확인" required>
							<label for="floatingPassword">비밀번호 확인</label>
							<div class="valid-feedback" id="passwd2_success">비밀번호가 같습니다.</div>
							<div class="invalid-feedback" id="passwd2_fail">비밀번호가 다릅니다.</div>
						</div>

						<div class="form-floating mb-3">
							<input type="text" name="name" class="form-control userid" id="name_input" placeholder="이름" value="${name}" required>
							<label for="floatingInput">이름</label>
							<div class="valid-feedback" id="name_success">사용할 수 있는 이름입니다.</div>
							<div class="invalid-feedback" id="name_fail">사용할 수 없는 이름입니다.</div>
						</div>

						<div class="form-floating mb-4">
							<input type="email" name="email" class="form-control email" id="email_input" placeholder="이메일" value="${email}" required>
							<label for="floatingInput">이메일</label>
							<div class="valid-feedback" id="email_success">사용할 수 있는 이메일입니다.</div>
							<div class="invalid-feedback" id="email_fail">사용할 수 있는 이메일입니다.</div>
						</div>
						
						<!-- 이메일 테스트 -->
						<div class="mail_wrap">
							<div class="mail_name">이메일</div>
							<div class="mail_input_box">
								<input class="mail_input" name="memberMail">
							</div>
							<div class="mail_check_wrap">
								<div class="mail_check_input_box" id="mail_check_input_box_false">
									<input class="mail_check_input" disabled="disabled" style="float:left;">
								</div>
								<div class="mail_check_button" style="float:left;">
									<span>인증번호 전송</span>
								</div>
								<div class="clearfix"></div>
								<span id="mail_check_input_box_warn"></span>
							</div>
						</div>
						
						<p class="mt-4 mb-3 text-muted"></p>
					</form>
					
					<button class="w-100 btn btn-md btn-primary mb-2" id="join_button" type="button">회원가입</button>
					<button class="w-100 btn btn-md btn-secondary mb-2" type="button" onclick="history.back()">나가기</button>
				</main>
			</div>

			<%@ include file="../include/footer.jsp" %>

        </div>
    </div>

    <div class="overlay"></div>
</body>
</html>