<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

<head>
<%@ include file="../include/util.jsp" %>
<style type="text/css">
	.card-list:hover {
		background: #f5f3f3;
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
							
							<div class="line" style="margin: 0 !important;"></div>
							
							<div class="card card-list" style="border: none !important;">
								<div class="card-body" style="padding:0px !important; ">
									<div class="card-title" style="margin:10px;">
											재밌는 글 1 &nbsp;
											<span style="color:red; font-size:17px;">
												<i class="far fa-comment-dots"></i> 
												10
											</span>
									</div>
									
								</div>
							</div>

							<div class="line" style="margin: 0 !important;"></div>

							<div class="card card-list" style="border: none !important;">
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

							<div class="card card-list" style="border: none !important;">
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

							<div class="card card-list" style="border: none !important;">
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

							<div class="card card-list" style="border: none !important;">
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