<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- 태그 라이브러리 선언 -->
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 
uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="s"%>
<!-- 컨텍스트 패스 설정 -->
<c:set var="path" value="${pageContext.request.contextPath}"/>

<script type="text/javascript">
//네비게이션 메뉴
document.addEventListener("DOMContentLoaded", function(){
	
	el_autohide = document.querySelector('.autohide');
	
	// add padding-top to bady (if necessary)
	navbar_height = document.querySelector('.navbar').offsetHeight;
	document.body.style.paddingTop = navbar_height + 'px';

	if(el_autohide){
		
		var last_scroll_top = 0;
		window.addEventListener('scroll', function() {
       		let scroll_top = window.scrollY;
	       if(scroll_top < last_scroll_top) {
	            el_autohide.classList.remove('scrolled-down');
	            el_autohide.classList.add('scrolled-up');
	        }
	        else {
	            el_autohide.classList.remove('scrolled-up');
	            el_autohide.classList.add('scrolled-down');
	        }
	        last_scroll_top = scroll_top;

		}); 
		// window.addEventListener

	}
	// if
	
}); 
// DOMContentLoaded  end

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

<style type="text/css">
.autohide{
	position: fixed;
    top: 0;
    right: 0;
    left: 0;
    width: 100%;
    z-index: 1030;
}
.scrolled-down{
	transform:translateY(-100%); transition: all 0.3s ease-in-out;
}
.scrolled-up{
	transform:translateY(0); transition: all 0.3s ease-in-out;
}
.dropdown-toggle::after {
	content: none !important;

}
.rounded-circle {
	border: 2px solid lightgray !important;
}
.dropdown-menu[data-bs-popper] {
	left: -126px;
}
</style>

<!-- ============= COMPONENT ============== -->
<nav class="autohide navbar navbar-expand-lg" style="box-shadow:1px 1px 1px #e8dada; background:white;">
 <div class="container" style="max-width: 960px">
 	<a class="navbar-brand" href="/">개드립</a>
 	
 	<a class="navbar-brand" href="/board/list">리스트</a>
    
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
	        <a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" id="dropdownUser2" data-bs-toggle="dropdown" aria-expanded="false">
	          <img src="https://github.com/mdo.png" alt="mdo" width="32" height="32" class="rounded-circle">
	        </a>
	        <ul class="dropdown-menu text-small shadow" aria-labelledby="dropdownUser2">
	          <li><a class="dropdown-item profile">내정보</a></li>
	          <li><a class="dropdown-item">설정</a></li>
	          <li><hr class="dropdown-divider"></li>
	          <li>
	          	<a class="dropdown-item logout">로그아웃</a>
	          </li>
	        </ul>
     	</div>
     </s:authorize>
 </div> <!-- container-fluid.// -->
</nav>
<!-- ============= COMPONENT END// ============== -->   

