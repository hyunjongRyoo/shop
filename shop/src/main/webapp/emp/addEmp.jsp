<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>emp 추가 폼</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
	<body>
		<div class="row">
		<!--상단바& 사이드바 -->
  			<jsp:include page ="/emp/inc/empMenu.jsp"></jsp:include> 
				<h1 style="text-align: center">직원추가 페이지</h1>
				<div class="col-2" >
					<jsp:include page="/emp/inc/sidebar.jsp"></jsp:include>
				</div>
				<div class="col-2" ></div>
				<!--리스트 -->
				<div class="col-4">
						<form method="post" action="/shop/emp/addEmpAction.jsp" class="position-absolute top-50 start-50 translate-middle">
							<table class="table table-hover">
								<tr>
									<td>이메일</td>
									 <td><input type="email" empId="id" name="empId"></td>
								 </tr>
								 <tr>
							 		<td>비밀번호</td>
							 		<td><input type="password" id="empPw" name="empPw"></td>
								 </tr>
								  <tr>
							 		<td>이름</td>
							 		<td><input type="text" id="empName" name="empName"></td>
								 </tr>
							  	 <tr>
							 		<td>파트</td>
							 		<td><input type="text" id="empJob" name="empJob"></td>
							 	</tr>	
							  	<tr>
							 		<td>채용날짜</td>
							 	<td><input type="date" id="hireDate" name="hireDate"></td>
							 </tr>		
							</table>
						<div>
							<button type="submit" class="btn btn-primary">추가하기</button>
						</div>
					</form>
				</div>
			<div class="col-4"></div>
		</div>
	</body>
</html>