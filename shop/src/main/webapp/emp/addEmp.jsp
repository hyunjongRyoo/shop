<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<h1 style="text-align: center">직원추가 페이지</h1>
<body>
	<form method="post" action="/shop/emp/addEmpAction.jsp" class="position-absolute top-50 start-50 translate-middle">
		<div>
		<label for="empId">아이디(이메일):</label> 
		<input type="email" empId="id" name="empId">
		</div>
		
		<div>
		<label for="empPw">비밀번호:</label>
		<input type="password" id="empPw" name="empPw">
		</div>
		
		<div>
		<label for="empName">이름:</label>
		<input type="text" id="empName" name="empName">
		</div>
			
		<div>
		<label for="empJob">파트:</label>
		<input type="text" id="empJob" name="empJob">
		</div>
		
		<div>
		<label for="hireDate">채용날짜</label>
		<input type="date" id="hireDate" name="hireDate">
		</div>
		
		
		<div>
		<button type="submit">추가하기</button>
		</div>
	</form>
</body>
</html>