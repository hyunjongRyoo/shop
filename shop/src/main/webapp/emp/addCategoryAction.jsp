<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@page import="java.sql.*" %>

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
	
	String sql = "insert into category(category)Values(?)";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "guswhd6656");
	PreparedStatement stmt1 = null;
	stmt1 = conn.prepareStatement(sql);
	stmt1.setString(1, category);
	
	System.out.println(stmt1);
	%>
	
	<%
	int row=stmt1.executeUpdate();

	if(row==1){
		System.out.println("등록하였습니다");
	}else{
		System.out.println("등록에 실패하였습니다");
	}
	 response.sendRedirect("/shop/emp/categoryList.jsp");
%>
	
