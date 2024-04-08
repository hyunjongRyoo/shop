<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>


<!-- Controller Layer -->

<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>

<%
	// request 분석
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 25;
	int startRow = (currentPage-1)*rowPerPage;

// <!-- Model Layer -->

	// 특수한 형태의 데이터(RDBMS:mariadb) --관계형 데이터베이스를 업데이트하고 만들고 관리하는데 사용하는 프로그램
	// -> API사용(JDBC API)하여 자료구조(ResultSet) 취득 
	// -> 일반화된 자료구조(ArrayList<HashMap>)로 변경 -> 모델 취득
	Class.forName("org.mariadb.jdbc.Driver");
	String sql = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by hire_date desc limit ?, ?";
	Connection conn = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "guswhd6656");
	PreparedStatement stmt = conn.prepareStatement(sql);

	stmt.setInt(1, startRow);
	stmt.setInt(2, rowPerPage);
	ResultSet rs  = stmt.executeQuery(); 
	// JDBC API 종속된 자료구조 모델 ResultSet  -> 기본 API 자료구조(ArrayList)로 변경
	
	ArrayList<HashMap<String, Object>> list
		= new ArrayList<HashMap<String, Object>>();
	
	// ResultSet -> ArrayList<HashMap<String, Object>>
	while(rs.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>();
		String empId = rs.getString("empId");
		String empName = rs.getString("empName");
		String empJob = rs.getString("empJob");
		String hireDate = rs.getString("hireDate");
		String active = rs.getString("active");
		
		m.put("empId", empId);
		m.put("empName", empName);
		m.put("empJob", empJob);
		m.put("hireDate", hireDate);
		m.put("active", active);
		
		list.add(m);
		
	}
	
	String sql2 = "select count(*) cnt from emp";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	ResultSet rs2 =stmt2 .executeQuery();
	
	int count=0;
	if(rs2.next()){
			count =rs2.getInt("cnt");
	}
	
	int lastPage =0;
	if(count % rowPerPage == 0){
		lastPage = count/rowPerPage;
	}else{
		lastPage=count /rowPerPage +1 ;
	}
	
%>

<!-- View Layer : 모델(ArrayList<HashMap<String, Object>>) 출력 -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<style>
	
	a{
	text-decoration: none;
	
	color: #000000;
	}
	
	div{
	text-align: center;
	}
	

	
	</style>
</head>
<body ="container">
  	<div class="row">
  	<jsp:include page ="/emp/inc/empMenu.jsp"></jsp:include> 
		<div class="col-2" >
			<jsp:include page="/emp/inc/sidebar.jsp"></jsp:include>
			<!-- empMenu.jsp include :주체(서버) vs redirect (주체:클라이언트) -->
			<!-- shop부터 시작하지 않기 // 주체가 서버이기때문이다 -->
	 	</div>
	 	<div class="col-2" ></div>
	
		<div class="col">
		<h1 style="text-align: center">사원 목록</h1><br>
		<table  style="border=1 solid black;">
			<tr>
				<th>사원 이메일</th>
				<th>사원 이름</th>
				<th>부서</th>
				<th>고용일</th>
				<th>관리 권한</th>
			</tr>
		<%
			for(HashMap<String, Object> m : list) {
		%>
				<tr>
					<td><%=(String)(m.get("empId"))%></td>
						<td>
							<a href="/shop/emp/empOne.jsp?empName=<%=(String)(m.get("empName"))%>">
							<%=(String)(m.get("empName"))%>
							</a>
						</td>
					<td><%=(String)(m.get("empJob"))%></td>
					<td><%=(String)(m.get("hireDate"))%></td>
					<td>
						<%
						HashMap<String, Object> sm = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
						if((Integer)(sm.get("grade"))> 0)
							{
						%>	
					<!--  modifyEmpAction에서 empId와 active 값 두개를 받기 때문에 두개를 a 태그로 넘겨준다 -->
						<a href="/shop/emp/modifyEmpActive.jsp?empId=<%=(String)(m.get("empId")) %>&active=<%=(String)(m.get("active"))%>">
							<%=(String)(m.get("active"))%>
						</a>
						<%
						}
						%>
					</td>
				</tr>
		<%		
			}
		%>
	</table>
			<div class="position-absolute bottom-0 start-50 translate-middle-x">
					<%
						if(currentPage>1 && currentPage<lastPage){
					%>
						<a href="/shop/emp/empList.jsp?currentPage=<%=1%>">첫장 </a>
						<a href="/shop/emp/empList.jsp?currentPage=<%=currentPage-1%>">이전</a>
						<a href="/shop/emp/empList.jsp?currentPage=<%=currentPage+1%>" >다음</a>  
						<a href="/shop/emp/empList.jsp?currentPage=<%=lastPage%>">마지막장</a>  
					<%
						}else if(currentPage==1){
					%>
						<a href="/shop/emp/empList.jsp?currentPage=<%=currentPage+1%>" >다음</a>  
						<a href="/shop/emp/empList.jsp?currentPage=<%=lastPage%>"  >마지막장</a>  
					<%
					
						}else{
					%>
						<a href="/shop/emp/empList.jsp?currentPage=<%=currentPage=1%>"  >첫장 </a>
						<a href="/shop/emp/empList.jsp?currentPage=<%=currentPage-1%>"  >이전</a>
					<% 
						}
					%>
			 </div>
		</div>
	<div class="col"></div>
</body>
</html>
