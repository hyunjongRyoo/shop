<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shop.dao.CustomerDAO"%>
    <%
	//  customer 로그인 인증 분기
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
	%>
<%
String mail = request.getParameter("mail");
String OldPw = request.getParameter("OldPw");
String newPw = request.getParameter("newPw");

//디버깅
System.out.println(mail+"<--deletemail");
System.out.println(newPw+"<--newPw");
System.out.println(OldPw+"<--OldPw");

int row;
row=CustomerDAO.updatePw(mail,OldPw,newPw);
if(row==1) {
	System.out.println("삭제에 성공하였습니다");
	response.sendRedirect("/shop/customer/deleteCustomer.jsp]");
}else{
	System.out.println("다시 시도해주세요");
	response.sendRedirect("/shop/customer/deleteCustomer.jsp]");
}


%>