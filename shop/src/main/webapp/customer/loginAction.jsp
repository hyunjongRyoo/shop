<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.net.*"%>
<%@ page import = "java.util.*" %>

<%
	String mail =request.getParameter("mail");
	String pw = request.getParameter("pw");
	
	//디버깅
	System.out.println(mail +"<--mail");
	System.out.println(pw +"<--pw");
	
	String sql="select mail, pw from customer where mail=? , pw= password(?)";
	
	Class.forName("org.mariadb.jdbc.Driver");
	
	Connection conn= DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "guswhd6656");
	PreparedStatement stmt = null;
	stmt= conn.prepareCall(sql);	
	stmt.setString(1,mail);
	stmt.setString(2,pw);
	System.out.println(stmt);
	
	ResultSet rs = null;
	rs = stmt.executeQuery();

	
	if(rs.next()) {
		System.out.println("로그인 성공");
		
		HashMap<String,Object> loginCustomer = new HashMap<String, Object>();
		
		loginCustomer.put("mail", rs.getString("mail"));
		loginCustomer.put("name", rs.getString("name"));
		loginCustomer.put("birth", rs.getString("birth"));
		loginCustomer.put("gender", rs.getString("gender"));
		
		//로그인 성공시 세션에 정보를 넣어줌 
		session.setAttribute("loginCustomer",loginCustomer); 
		
		//디버깅(loginCustomer 세션변수 )
		HashMap<String , Object> m =  (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
		System.out.println((String)(m.get("mail")));
		System.out.println((String)(m.get("name")));
		System.out.println((String)(m.get("birth")));
		System.out.println((String)(m.get("gender")));
		
		response.sendRedirect("/shop/emp/goodsList.jsp");
		
	}else{
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("check your Id & Pw", "utf-8");
		response.sendRedirect("/shop/customer/LoginForm.jsp?errMsg=" +errMsg);
		
	}
%>
