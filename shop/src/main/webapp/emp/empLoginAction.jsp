<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shop.dao.empDao"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") != null) { //이미 로그인을 한 상태라면
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>

<%
	String empId = request.getParameter("empId");   //getParameter("a")의 값과 결과 값이 일치해야함 
	String empPw = request.getParameter("empPw");
	System.out.println(empId+ "<--empId"); // 디버깅 코드 , 결과 값이랑 스펠링 같은지 확인 
	System.out.println(empPw +"<--empPw");

	
	HashMap<String , Object> loginEmp =empDao.loginEmp(empId, empPw);
	
	
	
	//2.model

	if(loginEmp == null) {
	
		System.out.println("로그인 실패");		
		String errMsg = URLEncoder.encode("check your Id & Pw", "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg=" +errMsg);
	}else{
		System.out.println("로그인 성공 ");
		response.sendRedirect("/shop/emp/empList.jsp");
		
		session.setAttribute("loginEmp", loginEmp);  // 키 / 벨류 // 로그인 성공시 세션에 로그인 정보를 저장해줘야 한다
		
	
	}
	

%>
