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
	<title>goodsOne</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<style>
	
	a{
	text-decoration: none;
	
	color: #000000;
	}
	
	div{
	text-align: center;
	}
		
	</style>
</head>
<body>
<div class="row">
		<jsp:include page ="/customer/include/customerMenu.jsp"></jsp:include> 
		<div class="col-2"></div>
		<!-- CustomerGoodsList 구현부분 -->>	
		<div class="col-6">
		<h1 style="text-align: center">상세 정보</h1><br>
		<%
			for(HashMap m: GoodsOne) { 
		%>
				<table class="table table-hover text-center">
				<tr>
					<td> 제품 번호</td>
					<td><%=(Integer)(m.get("goodsNo"))%></td>
				</tr>
				<tr>
					<td> <img src="/shop/upload/<%=(String)(m.get("filename"))%>"></td>
				<tr>
					<td> 종류</td>
					<td><%=(String)(m.get("goodsContent"))%></td>
				</tr>	
				<tr>
					<td> 가격</td>
					<td><%=(Integer)(m.get("goodsPrice"))%></td>
				</tr>
				<tr>
					<td> 수량</td>
					<td><%=(Integer)(m.get("goodsAmount"))%></td>
				</tr>	
			</table>
			<%
				}
			%>
				<div>
					<a href="/shop/customer/orderForm.jsp?goodsNo=<%=goodsNo%>&goodsPrice=<%=goodsPrice%>">
						<button type="submit">주문하기</button>
					</a>
					<a href="/shop/customer/customerGoodsList.jsp">
						<button type="submit">리스트</button>
					</a>
				</div>
			</div>
			<div class="col-4"></div>
		</div>
	</body>
</html>