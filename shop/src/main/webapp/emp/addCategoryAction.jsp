<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@page import="java.sql.*" %>
<%@page import="shop.dao.GoodsDAO"%>

<%
	request.setCharacterEncoding("UTF-8");
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	%>
	<%
	HashMap<String,Object> loginMember = (HashMap<String,Object>)(session.getAttribute("loginEmp"));
	%>
	<%
	String category = request.getParameter("category");
	

	
	int row;
	row=GoodsDAO.addCategoryAction(category);

	if(row==1){
		System.out.println("등록하였습니다");
	}else{
		System.out.println("등록에 실패하였습니다");
	}
	 response.sendRedirect("/shop/emp/categoryList.jsp");
%>
	
