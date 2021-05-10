<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
<%@ include file="../include/util.jsp" %>

<style type="text/css">
	
	/* 댓글 CSS */
	body {
			font-family: 'Nanum Gothic Coding', monospace;
	}

	.card-no-border .card {
			border: 0px;
			border-radius: 4px;
			-webkit-box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.05);
			box-shadow: 0px 5px 20px rgba(0, 0, 0, 0.05)
	}

	.card-body {
			-ms-flex: 1 1 auto;
			flex: 1 1 auto;
			padding: 1.25rem
	}

	.comment-widgets .comment-row:hover {
			background: rgba(0, 0, 0, 0.02);
			cursor: pointer
	}

	.comment-widgets .comment-row {
			border-bottom: 1px solid rgba(120, 130, 140, 0.13);
			padding: 15px
	}

	.comment-text:hover {
			visibility: hidden
	}

	.comment-text:hover {
			visibility: visible
	}

	.label {
			padding: 3px 10px;
			line-height: 13px;
			color: #ffffff;
			font-weight: 400;
			border-radius: 4px;
			font-size: 75%
	}

	.round img {
			border-radius: 100%
	}

	.label-info {
			background-color: #1976d2
	}

	.label-success {
			background-color: green
	}

	.label-danger {
			background-color: #ef5350
	}

	.action-icons a {
			padding-left: 7px;
			vertical-align: middle;
			color: #99abb4
	}

	.action-icons a:hover {
			color: #1976d2
	}

	.mt-100 {
			margin-top: 100px
	}

	.mb-100 {
			margin-bottom: 100px
	}
	p.comment-text {
		font-size: 15px !important;
		line-height: 1.5em !important;
		color: #93939a;
	}
	.img-size {
		width:100%;
	}
</style>

<script type="text/javascript" src="/resources/js/common.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	
	listReplyRest('1');
	//listReply2();

	/*
	$(".replyCheck").on("click", function() {
		replyJson(); 
		//reply();
	});
	*/

	//첨부파일 목록 불러오기 함수 호출
	listAttach();

	//첨부파일 목록 ajax요청 처리
	function listAttach() {
		$.ajax({
			type: "post",
			url: "${path}/board/getAttach/${dto.bno}",
			success: function(list) {
				$(list).each(function(){
					//each문 내부의 this : 각 step에 해당되는 값을 의미
					var fileInfo = getFileInfo(this);

					if(checkImageType(this)) {
						//a태그안에는 파일의 링크를 걸어주고, 목록에는 파일의 이름 출력
						var html = "<div class='m-2'><img class='img-size' src='"+fileInfo.getLink+"'></div>";
						$("#uploadedList").append(html);
					}
				});
			}
		});
	}

	//게시글 삭제
	$(".delete").on("click", function() {
		//댓글이 존재하는 게시물의 삭제처리 방지
		var count = "${count}";
		//댓글의 수가 0보다 크면 팝업, 함수 종료
		if(count > 0) {
			alert("댓글이 있는 게시글은 삭제할 수 없습니다.");
			return;
		}
		if(confirm("삭제하시겠습니까?")) {
			document.form1.action = "${path}/board/delete";
			document.form1.submit();
		}
	});

	//게시글 수정 이동
	$(".update").on("click", function() {
		var bno = $("#bno").val();
		location.href="${path}/board/update?bno="+bno;
	});		

	//게시글 목록 이동 버튼이벤트
	$(".list").on("click", function() {
		location.href="${path}/board/list?curPage=${curPage}&searchOption=${searchOption}&keyword=${keyword}";
	});

	//종아요 & 싫어요 이벤트
	$(".like_button").on("click", function() {
		var userid = `${username}`;
		if(userid) {
			map = {
				"userid" : userid,
				"bno" : ${bno}
			};
			
			$.ajax({
				type: "post",
				url: "/board/clickLike",
				dataType: "json",
				data: map,
				error: function() {
					alert("에러발생");
				},
				success: function(result) {
					if(result.resultCode == -1) {
						alert("좋아요 오류");
					} else {
						if(result.likeCheck == 1) {
							console.log("좋아요 성공 : "+result.likeCnt);
							$(".like_cnt").text(result.likeCnt);
							$(".like_button").toggleClass("btn-primary").toggleClass("btn-secondary");
						} else if(result.likeCheck == 0) {
							console.log("좋아요 제거 : "+result.likeCnt);
							$(".like_cnt").text(result.likeCnt);
							$(".like_button").toggleClass("btn-primary").toggleClass("btn-secondary");
						}
					}
				}
			});
		} else {
			alert("로그인을 하셔야 좋아요를 누를 수 있습니다.");
		}
		
		/*
		var hate_button = $("#hate_button").hasClass("btn-primary");

		if(hate_button) {
			//싫어요버튼을 지우고 좋아요버튼을 활성화
			//좋아요
			$("#hate_button").toggleClass("btn-primary").toggleClass("btn-secondary");
			$("#like_button").toggleClass("btn-primary").toggleClass("btn-secondary");			
		} else {
			//종아요버튼을 활성화
			$("#like_button").toggleClass("btn-primary").toggleClass("btn-secondary");	
		}
		*/
		
	});

	/*
	$("#hate_button").on("click", function() {
		var like_button = $("#like_button").hasClass("btn-primary");

		if(like_button) {
			//좋아요버튼을 지우고 싫어요버튼을 활성화
			$("#hate_button").toggleClass("btn-primary").toggleClass("btn-secondary");
			$("#like_button").toggleClass("btn-primary").toggleClass("btn-secondary");			
		} else {
			//싫어요버튼을 활성화
			$("#hate_button").toggleClass("btn-primary").toggleClass("btn-secondary");	
		}
	});
	*/
	
});

