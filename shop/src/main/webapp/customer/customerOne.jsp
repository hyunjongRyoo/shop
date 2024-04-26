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
		</table>
	<%
		}
	%>
		</div>
			<div>
				<a href="/shop/customer/customerGoodsList.jsp">
					<button type="submit" class="btn btn-primary">리스트</button>
				</a>
				
				<a href="/shop/customer/modifyCustomerPwForm.jsp">
					<button type="submit" class="btn btn-primary">비밀번호변경</button>
				</a>
			</div>
		<div class="col-4"></div>
	</div>
</body>
</html>