<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
<%@ include file="../include/util.jsp" %>
<style type="text/css">
	.card-list:hover {
		background: #f5f3f3;
	}
	
	a:link .readed {
		color:black;
	}
	
	a:visited .readed {
		color:#989191;
	}
</style>
</head>

<body>
    <div class="wrapper">
    	<%@ include file="../include/sidebar.jsp" %>

        <!-- Page Content  -->
        <div id="content">
			<%@ include file="../include/header.jsp" %>
					
			<div class="container">

				<!-- 글목록 1 -->
				<div class="card">
					<div class="card-body">
						<h4 class="card-title">최신글</h4>
						<p class="card-text">
							
							<c:forEach var="row" items="${list}">
								<c:choose>
									<c:when test="${row.show == 'y'}">
									
										<div class="line" style="margin: 0 !important;"></div>
										
										<div class="card card-list" style="border: none !important;">
											<div class="card-body" style="padding:0px !important; ">
												<a href="${path}/board/view?bno=${row.bno}">
													<div class="card-title" style="margin:10px;">
														<span class="readed">${row.title}</span> &nbsp;
														<!-- 댓글이 있으면 게시글 이름 옆에 댓글 수 출력 -->
														<c:if test="${row.recnt > 0}">
															<span style="color:red; font-size:17px;">
																<i class="far fa-comment-dots"></i> 
																${row.recnt}
															</span>
														</c:if>
													</div>
												</a>
												
											</div>
										</div>
			
										<div class="line" style="margin: 0 !important;"></div>	
							
									</c:when>
									<c:otherwise>
									
										<div class="line" style="margin: 0 !important;"></div>
										
										<div class="card card-list" style="border: none !important;">
											<div class="card-body" style="padding:0px !important; ">
												<div class="card-title" style="margin:10px;">
													<c:if test="${row.recnt > 0}">
														<a href="${path}/board/viewLimit?bno=${row.bno}" style="color:red;">
															삭제된 게시글입니다.
															<span style="color:red; font-size:17px;">
																<i class="far fa-comment-dots"></i> 
																${row.recnt}
															</span>
														</a>
													</c:if>
													<c:if test="${row.recnt == 0}">
														<span style="color:red;">삭제된 게시글입니다.</span>
													</c:if>
												</div>
											</div>
										</div>
			
										<div class="line" style="margin: 0 !important;"></div>		
																	
									</c:otherwise>
								</c:choose>
							</c:forEach>
							


						</p>
						<div class="float-right">
							<a href="${path}/board/list" class="card-link" style="float:right;">더보기</a>
						</div>
					</div>
				</div>

				<div class="line"></div>

				<!-- 글목록 2 -->
				<div class="card">
					<div class="card-body">
						<h4 class="card-title">인기글</h4>
						<p class="card-text">
							
							<div class="line" style="margin: 0 !important;"></div>

							<div class="card" style="border: none !important;">
								<div class="card-body" style="padding:0px !important; ">
									<div class="card-title" style="margin:10px;">
											재밌는 글 1 &nbsp;
											<span style="color:red; font-size:17px;"><i class="far fa-comment-dots"></i> 
												10
											</span>
									</div>
									
								</div>
							</div>

							<div class="line" style="margin: 0 !important;"></div>

							<div class="card" style="border: none !important;">
								<div class="card-body" style="padding:0px !important; ">
									<div class="card-title" style="margin:10px;">
											재밌는 글 1 &nbsp;
											<span style="color:red; font-size:17px;"><i class="far fa-comment-dots"></i> 
												10
											</span>
									</div>
								</div>
							</div>

							<div class="line" style="margin: 0 !important;"></div>

							<div class="card" style="border: none !important;">
								<div class="card-body" style="padding:0px !important; ">
									<div class="card-title" style="margin:10px;">
											재밌는 글 1 &nbsp;
											<span style="color:red; font-size:17px;"><i class="far fa-comment-dots"></i> 
												10
											</span>
									</div>
								</div>
							</div>	

							<div class="line" style="margin: 0 !important;"></div>

							<div class="card" style="border: none !important;">
								<div class="card-body" style="padding:0px !important; ">
									<div class="card-title" style="margin:10px;">
											재밌는 글 1 &nbsp;
											<span style="color:red; font-size:17px;"><i class="far fa-comment-dots"></i> 
												10
											</span>
									</div>
								</div>
							</div>
							
							<div class="line" style="margin: 0 !important;"></div>

							<div class="card" style="border: none !important;">
								<div class="card-body" style="padding:0px !important; ">
									<div class="card-title" style="margin:10px;">
											재밌는 글 1 &nbsp;
											<span style="color:red; font-size:17px;"><i class="far fa-comment-dots"></i> 
												10
											</span>
									</div>
								</div>
							</div>

							<div class="line" style="margin: 0 !important;"></div>

						</p>
						<div class="float-right">
							<a href="#" class="card-link" style="float:right;">더보기</a>
						</div>
					</div>
				</div>

				<div class="line"></div>

			</div>


			<%@ include file="../include/footer.jsp" %>

        </div>


    </div>

    <div class="overlay"></div>

</body>

</html>