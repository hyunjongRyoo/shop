<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<%

	// hashMap loginmemeber에서  저장되어있는 값 중 하나인 loginEmp를 불러와서 연결한다 
	HashMap<String,Object> loginCustomer 
		= (HashMap<String,Object>)(session.getAttribute("loginCustomer"));
	// 키/ 벨류 이므로 벨류값인 Object 변수로 선언해서 불러준다 
	Object customerName = loginCustomer.get("name");
%>


<!-- 상단 네비게이터 바 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="/shop/customer/customerGoodsList.jsp">
   		<%=(String)(loginCustomer.get("name"))%>님
		</a>
		 	<div class="collapse navbar-collapse" id="navbarNav">
			      <ul class="navbar-nav">
			        <li class="nav-item">
					          <a class="nav-link active" aria-current="page" href="/shop/customer/customerOne.jsp?mail=<%=(Object)(loginCustomer.get("mail"))%>">내 정보</a>
			        </li>
			 
			         <li class="nav-item">
					          <a class="nav-link active" aria-current="page" href="/shop/customer/logout.jsp">로그아웃</a>
			        </li>
     			 </ul>
		 </div>
	</div>
</nav>
