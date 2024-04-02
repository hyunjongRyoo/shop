<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.net.*"%>

<%
String empId =request.getParameter("empId");
//디버깅 
System.out.println("empId"); 

String active =request.getParameter("active");
//디버깅 
System.out.println("active"); 


Class.forName("org.mariadb.jdbc.Driver");
Connection conn = null; 
conn= DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "guswhd6656");

String sql="update emp set active = ? where emp_id = ?";


PreparedStatement stmt = null;
ResultSet rs = null;  // db에 있는  테이블 1줄을 넣는다고 생각 칼럼의 값을 (데이터에 1줄 )
stmt =conn.prepareStatement(sql);
stmt.setString(1,empId);


if(rs.next()) {
	System.out.println("세션 on");
	
	session.setAttribute("active", rs.getString("empId"));
	response.sendRedirect("/shop/emp/empList.jsp");
}else{
	System.out.println("emp_Id를 확인해 주세요");
	response.sendRedirect("/shop/emp/empLoginForm.jsp");
}


%>

