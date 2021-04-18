<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
<%@ include file="../include/util.jsp" %>
<link rel="stylesheet" href="/resources/css/formsign.css">

<style type="text/css">
.form-signin {
	max-width: 760px !important;
}

.fileDrop {
	max-width: 600px;
	height: 70px;
	border: 2px dotted gray;
	background-color: gray;
}
</style>

<script type="text/javascript" src="/resources/js/common.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	
	$(".writeCheck").click(function() {
		var title = $(".title").val();
		var content = $(".content").val();
		var writer = $(".writer").val();
		
		if(title == "") {
			alert("제목을 입력해주세요");
			document.form1.title.focus();
			return;
		}
		if(content == "") {
			alert("제목을 입력해주세요");
			document.form1.content.focus();
			return;
		}
		if(writer == "") {
			alert("로그인이 필요합니다");
			return;
		}	
		document.form1.submit();			
	});	

	//드래그 관련 기본효과 방지
	$(".fileDrop").on("dragenter dragover", function(e) {
		e.preventDefault(); //기본효과를 막음
	});

	//드롭시 효과
	//event : jQuery의 이벤트
	//originalEvent : javascript의 이벤트
	$(".fileDrop").on("drop", function(e) {
		e.preventDefault(); //기본효과를 막음
		//드래그된 파일의 정보
		var files = e.originalEvent.dataTransfer.files;
		//첫번째 파일
		var file = files[0];

		//ajax로 전달할 폼 객체
		var formData = new FormData();
		//폼 객체에 파일추가, append("변수명", 값)
		formData.append("file", file);

		$.ajax({
			url: "${path}/upload/uploadAjax",
			type: "post",
			data: formData,
			//processData: true => get방식, false => post방식
			dataType: "text",
			//contentType: true => application/x-www-form-urlencoded,
			//             false => multipart/form-data
			processData: false,
			contentType: false,
			success: function(data) {
				console.log(data);
				//첨부 파일의 정보
				var fileInfo = getFileInfo(data);
				//하이퍼링크
				var html = "<a href='"+fileInfo.getLink+"'>"+fileInfo.fileName+"</a><br>";
				//hidden 태그 추가
				html += "<input type='hidden' name='files' class='file' value='"+fileInfo.fullName+"'>";
				// div에 추가
				$("#uploadedList").append(html);

			}
		});
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
					<form name="form1" method="post" action="${path}/board/insert" enctype="multipart/form-data">
						<!--  
							<img class="mb-4" src="/docs/5.0/assets/brand/bootstrap-logo.svg" alt="" width="72" height="57">
						-->
						<h1 class="h3 mb-3 fw-normal text-center">게시글 등록</h1>
						<!--
							<span style="color:red;">${errMsg}</span>
						-->
				
						<div class="mb-3">
							<label for="exampleFormControlInput1" class="form-label">게시글 제목</label>
							<input type="text" name="title" class="title form-control" size="80" placeholder="게시글 제목">
						</div>
						<div class="mb-3">
							<label for="exampleFormControlInput1" class="form-label">글쓴이</label><br>
							<span style="margin-left:5px;">${username}</span>
							<input type="hidden" name="writer" class="writer" value="${username}">
						</div>
						<div class="mb-3">
							<label for="exampleFormControlTextarea1" class="form-label">게시글 내용</label>
							<textarea name="content" class="content form-control" rows="4" cols="80" placeholder="게시글 내용"></textarea>
						</div>
						
						<!-- 파일 업로드 부분 -->
						<div class="fileDrop"></div>
						<div id="uploadedList"></div>
						
						<button class="w-100 btn btn-md btn-secondary mb-2 writeCheck" type="button">게시글 등록</button> 
						<button class="w-100 btn btn-md btn-secondary" type="reset">취소</button> 							
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