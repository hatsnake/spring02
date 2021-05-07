<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>    
<title>ShareHappy</title>  
  
<style type="text/css">
	.rounded-circle {
		border: 2px solid lightgray !important;
	}
	.dropdown-menu[data-bs-popper] {
		left: -126px;
	}
	#sidebar ul li.active>a, a[aria-expanded="true"]:not('.not') {
		color: transparent !important;
		background:transparent !important;
	}

	body {
		font-family: 'Nanum Gothic', sans-serif;
	}
	.dropdown-toggle::after {
		content: none !important;
	}
</style>

<script type="text/javascript">
//버튼 클릭 이동
$(document).ready(function(){
	$('.logout').on('click', function() {
		alert('로그아웃');
		location.href='${path}/user/logout';
	});

	$('.login').on('click', function() {
		location.href='${path}/user/login';
	});

	$('.join').on('click', function() {
		location.href='${path}/user/join';
	});

	$('.profile').on('click', function() {
		location.href='${path}/user/profile';
	});	
});
</script>

<header class="navbar navbar-expand-lg navbar-light" style="background: #7386D5;">
	<div class="container">
	
		<button type="button" id="sidebarCollapse" class="btn" style="background:#a1a0e8;">
			<i class="fas fa-align-left"></i>
		</button>

		<a href="/">
			<div style="font-size:2rem; margin-left:1rem;">
				S<span style="font-size:0.5em;">hare</span>
				H<span style="font-size:0.5em;">appy</span>
			</div>
		</a>

    <!-- 비로그인 상태 -->
    <s:authorize access="isAnonymous()">
	    <div class="flex-shrink-0">
				<button type="button" class="btn btn-success login">로그인</button>
				<!-- <button type="button" class="btn btn-default join">회원가입</button> -->
			</div>
		</s:authorize>
		
		<!-- 관리자 로그인 상태 -->
	    <s:authorize access="hasRole('admin')">
			관리자 로그인
		</s:authorize>		

		<!-- 로그인 상태 -->	
		<s:authorize access="isAuthenticated()">
			<div class="flex-shrink-0 dropdown">
				<span href="#" class="d-block link-dark text-decoration-none dropdown-toggle" id="dropdownUser2" data-bs-toggle="dropdown" aria-expanded="false">
					<img src="https://github.com/mdo.png" alt="mdo" width="32" height="32" class="rounded-circle">
				</span>
				<ul class="dropdown-menu text-small shadow" aria-labelledby="dropdownUser2">
					<s:authentication property="principal" var="user"/>
					<li><span class="dropdown-item">${user.username}</a></li>
					<li><hr class="dropdown-divider"></li>
					<li><a class="dropdown-item profile">내정보</a></li>
					<li><a class="dropdown-item">설정</a></li>
					<li><hr class="dropdown-divider"></li>
					<li>
						<a class="dropdown-item logout">로그아웃</a>
					</li>
				</ul>
			</div>
		</s:authorize>
		
	</div>
</header>