//댓글작성 1번째 (폼데이터로 입력)
function reply() {
	var replytext = $("#replytext").val();
	var bno="${dto.bno}";
	var secretReply = "n";
	if($("#secretReply").is(":checked")) {
		secretReply = "y";
	}
	var param="replytext="+replytext+"&bno="+bno+"&secretReply="+secretReply;
	$.ajax({
		type : "post",
		url : "${path}/reply/insert",
		data : param,
		success : function() {
			alert("댓글이 등록되었습니다. (폼데이터 방식)");
			//listReply2();
			listReply('1');
		},
	   	error:function(){
			alert("댓글 작성에 실패하였습니다.");
		}
	});
}

/*
//댓글작성 2번째 (json 방식) *사용중
function replyJson() {
	var replytext = $("#replytext").val();
	var bno = "${dto.bno}";
	//비밀댓글 체크여부
	var secretReply = "n";
	//비밀댓글 체크 true or false
	if($("#secretReply").is(":checked")) {
		secretReply = "y";
	}
	$.ajax({
		type: "post",
		url: "${path}/reply/insertRest",
		headers: {
			"Content-Type" : "application/json"
		},
		dateType: "text",
		data: JSON.stringify({
			bno : bno,
			replytext : replytext,
			secretReply : secretReply
		}),
		success: function() {
			alert("댓글이 등록되었습니다. (json방식)");
			listReplyRest('1');
		},
		fail: function() {
			alert("댓글 실패");
		}
	});
}	
*/

//controller방식 (댓글 목록1)
function listReply(num) {
	$.ajax({
		type : "get",
		url : "${path}/reply/list?bno=${dto.bno}&curPage="+num,
		success : function(result) {
			$("#listReply").html(result);
		}
	});
}

//RestController방식 (댓글 목록2, json)
function listReply2() {
	$.ajax({
		type : "get",
		url : "${path}/reply/listJson?bno=${dto.bno}",
		success : function(result) {
			var output = "<table>";
			for(var i in result) {
				output += "<tr>";
				output += "<td>"+result[i].replyer;
				output += "("+changeDate(result[i].regdate)+")<br>";
				output += result[i].replytext+"</td>";
				output += "<tr>";
			}
			output += "</table>";
			$("#listReply").html(output);
		}
	});
}

//날짜 변환 함수 작성
function changeDate(date) {
	date = new Date(parseInt(date));
	year = date.getFullYear();
	month = date.getMonth();
	day = date.getDate();
	hour = date.getHours();
	minute = date.getMinutes();
	second = date.getSeconds();
	strDate = year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
	return strDate;
}

//댓글 목록 - (Rest방식) *사용중
function listReplyRest(num) {
	$.ajax({
		type: "get",
		url: "${path}/reply/list/${dto.bno}/"+num,
		success: function(result) {
			$("#listReply").html(result);
		}
	})
}

