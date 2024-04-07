<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!-- controller layer 요청분석 -->

<%
// 인증분기	 : 세션변수 이름 - loginEmp
if(session.getAttribute("loginEmp") == null) {
	response.sendRedirect("/shop/emp/empLoginForm.jsp");
	return;
}
%>

<%
//페이징 
	int currentPage =1;
	if(request.getParameter("currentPage")!=null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage+"<--currentPage");
	int rowPerPage= 10;
	int startRow = (currentPage-1)*rowPerPage;
	
	String category =request.getParameter("category");
	System.out.println(category+"<--category");
	/*
		null이면 select* from goods 
		null이 아니면 select *from goods where category=?
	*/
%>

<!-- Model Layer -->

<%

	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "guswhd6656");
	PreparedStatement stmt1 = null;
	
	String sql1 = "select category, count(*) cnt from goods group by category order by category";
	stmt1 = conn.prepareStatement(sql1);
	ResultSet rs1 = null;
	rs1 = stmt1.executeQuery();
	
	ArrayList<HashMap<String, Object>> categoryList =
			new ArrayList<HashMap<String, Object>>();
	while(rs1.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>(); //키 & 벨류
		m.put("category", rs1.getString("category"));
		m.put("cnt", rs1.getInt("cnt"));
		categoryList.add(m);
	}
	
	
	int lastPage = 0;  
	int cnt = 0;
	for(HashMap m : categoryList) {
		if(((String)(m.get("category"))).equals(category)){ //현재 선택한 카테고리(category)와 일치하는 경우 해당 카테고리의 상품 수를 cnt에 저장합니다.
			cnt = (Integer)(m.get("cnt")); //그렇지 않은 경우 모든 카테고리의 상품 수를 cnt에 누적하여 저장합니다.
			break;
		}
		cnt += (Integer)(m.get("cnt"));
	}
	
	if(cnt % rowPerPage == 0){
		lastPage = cnt / rowPerPage;
	} else {
		lastPage = cnt / rowPerPage + 1;
	}
	
	String sql2 = null; //전체 상품 가져옴 
	PreparedStatement stmt2 = null;
	if(category == null || category.equals("null")){
		sql2 = "select goods_no goodsNo, category, filename,emp_id empId, goods_title " + 
				"goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, " + 
				"update_date updateDate, create_date createDate from goods order by goods_no asc limit ?, ?";
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1, startRow);
		stmt2.setInt(2, rowPerPage);
		System.out.println(stmt2);
	} else { //해당 카테고리에 속하는 상품만 가져옴
		sql2 = "select goods_no goodsNo, category,filename, emp_id empId, goods_title " + 
				"goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, " + 
				"update_date updateDate, create_date createDate from goods where category = ? order by goods_no asc limit ?, ?";
		
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, category);
		stmt2.setInt(2, startRow);
		stmt2.setInt(3, rowPerPage);
		System.out.println(stmt2);
	}
	
	
	ResultSet rs2 = null;
	rs2 = stmt2.executeQuery();
	
	ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
	
	while(rs2.next()){
		HashMap<String, Object> m = new HashMap<String, Object>();		
		m.put("goodsNo", rs2.getInt("goodsNo"));
		m.put("category", rs2.getString("category"));
		m.put("filename", rs2.getString("filename"));
		m.put("empId", rs2.getString("empId"));
		m.put("goodsTitle", rs2.getString("goodsTitle"));
		m.put("goodsContent", rs2.getString("goodsContent"));
		m.put("goodsPrice", rs2.getInt("goodsPrice"));
		m.put("goodsAmount", rs2.getInt("goodsAmount"));
		m.put("updateDate", rs2.getString("updateDate"));
		m.put("createDate", rs2.getString("createDate"));
		
		goodsList.add(m);
		
	}
	//resultset으로 부터 가져와서 hashmap에 담아서 리스트에 추가
%>

<!-- View Layer -->

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>goodsList</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<style>
	a{
	text-decoration: none;
	color:#000000;
	}
	div{
	text-align: center;
	}
	</style>
</head>
<body="container">
  	<div class="row">
  	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
		<div class="col" >
		  	<jsp:include page="/emp/inc/sidebar.jsp"></jsp:include>
			<div>
				<a href="/shop/emp/addGoodsForm.jsp">상품등록</a>	
			</div>
			<!-- 서브메뉴 카테고리별 상품리스트 -->
			<div>
				<a href="/shop/emp/goodsList.jsp">전체</a>
			</div>
			
				
			<div>
		<%
				for(HashMap m : categoryList) {
		%>
				<a href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
					<%=(String)(m.get("category"))%>
					(<%=(Integer)(m.get("cnt"))%>) <!-- 카테고리별 상품 숫자,상품 목록 -->
				</a>	
		<%		
				}
		%>
	</div>
	
		</div>
		<div class="col-8" >
	<div>
		<table border="2">
			<tr>
				<th>품번</th>
				<th>분류</th>
				<th>제품 사진</th>
				<th>직급</th>
				<th>품명</th>
				<th>콘텐츠</th>
				<th>가격</th>
				<th>수량</th>
				<th>수정 날짜</th>
				<th>등록 날짜</th>
			</tr>
	<%
			for(HashMap m: goodsList) { 
	%>
			<tr>  <!-- map으로 값 받아주기 -->
				<td><%=(Integer)(m.get("goodsNo"))%></td>
				<td><%=(String)(m.get("category"))%></td>
				<td>
       			 <img src="/shop/upload/default.jpg" alt="??">
    			</td>
				<td><%=(String)(m.get("empId"))%></td>
				<td><%=(String)(m.get("goodsTitle"))%></td>
				<td><%=(String)(m.get("goodsContent"))%></td>
				<td><%=(Integer)(m.get("goodsPrice"))%></td>
				<td><%=(Integer)(m.get("goodsAmount"))%></td>
				<td><%=(String)(m.get("updateDate")) %></td>
				<td><%=(String)(m.get("createDate")) %></td>
			</tr>
		<%
			}
		%>
	
		</table>
	</div>
	<!-- 페이징 -->
	<div>
		<%
			if(currentPage>1 && currentPage<lastPage){
		%>
				<a href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>">첫장</a>
				<a href="/shop/emp/goodsList.jsp?currentPage- 1 %>&category=<%=category%>">이전</a>
				<a href="/shop/emp/goodsList.jsp?currentPage+ 1 %>&category=<%=category%>">다음</a>  
				<a href="/shop/emp/goodsList.jsp?currentPage=lastPage %>&category=<%=category%>">마지막장</a>  
		<%
			}else if(currentPage==1){
		%>
				<a href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage + 1 %>&category=<%=category%>">다음</a>
				<a href="/shop/emp/goodsList.jsp?currentPage=<%=lastPage %>&category=<%=category%>">마지막장</a>  
		<%
		
			}else{
		%>
				<a href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>">처음</a>
				<a href="/shop/emp/goodsList.jsp?currentPage=- 1 %>&category=<%=category%>">이전</a>
		<% 
			}
		%>
	</div>
	</div>
	<div class="col-2" ></div>
	</div>
</body>

</html>