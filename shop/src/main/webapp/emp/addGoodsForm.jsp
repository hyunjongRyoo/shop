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
			<form method="post" action="/shop/emp/addGoodsAction.jsp"
					enctype="multipart/form-data">
				<div>
					category :
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
				</div>
				<!-- emp_id값은 action쪽에서 세션변수에서 바인딩 -->
				<div>
					goodsTitle : <br>
					<input type="text" name="goodsTitle">
				</div>
				<div>
					goodsImage : <br>
					<input type="file" name="goodsImg">
				</div>
				<div>
					goodsPrice : <br>
					<input type="number" name="goodsPrice">
				</div>
				<div>
					goodsAmount : <br>
					<input type="number" name="goodsAmount">
				</div>
				<div>
					goodsContent : <br>
					<textarea rows="5" cols="50" name="goodsContent"></textarea>
				</div>
				<div>
					<button type="submit">상품등록</button>
				</div>
			</form>
		</div>
	<div class="col"></div>
	</div>
</body>
</html>