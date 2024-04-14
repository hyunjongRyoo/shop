<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<%
	HashMap<String,Object> loginMember 
		= (HashMap<String,Object>)(session.getAttribute("loginCustomer"));
	
%>

<!-- 사이드바 영역 -->
<div class="sidebar">
	<!-- 프로필 이미지 -->
	<div style="text-align: center">
	<div>	
		<img  src="/shop/upload/default.jpg"
		width="70%" style="border-radius: 50%; margin-bottom">
		</div>
		<div>
		  <a class="navbar-brand" href="/shop/customer/customerGoodsList.jsp">
    		<%=(String)(loginMember.get("name"))%>님
		</a>
		</div>
		
	</div>
</div>