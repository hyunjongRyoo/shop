<%@page import="shop.dao.GoodsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
//인증분기	 : 세션변수 이름 - loginEmp
if(session.getAttribute("loginEmp") == null) {
	response.sendRedirect("/shop/emp/empLoginForm.jsp");
	return;
}
%>

<%

ArrayList<String>addCategoryForm=GoodsDAO.addCategoryForm();
//객체 = class이름. 메소드이름(매개변수);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<style>
	div{
	text-align: center;
	}
	a{
	text-decoration: none;
	}
	</style>

</head>
<body> 
	<div class="row">
		<!-- 상단 바-->
		<jsp:include page ="/emp/inc/empMenu.jsp"></jsp:include> 
		<div class="col-2" >
		 	<jsp:include page="/emp/inc/sidebar.jsp"></jsp:include>
		</div>	
		<div class="col-3"></div>
			<!-- 중단 -->
				<div class="col-2" >
					<h1 style="text-align: center">새로운 카테고리 추가</h1>
					<form method="post" action="/shop/emp/addCategoryAction.jsp">
						<div>
							<input type="text" id="category" name="category">
						</div>
						<div >
							<button type="submit" class="btn btn-primary">카테고리 추가</button>
						</div>
					</form>
				</div>
			<div class="col-3"></div>
		</div>
	</body>
</html>