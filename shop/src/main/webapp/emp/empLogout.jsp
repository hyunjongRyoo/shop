<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	//session.removeAttribute("loginEmp");	


	System.out.println(session.getId()+"<--session.invalidate()호출전");
	session.invalidate(); // 세션공간을 초기화 하였다.(포맷))

	response.sendRedirect("/shop/emp/empLoginForm.jsp");
 %>