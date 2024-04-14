<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>


<%
	String goodsTitleParam =request.getParameter("goodsTitle");
	String sql= "select goods_no goodsNo , category ,filename , emp_id empId , goods_title goodsTitle , goods_content goodsContent , goods_price goodsPrice ,goods_amount goodsAmount ,update_date updateDate, create_date createDate  from goods where goods_title= ?  ";
	Class.forName("org.mariadb.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop",  "root" , "guswhd6656");
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setString(1, goodsTitleParam);
    ResultSet rs = stmt.executeQuery();

    
 // ResultSet -> ArrayList<HashMap<String, Object>>
    	HashMap<String, Object> m = new HashMap();
	    if(rs.next()) {
    	
    	m.put("goodsNo", rs.getInt("goodsNo"));
    	m.put("filename", rs.getString("filename"));
    	m.put("empId", rs.getString("empId"));
    	m.put("goodsTitle", rs.getString("goodsTitle"));
    	m.put("goodsContent", rs.getString("goodsContent"));
    	m.put("goodsPrice", rs.getInt("goodsPrice"));
    	m.put("goodsAmount", rs.getInt("goodsAmount"));
    	m.put("updateDate", rs.getString("updateDate"));
		m.put("createDate", rs.getString("createDate"));
    	
    }
%>





<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>goodsOne</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	
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
		
		<table class="table">
			<tr>
				<td> 제품 번호</td>
				<td><%=(Integer)(m.get("goodsNo"))%></td>
			</tr>
			<tr>
				<td> 사진</td>
				<td> <img src="/shop/upload/default.jpg" alt="??"></td>
			</tr>
			<tr>
				<td> 담당자</td>
				<td><%=(String)(m.get("empId"))%></td>
			</tr>
			<tr>
				<td> 종류</td>
				<td><%=(String)(m.get("goodsContent"))%></td>
			</tr>	
			<tr>
				<td> 가격</td>
				<td><%=(Integer)(m.get("goodsPrice"))%></td>
			</tr>
			<tr>
				<td> 수량</td>
				<td><%=(Integer)(m.get("goodsAmount"))%></td>
			</tr>	
			<%
			%>
		</table>
	<div class="col-4"></div>
	
	<a href="/shop/emp/goodsList.jsp">
		<button type="submit">리스트</button>
	</a>


</body>
</html>