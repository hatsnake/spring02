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
			<h2>상품목록</h2>
			<table border="1">
				<tr>
					<th>상품ID번호</th>
					<th>상품이미지</th>
					<th>상품명</th>
					<th>가격</th>
				</tr>
				<c:forEach var="row" items="${list}">
					<tr>
						<td>
							${row.productId}
						</td>
						<td>
							<a href="${path}/shop/product/detail/${row.productId}">
								<img src="${path}/images/${row.productUrl}" width="120px" height="110px">
							</a>
						</td>
						<td>
							<a href="${path}/shop/product/detail/${row.productId}">${row.productName}</a>
						</td>
						<td>
							<fmt:formatNumber value="${row.productPrice}" pattern="###,###,###"/>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	
		<%@ include file="../include/footer.jsp" %>
		
   </div>
	</div>
	
  <div class="overlay"></div>
  
</body>
</html>