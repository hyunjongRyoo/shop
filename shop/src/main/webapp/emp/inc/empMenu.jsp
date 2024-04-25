<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
	// hashMap loginmemeber에서  저장되어있는 값 중 하나인 loginEmp를 불러와서 연결한다 
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginEmp"));
	// 키/ 벨류 이므로 벨류값인 Object 변수로 선언해서 불러준다 
	Object empName = loginMember.get("empName");
%>
<!-- 상단 네비게이터 바 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="/shop/emp/empList.jsp">
   		<%=(String)(loginMember.get("empName"))%>님
	</a>
	 	<div class="collapse navbar-collapse" id="navbarNav">
	      	<ul class="navbar-nav">
	       		 <li class="nav-item">
		         	 <a class="nav-link active" aria-current="page" href="/shop/emp/empList.jsp">사원관리</a>
	        	</li>
			 	 <li class="nav-item">
		         	 <a class="nav-link active" aria-current="page" href="/shop/emp/categoryList.jsp">카테고리 관리</a>
		        </li>
		       <li class="nav-item">
			          <a class="nav-link active" aria-current="page" href="/shop/emp/goodsList.jsp">상품 관리</a>
		        </li>
	           <li class="nav-item">
			          <a class="nav-link active" aria-current="page" href="/shop/emp/customerList.jsp">고객 리스트</a>
		        </li>
		         <li class="nav-item">
			          <a class="nav-link active" aria-current="page" href="/shop/emp/addEmp.jsp?empName=<%=(Object)(loginMember.get("empName"))%>">직원 추가</a>
		        </li>
		         <li class="nav-item">
			          <a class="nav-link active" aria-current="page" href="/shop/emp/empOrderList.jsp">고객 주문 정보</a>
		        </li>
		        <li class="nav-item">
			          <a class="nav-link active" aria-current="page" href="/shop/emp/empOne.jsp?empName=<%=(Object)(loginMember.get("empName"))%>">내 정보</a>
		        </li>
		         <li class="nav-item">
		        	  <a class="nav-link active" aria-current="page" href="/shop/emp/empLogout.jsp">로그아웃</a>
	        	</li>
		 	</ul>
	 	</div>
	</div>
</nav>




