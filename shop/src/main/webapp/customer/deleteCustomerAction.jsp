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
String pw = request.getParameter("pw");

//디버깅
System.out.println(mail+"<--deletemail");
System.out.println(pw+"<--deletePw");


int row;
row=CustomerDAO.deleteCustomer(mail,pw);
if(row==1) {
	System.out.println("회원가입을 축하합니다");
	response.sendRedirect("/shop/emp/loginForm.jsp]");
}else{
	System.out.println("다시 시도해주세요");
	response.sendRedirect("/shop/customer/addCustomerForm.jsp]");
}


%>