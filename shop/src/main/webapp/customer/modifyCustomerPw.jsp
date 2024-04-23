<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shop.dao.CustomerDAO"%>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}
%>
<%
String mail=request.getParameter("mail");
String OldPw=request.getParameter("OldPw");
String newPw=request.getParameter("newPw");

//디버깅
System.out.println(mail + "<--mail");
System.out.println(OldPw + "<--OldPw");
System.out.println(newPw + "<--newPw");

int row=0;
row=CustomerDAO.updatePw(mail, OldPw, newPw);

if(row==1){
	System.out.println("비밀번호 변경 성공");
	response.sendRedirect("/shop/customer/customerOne.jsp");
}else{
	System.out.println("변경에 실패했습니다");
	response.sendRedirect("/shop/customer/customerOne.jsp");
}
%>