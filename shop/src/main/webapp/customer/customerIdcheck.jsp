<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shop.dao.CustomerDAO"%>
<%@page import="java.sql.*"%>

<%
	String mail = request.getParameter("mail");

	System.out.println(mail + "<-- customerIdcheck");


	
	String  duplication= CustomerDAO.checkMail(mail);
	//사용가능
	
	
	response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkEmail=" + mail + "&duplication=" + duplication);
	// checkmaul 체크한 이메일과 duplication 메일을 쓸수 있는지 없는지 판단하여 값을 반환함 
%>