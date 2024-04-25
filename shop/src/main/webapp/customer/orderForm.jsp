<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shop.dao.CustomerDAO"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

 <%	
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
ArrayList<HashMap<String, Object>> GoodsOne = CustomerDAO.GoodsOne(goodsNo, goodsPrice);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>주문하기</h1>
	<form method="post" action="/shop/customer/orderAction.jsp">
	<div>
	<label for="goodsNo">상품번호</label>
	<input type="number" id="goodsNo" name="goodsNo" value="<%= goodsNo %>"readonly/>
		</div>	
			<div>
				<label for="mail">메일</label>
				<input type="email" id="mail" name="mail">
			</div>
			
			<div>
				<label for= "amount">수량</label>
				<input type="number" id="amount" name="goodsAmount">
			</div>
			
			<div>
				<label for="price">가격</label>
				<input type="number" id="price" name="goodsPrice" value="<%=goodsPrice%>"readonly/>
			</div>
			<div>
				<label for="address">주소 </label>
				<input type="text" id="address" name="address">
			</div>	
		<div>
				<button type="submit">주문하기</button>
		</div>
	</form>
</body>
</html>