<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	page import="java.util.*"%>
<%@page import="shop.dao.ordersDAO"%>

<%
	// 로그인 세션 세션변수- loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>

<%
//페이징
int currentPage = 1;
if(request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}

int rowPerPage = 10;
int startRow = (currentPage-1)*rowPerPage;



ArrayList<HashMap<String, Object>>
list=ordersDAO.selectOrdersListAll(startRow, rowPerPage);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>empOrderList-emp</title>
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
<jsp:include page ="/emp/inc/empMenu.jsp"></jsp:include> 
	<div class="col-2" >
		<jsp:include page="/emp/inc/sidebar.jsp"></jsp:include>
	</div>
	<div class="col-2" ></div>
	
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
<div class="col-4" ></div>
</body>
</html>