//댓글 수정화면 생성 *사용중
/*
function showReplyModify(rno) {
	$.ajax({
		type: "get",
		url: "${path}/reply/detail/"+rno,
		success: function(result) {
			$("#modifyReply").html(result);
			$("#modifyReply").css("visibility", "visible");
		}
	})
}
*/

//댓글 수정화면 생성 *사용중
function showReplyModify(rno) {
	$.ajax({
		type: "get",
		url: "${path}/reply/detail/"+rno,
		success: function(result) {
			$("#modify_rno").html(result.rno);
			$("#modify_replytext").html(result.replytext);
		}
	})
}

//댓글 삭제
function deleteReply(rno) {
	if(confirm("댓글을 삭제하시겠습니까?")) {
		$.ajax({
			type: "delete",
			url: "${path}/reply/delete/"+rno,
			success: function(result) {
				if(result == "success") {
					alert("삭제되었습니다.");
					listReplyRest('1');
				}
			}
		});
	}
}

</script>

</head>

<body>

    <div class="wrapper">
        <%@ include file="../include/sidebar.jsp" %>

        <!-- Page Content  -->
        <div id="content">
			<%@ include file="../include/header.jsp" %>
		
			<div class="container" style="max-width:760px;">
				
				<h1 style="margin-left:15px;">카테고리 : 주식</h1>
				<div style="padding:20px !important; background:white; border-radius: 25px; box-shadow:1px 1px 5px gray;">
					<c:choose>
						<c:when test="${dto.show == 'y'}">
							<form name="form1" method="post">
								<!-- 제목 -->
								<h3 style="margin-top:15px;">
									<span style="font-size:12px; color:gray; margin-left:3px;">주식</span><br>
									${dto.title}
								</h3>
								<hr>
								<!-- 글쓴이, 날짜 -->
								<div style="margin-left:5px;">
									${dto.writer}&nbsp;
									<span style="font-size:11px; color:gray;"><i class="far fa-clock"></i> 
										<fmt:formatDate value="${dto.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</span>
								</div>
			
								<!-- 조회수 -->
								<div style="margin-left:5px; margin-bottom:20px;">
									<i class="far fa-eye"></i> ${dto.viewcnt}
								</div>
			
								<!-- 내용 -->
								<div style="margin-left:5px; margin-bottom: 5px;">
									${dto.content}
								</div>
								
								<!-- 이미지 -->
								<div style="margin-left:5px; margin-bottom: 5px;">
									<div id="uploadedList"></div>
								</div>
							
								<c:choose>
								
									<c:when test="${likeCheck eq '0' or empty likeCheck }">
										<div class="d-flex justify-content-center">
											<div class="like_button btn btn-secondary m-2">
												<i class="fas fa-thumbs-up"></i> 좋아요 <span class="like_cnt">${likeCnt}</span>
											</div>
										</div>
									</c:when>
									
									<c:otherwise>
										<div class="d-flex justify-content-center">
											<div class="like_button btn btn-primary m-2">
												<i class="fas fa-thumbs-up"></i> 좋아요 <span class="like_cnt">${likeCnt}</span>
											</div>
										</div>										
									</c:otherwise>
								</c:choose>
								
								
								<!--  
								<div id="hate_button" class="btn btn-secondary m-2" type="submit">
									<i class="fas fa-thumbs-down"></i> 싫어요 <span>25</span>
								</div>
								-->
								
								<input type="hidden" name="bno" id="bno" value="${dto.bno}">
								<c:if test="${username == dto.writer}">
									<button type="button" class="update">수정</button>
									<button type="button" class="delete">삭제</button>
								</c:if>
								<button type="button" class="list">목록</button>
							</form>
						</c:when>
						<c:otherwise>
							삭제된 게시글입니다.
						</c:otherwise>
					</c:choose>
	
					<hr>

					<!-- 댓글 -->
					<div class="container d-flex justify-content-left">
						<div class="row" style="width:100% !important;">
							<div class="col-md-12">
								<div class="card" style="border:none !important;">
									<!-- 댓글 목록 출력할 위치 -->
									<div id="listReply" class="comment-widgets m-b-20"></div>								
								</div>
							</div>
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