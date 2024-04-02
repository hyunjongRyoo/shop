<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.net.*"%>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>

<%
	String empId = request.getParameter("empId");   //getParameter("a")의 값과 결과 값이 일치해야함 
	System.out.println(empId+ "<--empId"); // 디버깅 코드 , 결과 값이랑 스펠링 같은지 확인 
	String empPw = request.getParameter("empPw");
	System.out.println(empPw +"<--empPw");

	
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null; 
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;  // db에 있는  테이블 1줄을 넣는다고 생각 칼럼의 값을 (데이터에 1줄 )
	
	conn= DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "guswhd6656");
	String sql = "select emp_id empId from emp where active='ON' and emp_id =? and emp_pw = password(?)";
	
	PreparedStatement stmt2 = null; 
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql);
	stmt2.setString(1, empId);
	stmt2.setString(2, empPw);
	rs2=stmt2.executeQuery();
	/*
	select emp_id empId 
	from emp
	where active='ON' and emp_id =? and emp_pw = password(?) 
	
	값에 1234를 넣어주면 테이블에 있는 값으로 바뀜
	*/
	
	/*
		실패 /emp/empLoginForm.jsp
		성공 /emp/empList.jsp
	*/
if(rs2.next()) {
		
		System.out.println("로그인 성공");
		
		// 로그인 성공 
		session.setAttribute("loginEmp", rs2.getString("empId"));
		response.sendRedirect("/shop/emp/empList.jsp");
	}else{
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("check your Id & Pw", "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg=" +errMsg);
	
	}
	

%>
