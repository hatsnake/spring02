<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/util.jsp" %>
<script>
$(document).ready(function() {
		$("#btnList").click(function() {
			location.href="${path}/shop/product/list";
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
	
		<div class="container">
			<h2>장바구니 확인</h2>
			<c:choose>
				<c:when test="${map.count == 0}">
					장바구니가 비어있습니다.
				</c:when>
				<c:otherwise>
					<form name="form1" id="form1" method="post" action="${path}/shop/cart/update">
						<table border="1">
							<tr>
								<th>상품명</th>
								<th>단가</th>
								<th>수량</th>
								<th>금액</th>
								<th>취소</th>
							</tr>
							<c:forEach var="row" items="${map.list}" varStatus="i">
								<tr>
									<td>
										${row.productName}
									</td>
									<td style="width:80px;" align="right">
										<fmt:formatNumber pattern="###,###,###" value="${row.productPrice}"/>
									</td>
									<td>
										<input type="number" style="width:40px;" name="amount" value="${row.amount}" min="1">
										<input type="hidden" name="productId" value="${row.productId}">
									</td>
									<td style="width: 100px" align="right">
										<fmt:formatNumber pattern="###,###,###" value="${row.money}"/>
									</td>
									<td>
										<a href="${path}/shop/cart/delete?cartId=${row.cartId}">삭제</a>
									</td>
								</tr>
							</c:forEach>
							<tr>
								<td colspan="5" align="right">
									장바구니 금액 합계 : <fmt:formatNumber pattern="###,###,###" value="${map.sumMoney}"/><br>
									배송료 : ${map.fee}<br>
									전체 주문금액 : <fmt:formatNumber pattern="###,###,###" value="${map.allSum}"/>
								</td>
							</tr>
						</table>
					</form>
				</c:otherwise>
			</c:choose>
			<button type="button" id="btnList">상품목록</button>
		</div>
	
		<%@ include file="../include/footer.jsp" %>
		
   </div>
	</div>
	
  <div class="overlay"></div>
  
</body>
</html>