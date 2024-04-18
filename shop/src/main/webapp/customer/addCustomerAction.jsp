<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shop.dao.CustomerDAO"%>
<%@ page import="java.sql.*" %>

<%
	//  customer 로그인 인증 분기
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
%>

<%
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	
	//디버깅
	System.out.println(mail +"<--mail");
	System.out.println(pw +"<--pw");
	System.out.println(name +"<--name");
	System.out.println(birth +"<--birth");
	System.out.println(gender +"<--gender");
	
	
	int row;
	row=CustomerDAO.addCustomer(mail,pw,name,birth,gender);
	
	if(row==1) {
		System.out.println("회원가입을 축하합니다");
		response.sendRedirect("/shop/emp/loginForm.jsp]");
	}else{
		System.out.println("다시 시도해주세요");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp]");
	}
	
	
%>