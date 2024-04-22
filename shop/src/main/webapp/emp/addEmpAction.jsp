<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shop.dao.empDao"%>
<%@page import="java.sql.*"%>

<%
String empId = request.getParameter("empId");
String empPw = request.getParameter("empPw");
String empName = request.getParameter("empName");
String empJob = request.getParameter("empJob");
String hireDate = request.getParameter("hireDate");

//디버깅
System.out.println(empId +"<--empId");
System.out.println(empPw +"<--empPw");
System.out.println(empName +"<--empName");
System.out.println(empJob +"<--empJob");
System.out.println(hireDate +"<--hiredate");


int row;
row=empDao.insertEmp(empId, empPw, empName, empJob, hireDate);

if(row==1) {
	System.out.println("사원등록 완료");
	response.sendRedirect("/shop/emp/empList.jsp");
}else{
	System.out.println("다시 시도해주세요");
	response.sendRedirect("/shop/emp/addEmp.jsp");
}


%>