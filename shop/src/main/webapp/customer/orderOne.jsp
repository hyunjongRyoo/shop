<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="shop.dao.*"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}
%>

<%
	HashMap<String, Object> loginCustomer = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));//mail 값 
	//메일값으로 고객 개개인의 주문정보를 받아줌
	String mail=(String)(loginCustomer.get("mail"));	
	
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	
	ArrayList<HashMap<String,Object>> orderOne = ordersDAO.orderOne(ordersNo);



%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 상세 보기</title>
</head>
<body>
	<table>
		<%
			for(HashMap m: orderOne){
		%>
			<tr>
				<td>주문번호</td>
				<td><%=m.get("ordersNo")%></td>
			</tr>
			
			<tr>
				<td>상품번호</td>
				<td><%=m.get("goodsNo")%></td>
			</tr>
			
			<tr>
				<td>상품명</td>
				<td><%=m.get("goodsTitle")%></td>
			</tr>
			
			<tr>
				<td>총 수량</td>
				<td><%=m.get("totalAmount")%></td>
			</tr>
			
			<tr>
				<td>총 가격</td>
				<td><%=m.get("totalPrice")%></td>
			</tr>
			
			<tr>
				<td>주문 상태</td>
				<td><%=m.get("state")%></td>
			</tr>
			
			<tr>
				<td>주문 날짜</td>
				<td><%=m.get("createDate")%></td>
			</tr>
		<%
			}
		%>
	</table>
</body>
</html>