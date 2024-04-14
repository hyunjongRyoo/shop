<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
	String mail = request.getParameter("mail");

	System.out.println(mail + "<-- checkMailAction param customerEmail");
	
	String sql = "select mail, pw, name, birth, gender from customer where mail =?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "guswhd6656");
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, mail);
	System.out.println(stmt);
	ResultSet rs = stmt.executeQuery();
	
	String check = "ok";
	
	if(rs.next()){
			check = "no";
	}
	
	response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkEmail=" + mail + "&check=" + check);
%>