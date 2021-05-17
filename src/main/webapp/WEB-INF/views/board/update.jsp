<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

  <script>
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
          //첨부 파일의 정보
          var fileInfo = getFileInfo(data);

          if(checkImageType(data)) {
            //하이퍼링크
            var html = "<div class='m-2'><img class='img-size' src='"+fileInfo.getLink+"'>&nbsp;&nbsp;";
            html += "<a href='"+fileInfo.getLink+"'>"+fileInfo.fileName+"</a><br>";
            //hidden 태그 추가
            html += "<input type='hidden' name='files' class='file' value='"+fileInfo.fullName+"'>";
          } else {
            var html = "<div class='m-2'><a href='"+fileInfo.getLink+"'><i class='fas fa-archive'></i>"+fileInfo.fileName+"</a><br>";
            //hidden 태그 추가
            html += "<input type='hidden' name='files' class='file' value='"+fileInfo.fullName+"'>";
          }
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

          if(checkImageType(this)) {
            //a태그안에는 파일의 링크를 걸어주고, 목록에는 파일의 이름 출력
            var html = "<div class='m-2'><img class='img-size' src='"+fileInfo.getLink+"'>&nbsp;&nbsp;";
            html += "<a href='"+fileInfo.getLink+"'>"+fileInfo.fileName+"</a>&nbsp;&nbsp;";
            //삭제 버튼
            html += "<a href='#' class='fileDel' data-src='"+this+"'>[삭제]</a></div>";
          } else {
            //a태그안에는 파일의 링크를 걸어주고, 목록에는 파일의 이름 출력
            var html = "<div class='m-2'><a href='"+fileInfo.getLink+"'><i class='fas fa-archive'></i>"+fileInfo.fileName+"</a>&nbsp;&nbsp;";
            //삭제 버튼
            html += "<a href='#' class='fileDel' data-src='"+this+"'>[삭제]</a></div>";
          }
          $("#uploadedList").append(html);
        });
      }
    });
  }

  </script>    
    
<%@ include file="../include/subpages/utils.jsp" %>

<body class="g-sidenav-show   bg-gray-100">
  <%@ include file="../include/subpages/sidebar.jsp" %>

  <main class="main-content mt-1 border-radius-lg">
    <%@ include file="../include/subpages/header.jsp" %>

    <div class="container-fluid py-4">

      <!-- CONTENTS -->
      <div class="col-12 col-sm-12 col-md-8 col-lg-6 col-xl-6" style="margin:0 auto;">
        <div class="card h-100">
		      <form name="form1" method="post" enctype="multipart/form-data">
		        <!--  
		          <img class="mb-4" src="/docs/5.0/assets/brand/bootstrap-logo.svg" alt="" width="72" height="57">
		        -->
		        <h1 class="h3 mb-3 fw-normal text-center">게시글 수정</h1>
		        <!--
		          <span style="color:red;">${errMsg}</span>
		        -->
		    
		        <div class="mb-3 ms-3 me-3">
		          <select id="category" name="categoryid" class="form-select" aria-label="Default select example">
		            <c:forEach var="category" items="${getCategoryList}">
		              <option value="${category.categoryid}" 
		              <c:if test="${category.categoryid == dto.categoryid}">selected</c:if>
		              >${category.categoryname}</option>
		            </c:forEach>
		          </select>
		        </div>
		    
		        <div class="mb-3 ms-3 me-3">
		          <label for="exampleFormControlInput1" class="form-label">게시글 제목</label>
		          <input type="text" name="title" class="title form-control" size="80" placeholder="게시글 제목" value="${dto.title}">
		        </div>
		        <div class="mb-3 ms-3 me-3">
		          <label for="exampleFormControlInput1" class="form-label">글쓴이</label><br>
		          <span style="margin-left:5px;">${dto.writer}</span>
		          <input type="hidden" name="writer" class="writer" value="${dto.writer}">
		        </div>
		        <div class="mb-3 ms-3 me-3">
		          <label for="exampleFormControlTextarea1" class="form-label">게시글 내용</label>
		          <textarea name="content" class="content form-control" rows="4" cols="80" placeholder="게시글 내용">${dto.content}</textarea>
		        </div>
		        
		        <!-- 첨부파일 목록 -->
		        <div class="ms-3 me-3">
		          첨부파일
		          <div id="uploadedList"></div>
		        </div>
		        <!-- 첨부파일 드래그 영역 -->
		        <div class="fileDrop"></div>
		        
		        <input type="hidden" name="bno" id="bno" value="${dto.bno}">
		        <button class="w-100 btn btn-md btn-secondary mb-2 updateCheck ms-3 me-3" type="button">수정</button>
						
		      </form>      
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