<%@page import="shop.dao.empDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%
	// 로그인 세션 세션변수- loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%

String empNameParam = request.getParameter("empName"); //값을 받아오고  
ArrayList<HashMap<String, Object>> 
One= empDao.One(empNameParam); // 값을 넣어줘야함 줘야함 
//

%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<style>
	
	a{
	text-decoration: none;
	
	color: #000000;
	}
	
	div{
	text-align: center;
	}
		
	</style>
</head>

<body>
  	<div class="row">
  	<jsp:include page ="/emp/inc/empMenu.jsp"></jsp:include> 
		<div class="col-2" >
			<jsp:include page="/emp/inc/sidebar.jsp"></jsp:include>
			<!-- empMenu.jsp include :주체(서버) vs redirect (주체:클라이언트) -->
			<!-- shop부터 시작하지 않기 // 주체가 서버이기때문이다 -->
	 	</div>
	 	<div class="col-2" ></div>
	
		<div class="col-4">
		<h1 style="text-align: center">상세 정보</h1><br>
		
			<%
			for(HashMap m: One) { 
			%>
		<table class="table">
			<tr>
				<td> empId</td>
				<td><%=(String)(m.get("empId"))%></td>
			</tr>
			<tr>
				<td> empName</td>
				<td><%=(String)(m.get("empName"))%></td>
			</tr>
			<tr>
				<td> empJob</td>
				<td><%=(String)(m.get("empJob"))%></td>
			</tr>
			<tr>
				<td> hireDate</td>
				<td><%=(String)(m.get("hireDate"))%></td>
			</tr>
			<tr>
				<td> active</td>
				<td><%=(String)(m.get("active"))%></td>
			</tr>		
			<%
		}
			%>
		</table>
	<div class="col-4"></div>
	
	<a href="/shop/emp/empList.jsp">
		<button type="submit">리스트</button>
	</a>


</body>
</html>