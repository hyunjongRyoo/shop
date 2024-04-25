<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shop.dao.ordersDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>

<%
// 인증분기	 : 세션변수 이름 - loginCustomer
if(session.getAttribute("loginCustomer") == null) {
	response.sendRedirect("/shop/customer/loginForm.jsp");
	return;
}
%>

<%
HashMap<String, Object> loginCustomer=(HashMap<String, Object>)(session.getAttribute("loginCustomer"));
//메일값으로 고객 개개인의 주문정보를 받아줌
String mail=(String)(loginCustomer.get("mail"));


//페이징
int currentPage = 1;
if(request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}

int rowPerPage = 10;
int startRow = (currentPage-1)*rowPerPage;



ArrayList<HashMap<String, Object>>
list=ordersDAO.selectOrdersListByCustomer(mail, startRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Orders List(customer version)</title>
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
<div class="col-4" ></div>
	<div class="col-4">
		<table>
				<tr>
					<th>주문 번호</th>
					<th>메일(아이디)</th>
					<th>상품번호</th>
					<th>총 수량</th>
					<th>총 금액</th>
					<th>주소</th>
					<th>주문 상태</th>
					<th>주문 변경 날짜</th>
					<th>주문 날짜  </th>
					<th>상품 가격</th>
					<th>상품 이름</th>
				</tr>
					<%
						for(HashMap<String , Object> m : list){
					%>
						<tr>
							<td><%=(Integer)(m.get("ordersNo"))%></td>
							<td><%=(String)(m.get("mail"))%></td>
							<td><%=(Integer)(m.get("goodsNo"))%></td>
							<td><%=(Integer)(m.get("totalAmount"))%></td>
							<td><%=(Integer)(m.get("totalPrice"))%></td>
							<td><%=(Integer)(m.get("address"))%></td>
							<td><%=(String)(m.get("state"))%></td>
							<td><%=(Integer)(m.get("updateDate"))%></td>
							<td><%=(Integer)(m.get("createDate"))%></td>
							<td><%=(Integer)(m.get("goodsPrice"))%></td>
							<td><%=(Integer)(m.get("goodsTitle"))%></td>	
						</tr>
					<%
						}
					%>
			</table>
		</div>
	</div>
<div class="col-4" ></div>
</body>
</html>