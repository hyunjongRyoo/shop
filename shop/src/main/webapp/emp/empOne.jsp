<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	String empNameParam = request.getParameter("empName");
	String sql ="select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp where emp_name= ?";
	Class.forName("org.mariadb.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop",  "root" , "guswhd6656");
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setString(1, empNameParam);
    ResultSet rs = stmt.executeQuery();
	
    
	ArrayList<HashMap<String, Object>> list
	= new ArrayList<HashMap<String, Object>>();
	
	

// ResultSet -> ArrayList<HashMap<String, Object>>
while(rs.next()) {
	HashMap<String, Object> m = new HashMap<String, Object>();
	String empId = rs.getString("empId");
	String empName = rs.getString("empName");
	String empJob = rs.getString("empJob");
	String hireDate = rs.getString("hireDate");
	String active = rs.getString("active");
	
	m.put("empId", empId);
	m.put("empName", empName);
	m.put("empJob", empJob);
	m.put("hireDate", hireDate);
	m.put("active", active);
	
	list.add(m);
	
}
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

<body class="container">
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
			for(HashMap m: list) { 
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