<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	//  customer 로그인 인증 분기
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
%>

<%
	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	
	//디버깅
	System.out.println(mail +"<--mail");
	System.out.println(pw +"<--pw");
	System.out.println(name +"<--name");
	System.out.println(birth +"<--birth");
	System.out.println(gender +"<--gender");
	
	String sql ="insert into customer (mail,pw,name,birth,gender) values (?,password(?), ? ,? , ?)";
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn= DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "guswhd6656");
	
	PreparedStatement stmt = null;
	

	stmt = conn.prepareStatement(sql);
	stmt.setString(1, mail);
	stmt.setString(2, pw);
	stmt.setString(3, name);
	stmt.setString(4, birth);
	stmt.setString(5, gender);
	System.out.println(stmt);
	
	
	int row=stmt.executeUpdate();
	
	if(row==1) {
		System.out.println("회원가입을 축하합니다");
		response.sendRedirect("/shop/emp/loginForm.jsp]");
	}else{
		System.out.println("다시 시도해주세요");
		response.sendRedirect("/shop/customer/addCustomerForm.jsp]");
	}
	
	
%>