<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Sidebar  -->
<nav id="sidebar" style="background: #2873e252 !important;">
    <div id="dismiss">
        <i class="fas fa-arrow-left"></i>
    </div>

    <div class="sidebar-header">
        <h3>Bootstrap Sidebar</h3>
    </div>

    <ul class="list-unstyled components">
        <p>Dummy Heading</p>
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
            <a href="${path}/board/list">전체 게시글</a>
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

    <ul class="list-unstyled CTAs">
        <li>
            <a href="#" class="download">로그인</a>
        </li>
        <li>
            <a href="#" class="article">회원가입</a>
        </li>
    </ul>
</nav>