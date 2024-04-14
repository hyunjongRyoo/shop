<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
	String mail = request.getParameter("mail");

	System.out.println(mail + "<-- customerIdcheck");
	
	String sql = "select mail, pw, name, birth, gender from customer where mail =?";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "guswhd6656");
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, mail);
	System.out.println(stmt);
	ResultSet rs = stmt.executeQuery();
	
	String  duplication= "yes";
	//사용가능
	
	if(rs.next()){
			duplication = "no";
	}
	//중복되어서 사용 불가능
	
	response.sendRedirect("/shop/customer/addCustomerForm.jsp?checkEmail=" + mail + "&duplication=" + duplication);
	// checkmaul 체크한 이메일과 duplication 메일을 쓸수 있는지 없는지 판단하여 값을 반환함 
%>