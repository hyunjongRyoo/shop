<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.net.*"%>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}


%>

<%
/*
select emp_id empId, emp_name empName, emp_job empJob,  hire_date hireDate, active
from emp order by active asc, hire_date desc
*/
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<h1>사원 목록</h1>
<form method="post" action="/shop/emp/modifyEmpActive.jsp">
	<label>권한 주기</label>
<input type="text" name="empId">
<button type="submit">확인</button>
</form>
</body>
</html>