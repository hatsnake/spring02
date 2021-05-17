<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../include/subpages/utils.jsp" %>

<style>
#mail_check_input_box_false{
    background-color:#ebebe4;
}
 
#mail_check_input_box_true{
    background-color:#66d432;
}
.correct{
    color : #66d432;
}
.incorrect{
    color : #ebebe4;
}
.label-style {
  color: #888888;
  font-size: 15px;;
}
</style>

<script>
	var code = "";
	var userid_check = false;
	var passwd_check = false;
	var passwd_check2 = false;
	var	name_check = false;
	var email_check = false;
	var email_able = false;

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
					email_able = true;
				} else {
					email_able = false;
				}
			} else {
				email_able = false;
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
</script>

<body class="g-sidenav-show   bg-gray-100">
  <%@ include file="../include/subpages/sidebar.jsp" %>

  <main class="main-content mt-1 border-radius-lg">
    <%@ include file="../include/subpages/header.jsp" %>

    <div class="container-fluid py-4">

      <!-- CONTENTS -->
      <div class="row">
        
        <div class="col-12 col-sm-12 col-md-6 col-lg-5 col-xl-4" style="margin:0 auto;">
          <div class="card h-100">
            <div class="card-header pb-0 p-3">
              <div class="row">
                <div class="col-md-8 d-flex align-items-center">
                  <h4 class="mb-0">회원 가입</h6>
                </div>
              </div>
            </div>
            <div class="card-body p-3">
              <form class="needs-validation" action="${path}/user/insertUser" id="form1" method="post" novalidate>
                <div class="form-floating mb-4">
                  <input type="text" name="userid" class="form-control userid" id="userid_input" placeholder="아이디" value="${userid}" required>
                  <label for="floatingInput" class="label-style">아이디</label>
                  <div class="valid-feedback" id="userid_success"></div>
                  <div class="invalid-feedback" id="userid_fail"></div>
                </div>

                <div class="form-floating mb-2">
                  <input type="password" name="passwd" class="form-control passwd" id="passwd_input" placeholder="비밀번호" value="${passwd}" required>
                  <label for="floatingPassword" class="label-style">비밀번호</label>
                  <div class="valid-feedback" id="passwd_success">사용할 수 있는 비밀번호입니다.</div>
                  <div class="invalid-feedback" id="passwd_fail">사용할 수 없는 비밀번호입니다.</div>
                </div> 

                <div class="form-floating mb-4">
                  <input type="password" name="passwd2" class="form-control passwd" id="passwd2_input" placeholder="비밀번호 확인" required>
                  <label for="floatingPassword" class="label-style">비밀번호 확인</label>
                  <div class="valid-feedback" id="passwd2_success">비밀번호가 같습니다.</div>
                  <div class="invalid-feedback" id="passwd2_fail">비밀번호가 다릅니다.</div>
                </div>

                <div class="form-floating mb-4">
                  <input type="text" name="name" class="form-control userid" id="name_input" placeholder="이름" value="${name}" required>
                  <label for="floatingInput" class="label-style">이름</label>
                  <div class="valid-feedback" id="name_success">사용할 수 있는 이름입니다.</div>
                  <div class="invalid-feedback" id="name_fail">사용할 수 없는 이름입니다.</div>
                </div>

                <!-- 이메일 테스트 -->
                <div class="mail_wrap mb-4">
                
                  <div class="input-group mail_input_box mb-2">
                    <input type="email" name="email" class="form-control email mail_input"  id="email_input" placeholder="이메일" value="${email}" aria-describedby="button-addon1" required>
                    <div class="btn btn-success mb-0 mail_check_button" id="button-addon1">
                    	<span class="mail_button">인증번호 전송</span>
                    </div>
                  </div>
                  
                  <div class="mail_check_wrap">
                    <div class="mail_check_input_box" id="mail_check_input_box_false">
                      <input type="text" class="form-control mail_check_input" disabled="disabled">
                    </div>
                    <span id="mail_check_input_box_warn"></span>
                  </div>
                  
                </div>
                
                <s:csrfInput />
             </form>

             <button class="w-100 btn btn-md btn-info mb-2" id="join_button" type="button">회원가입</button>
             <hr>
             <div> 
              이미 회원이신가요? <a href="${path}/user/login" style="text-decoration: underline; color:royalblue;">로그인</a>하기
             </div>
            </div>
          </div>
        </div>
        
        
      </div>

      <!-- END CONTENTS -->  

      <%@ include file="../include/subpages/footer.jsp" %>

    </div>

  </main>
  <div class="fixed-plugin">
    <a class="fixed-plugin-button text-dark position-fixed px-3 py-2">
      <i class="fa fa-cog py-2"> </i>
    </a>
    <div class="card shadow-lg ">
      <div class="card-header pb-0 pt-3 ">
        <div class="float-start">
          <h5 class="mt-3 mb-0">Soft UI Configurator</h5>
          <p>See our dashboard options.</p>
        </div>
        <div class="float-end mt-4">
          <button class="btn btn-link text-dark p-0 fixed-plugin-close-button">
            <i class="fa fa-close"></i>
          </button>
        </div>
        <!-- End Toggle Button -->
      </div>
      <hr class="horizontal dark my-1">
      <div class="card-body pt-sm-3 pt-0">
        <!-- Sidebar Backgrounds -->
        <div>
          <h6 class="mb-0">Sidebar Colors</h6>
        </div>
        <a href="javascript:void(0)" class="switch-trigger background-color">
          <div class="badge-colors my-2 text-start">
            <span class="badge filter bg-gradient-primary active" data-color="primary" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-dark" data-color="dark" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-info" data-color="info" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-success" data-color="success" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-warning" data-color="warning" onclick="sidebarColor(this)"></span>
            <span class="badge filter bg-gradient-danger" data-color="danger" onclick="sidebarColor(this)"></span>
          </div>
        </a>
        <!-- Sidenav Type -->
        <div class="mt-3">
          <h6 class="mb-0">Sidenav Type</h6>
          <p class="text-sm">Choose between 2 different sidenav types.</p>
        </div>
        <div class="d-flex">
          <button class="btn bg-gradient-primary w-100 px-3 mb-2 active" data-class="bg-transparent" onclick="sidebarType(this)">Transparent</button>
          <button class="btn bg-gradient-primary w-100 px-3 mb-2 ms-2" data-class="bg-white" onclick="sidebarType(this)">White</button>
        </div>
        <p class="text-sm d-xl-none d-block mt-2">You can change the sidenav type just on desktop view.</p>
        <!-- Navbar Fixed -->
        <div class="mt-3">
          <h6 class="mb-0">Navbar Fixed</h6>
        </div>
        <div class="form-check form-switch ps-0">
          <input class="form-check-input mt-1 ms-auto" type="checkbox" id="navbarFixed" onclick="navbarFixed(this)">
        </div>
        <hr class="horizontal dark my-sm-4">
        <a class="btn bg-gradient-dark w-100" href="https://www.creative-tim.com/product/soft-ui-dashboard">Free download</a>
        <a class="btn btn-outline-dark w-100" href="https://www.creative-tim.com/learning-lab/bootstrap/license/soft-ui-dashboard">View documentation</a>
        <div class="w-100 text-center">
          <a class="github-button" href="https://github.com/creativetimofficial/soft-ui-dashboard" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star creativetimofficial/soft-ui-dashboard on GitHub">Star</a>
          <h6 class="mt-3">Thank you for sharing!</h6>
          <a href="https://twitter.com/intent/tweet?text=Check%20Soft%20UI%20Dashboard%20made%20by%20%40CreativeTim%20%23webdesign%20%23dashboard%20%23bootstrap5&amp;url=https%3A%2F%2Fwww.creative-tim.com%2Fproduct%2Fsoft-ui-dashboard" class="btn btn-dark mb-0 me-2" target="_blank">
            <i class="fab fa-twitter me-1" aria-hidden="true"></i> Tweet
          </a>
          <a href="https://www.facebook.com/sharer/sharer.php?u=https://www.creative-tim.com/product/soft-ui-dashboard" class="btn btn-dark mb-0 me-2" target="_blank">
            <i class="fab fa-facebook-square me-1" aria-hidden="true"></i> Share
          </a>
        </div>
      </div>
    </div>
  </div>

  <%@ include file="../include/subpages/footerScript.jsp" %>
  
</body>

</html>