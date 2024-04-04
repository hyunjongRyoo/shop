<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!-- controller Layer -->

<%
	// 로그인 세션 세션변수- loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>

<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String sql = "select category, create_date createDate from category ";
	conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "guswhd6656");
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery(); 
	
	ArrayList<HashMap<String, Object>> list
	= new ArrayList<HashMap<String, Object>>();
	
	while(rs.next()){
		HashMap<String, Object> m = new HashMap<String,Object>();
		
		String category =rs.getString("category");
		String createDate =rs.getString("createDate");
		
		m.put("category",category);
		m.put("createDate",createDate);
		
		list.add(m);
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>categoryList</title>
</head>
<body>
<div>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
</div>
<div>
	<a href="/shop/emp/addCategoryForm.jsp">상품등록</a>	
</div>

	<h1>카테고리 리스트</h1>
	<table border="1">
		<tr>
			<th>카테고리</th>
			<th>업로드 시간</th> 
		</tr>
		<%
			for(HashMap<String, Object> m : list) {
		%>
		<tr>
			<td><%=(String)(m.get("category"))%></td>
			<td><%=(String)(m.get("createDate"))%></td>
		</tr>
	<%
			}
	%>
	</table>
		
</body>
</html>