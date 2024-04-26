<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="shop.dao.CustomerDAO"%>
<%@page import="shop.dao.ordersDAO"%>
<%@page import="shop.dao.GoodsDAO"%>
<%@page import="java.util.*"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}
%>
<%
int goodsNo = Integer.parseInt(request.getParameter("goodsNo")); //값을 받아오고  
int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
ArrayList<HashMap<String, Object>> 
GoodsOne= CustomerDAO.GoodsOne(goodsNo,goodsPrice);


HashMap<String, Object> sessionInfo = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));//mail 값 
String mail = (String)(sessionInfo.get("mail"));
int goodsAmount = Integer.parseInt(request.getParameter("goodsAmount"));
String address = request.getParameter("address");


System.out.println(goodsNo + "<-- orderAction.jsp goodsNo");
System.out.println(goodsAmount + "<-- orderAction.jsp goodsAmount");
System.out.println(goodsPrice + "<-- orderAction.jsp  goodsPrice");
System.out.println(address + "<-- orderAction.jsp  address");
System.out.println(mail + "<-- orderAction.jsp mail");


int row = GoodsDAO.updateGoodsAmount(goodsNo, goodsAmount);
if(row == 1){
	System.out.println("상품갯수 수정 성공");
	row = ordersDAO.ordersAction(mail, goodsAmount, goodsPrice, address);
	if(row == 1){
		System.out.println("입력 성공");
		response.sendRedirect("/shop/customer/ordersList.jsp");
		return;
	} else {
		System.out.println("수정 실패");
	}
} else {
	System.out.println("입력실패");
}
response.sendRedirect("/shop/customer/customerGoodsOne.jsp?goodsNo=" + goodsNo + "&goodsPrice=" + goodsPrice);

%>