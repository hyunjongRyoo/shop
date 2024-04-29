<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shop.dao.GoodsDAO"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>

<!-- controller Layer -->
<%
//인증분기	 : 세션변수 이름 - loginEmp
if(session.getAttribute("loginEmp") == null) {
	response.sendRedirect("/shop/emp/empLoginForm.jsp");
	return;
}
%>

<!-- Model Layer -->

<%

	ArrayList<String> GoodsList=GoodsDAO.addGoods();
	//객체 = class이름. 메소드이름(매개변수);


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
<body="container">
  	<div class="row">
  	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
		<div class="col-2" >
		  	<jsp:include page="/emp/inc/sidebar.jsp"></jsp:include>
	  	</div>
		<div class="col-2" ></div>
		
			<div class="col-4" >
			<h1>상품등록</h1>
			<form method="post" action="/shop/emp/addGoodsAction.jsp" enctype="multipart/form-data">
				<table class="table table-hover">
					<tr>
						<td>category</td>
						<td>
							<select name="category">
							<option value="">선택</option>
								<%
									for(String c : GoodsList) {  //배열의 반복  인덱스 0~끝날때까지 반복
								%>
									<option value="<%=c%>"><%=c%></option>
								<%		
									}
								%>
							</select>
						</td>
					</tr>
					<tr>					
						<td>goodsTitle</td>
						<td><input type="text" name="goodsTitle"></td>		
					</tr>
					<tr>					
						<td>goodsImage</td>
						<td><input type="file" name="goodsImg"></td>		
					</tr>
					<tr>	
						<td>goodsPrice</td>
						<td><input type="number" name="goodsPrice"></td>
					</tr>
					<tr>
						<td>goodsAmount</td>
						<td><input type="number" name="goodsAmount"></td>
					</tr>
					<tr>
						<td>goodsContent</td>
						<td><textarea rows="5" cols="50" name="goodsContent"></textarea></td>
					</tr>
				</table>
				<div>
					<button type="submit" class="btn btn-primary">상품등록</button>
				</div>
			</form>
		</div>
	<div class="col"></div>
	</div>
</body>
</html>