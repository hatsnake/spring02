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
	max-width:600px;
	height:80px;
	border:1px solid gray;
	background-color:gray;
}
.img-size {
	max-width:80px;
	max-height:80px;
}
</style>

<script type="text/javascript" src="/resources/js/common.js"></script>

<script type="text/javascript">
$(document).ready(function() {

	//첨부파일 목록 불러오기 함수 호출
	listAttach();

	//첨부파일 추가 ajax요청
	$(".fileDrop").on("dragenter dragover", function(e) {
		e.preventDefault(); //기본효과를 막음
	});

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

	//첨부파일 삭제 ajax요청
	//태그.on("이벤트", "자손태그", 이벤트 핸들러)
	$("#uploadedList").on("click", ".fileDel", function(e) {
		var that = $(this); //클릭한 a태그
		$.ajax({
			type: "post",
			url: "${path}/upload/deleteFile",
			data: {fileName: $(this).attr("data-src")},
			dataType: "text",
			success: function(result) {
				that.parent("div").remove();
			}
		});
	});

	//게시글 수정 처리
	$(".updateCheck").on("click", function() {
		var title = $(".title").val();
		var content = $(".content").val();
		if(title == "") {
			alert("제목을 입력하세요");
			document.form1.title.focus();
			return;
		}
		
		if(content == "") {
			alert("내용을 입력하세요");
			document.form1.content.focus();
			return;
		}	
		document.form1.action="${path}/board/update";
		//첨부파일 이름을 form에 추가
		var that = $("#form1");
		var str = "";
		//태그들.each(함수)
		//id가 uploadedList인 태그 내부에 있는 hidden태그들
		$("#uploadedList .file").each(function(i) {
			str += "<input type='hidden' name='files["+i+"]' value='"+$(this).val()+"'>";
		});
		//form에 hidden태그들을 추가
		$("#form1").append(str);
		
		document.form1.submit();
	});
	
});

//첨부파일 목록 ajax요청 처리
function listAttach() {
	$.ajax({
		type: "post",
		url: "${path}/board/getAttach/${dto.bno}",
		success: function(list) {
			console.log(list);
			$(list).each(function(){
				//each문 내부의 this : 각 step에 해당되는 값을 의미
				var fileInfo = getFileInfo(this);
				//a태그안에는 파일의 링크를 걸어주고, 목록에는 파일의 이름 출력
				var html = "<div class='m-2'><img class='img-size' src='"+fileInfo.getLink+"'>&nbsp;&nbsp;";
				html += "<a href='"+fileInfo.getLink+"'>"+fileInfo.fileName+"</a>&nbsp;&nbsp;";
				//삭제 버튼
				html += "<a href='#' class='fileDel' data-src='"+this+"'>[삭제]</a></div>";
				$("#uploadedList").append(html);
			});
		}
	});
}

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
					<form name="form1" method="post"  enctype="multipart/form-data">
						<!--  
							<img class="mb-4" src="/docs/5.0/assets/brand/bootstrap-logo.svg" alt="" width="72" height="57">
						-->
						<h1 class="h3 mb-3 fw-normal text-center">게시글 수정</h1>
						<!--
							<span style="color:red;">${errMsg}</span>
						-->
				
						<div class="mb-3">
							<label for="exampleFormControlInput1" class="form-label">게시글 제목</label>
							<input type="text" name="title" class="title form-control" size="80" placeholder="게시글 제목" value="${dto.title}">
						</div>
						<div class="mb-3">
							<label for="exampleFormControlInput1" class="form-label">글쓴이</label><br>
							<span style="margin-left:5px;">${dto.writer}</span>
							<input type="hidden" name="writer" class="writer" value="${dto.writer}">
						</div>
						<div class="mb-3">
							<label for="exampleFormControlTextarea1" class="form-label">게시글 내용</label>
							<textarea name="content" class="content form-control" rows="4" cols="80" placeholder="게시글 내용">${dto.content}</textarea>
						</div>
						
						<!-- 첨부파일 목록 -->
						<div>
							첨부파일
							<div id="uploadedList"></div>
						</div>
						<!-- 첨부파일 드래그 영역 -->
						<div class="fileDrop"></div>
						
						<input type="hidden" name="bno" id="bno" value="${dto.bno}">
						<button class="w-100 btn btn-md btn-secondary mb-2 updateCheck" type="button">수정</button>
						<!-- 취소는 뒤로가기로 바꾸기 --> 
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