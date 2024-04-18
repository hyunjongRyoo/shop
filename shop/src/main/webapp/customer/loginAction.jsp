<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shop.dao.CustomerDAO"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>


<%
	//  customer 로그인 인증 분기
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
%>
<%
	String mail =request.getParameter("mail");
	String pw = request.getParameter("pw");
	
	//디버깅
	System.out.println(mail +"<--mail");
	System.out.println(pw +"<--pw");
	

	HashMap<String , String> loginCustomer =CustomerDAO.login(mail, pw);
	
	
	if(loginCustomer == null) {
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("check your Id & Pw", "utf-8");
		response.sendRedirect("/shop/customer/LoginForm.jsp?errMsg=" +errMsg);
	}else{
		System.out.println("로그인 성공 ");
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		session.setAttribute("loginCustomer",loginCustomer); 
		
	}
%>
