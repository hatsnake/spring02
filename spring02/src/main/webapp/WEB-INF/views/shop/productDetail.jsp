<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/util.jsp" %>
</head>
<body>

   <div class="wrapper">
<%@ include file="../include/sidebar.jsp" %>

	<!-- Page Content  -->
  <div id="content">
		<%@ include file="../include/header.jsp" %>
	
		<div class="container">
			<h2>상품 상세정보</h2>
			<table border="1">
				<tr>
					<td>
						<img src="${path}/images/${dto.productUrl}" width="340" height="300">
					</td>			
					<td>
						<table border="1" style="height:300px; width:400px;">
							<tr align="center">
								<td>상품명</td>
								<td>${dto.productName}</td>
							</tr>
							<tr align="center">
								<td>가격</td>
								<td><fmt:formatNumber value="${dto.productPrice}" pattern="###,###,###"/></td>
							</tr>
							<tr align="center">
								<td>상품소개</td>
								<td>${dto.productDesc}</td>
							</tr>
							<tr align="center">
								<td colspan="2">
									<form name="form1" method="post" action="${path}/shop/cart/insert">
										<input type="hidden" name="productId" value="${dto.productId}">
										<select name="amount">
											<c:forEach begin="1" end="10" var="i">
												<option value="${i}">${i}</option>
											</c:forEach>
										</select>&nbsp;개
										<input type="submit" value="장바구니에 담기">
									</form>
									<a href="${path}/shop/product/list">상품목록</a>
								</td>
							</tr>
						</table>
					</td>	
				</tr>
			</table>
		</div>
	
		<%@ include file="../include/footer.jsp" %>
   </div>
	</div>
	
  <div class="overlay"></div>
  
</body>
</html>