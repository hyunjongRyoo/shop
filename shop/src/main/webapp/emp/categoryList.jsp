<%@page import="shop.dao.GoodsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!-- controller Layer -->

<%
	// 로그인 세션 세션변수- loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>

<%

ArrayList<HashMap<String , Object>> 
categoryList= GoodsDAO.categoryList();

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>categoryList</title>
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
<body ="container">
  	<div class="row">
  	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
		<div class="col-2" >
		  	<jsp:include page="/emp/inc/sidebar.jsp"></jsp:include>
		</div>
				<div class="col-3" >
				</div>
					<div class="col-2 " >
	
						<div>
							<h1>카테고리 리스트</h1>
							<table  class="table table-hover text-center">
							<tr>
								<th>카테고리</th>
								<th>업로드 시간</th> 
							</tr>
				<%
							for(HashMap<String, Object> m : categoryList) {
				%>
							<tr>
								<td><%=(String)(m.get("category"))%></td>
								<td><%=(String)(m.get("createDate"))%></td>
							</tr>
				<%
					}
				%>	
						</table>
					</div>
				<div>
			<a href="/shop/emp/addCategoryForm.jsp">
			<button type="submit" class="btn btn-primary">카테고리 추가 등록 </button></a>	
		</div>
		</div>
	<div class="col-5" ></div>
	</div>	
</body>
</html>