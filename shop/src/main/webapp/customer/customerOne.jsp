<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	String nameParam = request.getParameter("name");
	String sql ="select mail , pw , name ,birth , gender from customer where name= ?";
	Class.forName("org.mariadb.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop",  "root" , "guswhd6656");
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setString(1, nameParam);
    ResultSet rs = stmt.executeQuery();
	
    
	ArrayList<HashMap<String, Object>> list
	= new ArrayList<HashMap<String, Object>>();
	
	

// ResultSet -> ArrayList<HashMap<String, Object>>
while(rs.next()) {
	HashMap<String, Object> m = new HashMap<String, Object>();
	String mail = rs.getString("mail");
	String pw = rs.getString("pw");
	String name = rs.getString("name");
	String birth = rs.getString("birth");
	String gender = rs.getString("gender");
	
	m.put("mail", mail);
	m.put("pw", pw);
	m.put("name", name);
	m.put("birth", birth);
	m.put("gender", gender);
	
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

<body>
  	<div class="row">
  	<jsp:include page ="/customer/include/customerMenu.jsp"></jsp:include> 
		<div class="col-2" >
	 	</div>
	 	<div class="col-2" ></div>
	
		<div class="col-4">
		<h1 style="text-align: center">고객 상세 정보</h1><br>
		
			<%
			for(HashMap m: list) { 
			%>
		<table class="table">
			<tr>
				<td> mail</td>
				<td><%=(String)(m.get("mail"))%></td>
			</tr>
			<tr>
				<td> pw</td>
				<td><%=(String)(m.get("pw"))%></td>
			</tr>
			<tr>
				<td> name</td>
				<td><%=(String)(m.get("name"))%></td>
			</tr>
			<tr>
				<td> birth</td>
				<td><%=(String)(m.get("birth"))%></td>
			</tr>
			<tr>
				<td> gender</td>
				<td><%=(String)(m.get("gender"))%></td>
			</tr>		
			<%
		}
			%>
		</table>
	<div class="col-4"></div>
	
	<a href="/shop/customer/customerGoodsList.jsp">
		<button type="submit">리스트</button>
	</a>


</body>
</html>