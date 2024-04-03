<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
<%
//로그인 세션
	/*
	String loginEmp = (String)session.getAttribute("loginEmp");  // String으로는 loginEmp에 3개의 값(empId,empName,grade)을 모두 담을수 없기
	System.out.println(loginEmp + " <-- loginEmp");				//때문에  String을 hashmap(API)으로 변환을
	if(loginEmp == null){										//해야한다
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	*/
	

	
HashMap<String, Object> loginEmp = (HashMap<String, Object>) session.getAttribute("loginEmp");
System.out.println(loginEmp + " <-- loginEmp");
if(loginEmp == null){
	response.sendRedirect("/shop/emp/empLoginForm.jsp");
	return;
}

	
%>
<%
//받아오는 값 empId, active
String empId =request.getParameter("empId");
//디버깅 
System.out.println("empId"); 

String active =request.getParameter("active");
//디버깅 
System.out.println("active"); 



// Off일때 on으로 바꿔준다
if(active.equals("OFF")){
		active="ON";
}else{
	active="OFF";
}


PreparedStatement stmt = null;
String sql="update emp set active = ? where emp_id = ?";
Class.forName("org.mariadb.jdbc.Driver");
Connection conn = null; 
conn= DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "guswhd6656");

stmt =conn.prepareStatement(sql);
stmt.setString(1, active);
stmt.setString(2, empId);
System.out.println(stmt); 

int row = 0;
row = stmt.executeUpdate();

if(row == 1) {
	System.out.println("변경 완료 ");
}else{
	System.out.println("변경 실패");
}
//직원리스트로 이동
response.sendRedirect("/shop/emp/empList.jsp");
%>

