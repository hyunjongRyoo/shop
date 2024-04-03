<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@page import="java.sql.*" %>
<!-- Controller Layer -->
<%
	request.setCharacterEncoding("UTF-8");
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<!-- Session 설정값 : 입력시 로그인 emp의 emp_id값이 필요해서... -->
<%
HashMap<String,Object> loginMember = (HashMap<String,Object>)(session.getAttribute("loginEmp"));
%>
<%
String category = request.getParameter("category");
String empId = (String)(loginMember.get("empId"));
String goodsTitle =request.getParameter("goodsTitle");
String goodsPrice =request.getParameter("goodsPrice");
String goodsAmount =request.getParameter("goodsAmount");
String goodsContent =request.getParameter("goodsContent");

String sql1 ="insert into goods(category,emp_id,goods_title, goods_price, goods_amount,goods_content) values (?, ?, ?, ?, ?, ?)";
Class.forName("org.mariadb.jdbc.Driver");
Connection conn = null;
conn = DriverManager.getConnection(
	"jdbc:mariadb://127.0.0.1:3306/shop", "root", "guswhd6656");
PreparedStatement stmt1 = null;

stmt1 = conn.prepareStatement(sql1);
stmt1.setString(1, category);
stmt1.setString(2, empId);
stmt1.setString(3, goodsTitle);
stmt1.setString(4, goodsPrice);
stmt1.setString(5, goodsAmount);
stmt1.setString(6, goodsContent);
System.out.println(stmt1);
%>

<!-- Controller Layer -->
<%
	int row=stmt1.executeUpdate();

	if(row==1){
		System.out.println("등록하였습니다");
	}else{
		System.out.println("등록에 실패하였습니다");
	}
	 response.sendRedirect("/shop/emp/goodsList.jsp");
%>
