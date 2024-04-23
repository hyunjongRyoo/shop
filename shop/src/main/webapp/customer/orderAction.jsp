<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
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
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
HashMap<String, Object> sessionInfo = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));//mail 값 
String mail = (String)(sessionInfo.get("mail"));
int amount = Integer.parseInt(request.getParameter("amount"));
int price = Integer.parseInt(request.getParameter("Price"));
String address = request.getParameter("address");


System.out.println(goodsNo + "<-- order goodsNo");
System.out.println(amount + "<-- order amount");
System.out.println(price + "<-- order  price");
System.out.println(address + "<-- order  address");
System.out.println(mail + "<-- order mail");


int row = GoodsDAO.updateGoodsAmount(goodsNo, amount);
if(row == 1){
	System.out.println("상품갯수 수정 성공");
	row = ordersDAO.ordersAction(mail, amount, price, address);
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
response.sendRedirect("/shop/customer/customerGoodsOne.jsp?goodsNo=" + goodsNo);

%>