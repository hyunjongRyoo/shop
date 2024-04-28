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
	
	ArrayList<HashMap<String,Object>> orderOne = ordersDAO.OrderOne(ordersNo);



%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 상세 보기</title>
</head>
<body>

</body>
</html>