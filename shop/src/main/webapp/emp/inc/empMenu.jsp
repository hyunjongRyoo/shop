<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginEmp"));
	
%>
<div>
	<a href="/shop/emp/empList.jsp">사원관리</a> <br>
	<!--  category crud -->
	
	<a href="/shop/emp/categoryList.jsp">카테고리관리</a> <br>
	
	<a href="/shop/emp/goodsList.jsp">상품관리</a><br>
	
	
	<span>
	
		<!-- 개인정보 수정 -->
		<!-- 자기자신 정보 수정 -->	
		<a href="/shop/emp/empOne.jsp">
				<%=(String)(loginMember.get("empName"))%>님
		</a> 반갑습니다
	</span><br>
	
	<a href="/shop/emp/empLogout.jsp">로그아웃</a>
</div>

