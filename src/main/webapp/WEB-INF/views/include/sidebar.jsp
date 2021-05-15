<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Sidebar  -->
<nav id="sidebar" style="background: #767fe4ad !important;">
    <div id="dismiss">
        <i class="fas fa-arrow-left"></i>
    </div>

    <div class="sidebar-header" style="background: #7386D5 !important;">
        <h3>SH</h3>
    </div>

    <ul class="list-unstyled components">
        <p>전체 게시판</p>
        <li>
       		<a href="${path}/board/list">전체 게시글</a>
        </li>
        <li>
            <a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false">Home&nbsp;▶</a>
            <ul class="collapse list-unstyled not" id="homeSubmenu">
                <li>
                    <a href="#">Home 1</a>
                </li>
                <li>
                    <a href="#">Home 2</a>
                </li>
                <li>
                    <a href="#">Home 3</a>
                </li>
            </ul>
        </li>
        <li> 
            <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false">Pages&nbsp;▶</a>
            <ul class="collapse list-unstyled not" id="pageSubmenu">
                <li>
                    <a href="#">Page 1</a>
                </li>
                <li>
                    <a href="#">Page 2</a>
                </li>
                <li>
                    <a href="#">Page 3</a>
                </li>
            </ul>
        </li>
        <li>
            <a href="#">Portfolio</a>
        </li>
        <li>
            <a href="#">Contact</a>
        </li>
    </ul>

	<s:authorize access="isAnonymous()">
	    <ul class="list-unstyled CTAs">
	        <li>
	            <a href="#" class="download login">로그인</a>
	        </li>
	        <li>
	            <a href="#" class="article join">회원가입</a>
	        </li>
	    </ul>
	</s:authorize>
	
	<s:authorize access="isAuthenticated()">
		<ul class="list-unstyled CTAs">
		    <li>
	            <a href="#" class="download logout">로그아웃</a>
	        </li>
	        <li>
	            <a href="#" class="article profile">프로필</a>
	        </li>
	    </ul>
	</s:authorize>
</nav>