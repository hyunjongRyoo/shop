<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shop.dao.CustomerDAO"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>

<%	
	String mail= request.getParameter("mail");
	String name= request.getParameter("name");
	
	//디버깅 
	System.out.println(mail + "<--mail");
	System.out.println(name + "<--name");
	
	// request 분석
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int startRow = (currentPage-1)*rowPerPage;
%>
<%

int count=0;


int lastPage =0;
if(count % rowPerPage == 0){
	lastPage = count/rowPerPage;
}else{
	lastPage=count /rowPerPage +1 ;
}

ArrayList<HashMap<String , Object>> 
customerlist= CustomerDAO.empCustomerList(startRow, rowPerPage);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자에서 고객페이지 보기</title>
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
<body ="container">
  	<div class="row">
  	<jsp:include page ="/emp/inc/empMenu.jsp"></jsp:include> 
		<div class="col-2" >
			<jsp:include page="/emp/inc/sidebar.jsp"></jsp:include>
			<div>
			<a href="/shop/customer/deleteCustomerAction.jsp">
				<button type="submit">고객 삭제</button>
			</a>
			</div>
			<!-- empMenu.jsp include :주체(서버) vs redirect (주체:클라이언트) -->
			<!-- shop부터 시작하지 않기 // 주체가 서버이기때문이다 -->
	 	</div>
	 	<div class="col-2" ></div>
	
		<div class="col">
		<h1 style="text-align: center">고객 목록</h1><br>
		<table border=1>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>생일</th>
				<th>성별</th>
			</tr>
		<%
			for(HashMap<String, Object> m : customerlist) {
		%>
				<tr>
					<td><%=(String)(m.get("mail"))%></td>
					<td><%=(String)(m.get("name"))%></td>
					<td><%=(String)(m.get("birth"))%></td>
					<td><%=(String)(m.get("gender"))%></td>
				</tr>
		<%		
			}
		%>
	</table>
			<div class="position-absolute bottom-0 start-50 translate-middle-x">
					<%
						if(currentPage>1 && currentPage<lastPage){
					%>
						<a href="/shop/emp/customerList.jsp?currentPage=<%=1%>">첫장 </a>
						<a href="/shop/emp/customerList.jsp?currentPage=<%=currentPage-1%>">이전</a>
						<a href="/shop/emp/customerList.jsp?currentPage=<%=currentPage+1%>" >다음</a>  
						<a href="/shop/emp/customerList.jsp?currentPage=<%=lastPage%>">마지막장</a>  
					<%
						}else if(currentPage==1){
					%>
						<a href="/shop/emp/customerList.jsp?currentPage=<%=currentPage+1%>" >다음</a>  
						<a href="/shop/emp/customerList.jsp?currentPage=<%=lastPage%>"  >마지막장</a>  
					<%
					
						}else{
					%>
						<a href="/shop/emp/customerList.jsp?currentPage=<%=currentPage=1%>"  >첫장 </a>
						<a href="/shop/emp/customerList.jsp?currentPage=<%=currentPage-1%>"  >이전</a>
					<% 
						}
					%>
			 </div>
		</div>
	<div class="col"></div>
</body>
</html>
