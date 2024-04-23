<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="shop.dao.CustomerDAO"%>
<%@ page import="java.util.*"%>
<%

   String mailParam = request.getParameter("mail");
	ArrayList<HashMap<String,Object>>
	One=CustomerDAO.selectCustomerOne(mailParam);

	
	

// ResultSet -> ArrayList<HashMap<String, Object>>

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
			for(HashMap m: One) { 
			%>
		<table class="table">
			<tr>
				<td> mail</td>
				<td><%=(String)(m.get("mail"))%></td>
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
	<h1>비밀번호 변경하기</h1>
	<form method="post" action="/shop/customer/modifyCustomerPw.jsp">
		<div>
			<label for="mail">email</label>
			<input type="email" id="mail" name="mail" >
		</div>
		
		<div>
			<label for="OldPw">OldPw</label>
			<input type="password" id="OldPw" name="OldPw" >
		</div>
		
		<div>
			<label for="newPw">newPw</label>
			<input type="password" id="newPw" name="newPw" >
		</div>
		<button type="submit">변경하기</button>		
	</form>
</body>
</html>