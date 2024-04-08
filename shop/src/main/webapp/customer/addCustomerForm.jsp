<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입 폼</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body class="container">
	<div class="row">
		<div class="col-4"></div>
			<div class="col-4">
				<h1>로그인 멘트자리</h1>
				<form method="post" action="/shop/customer/addCustomerAction.jsp">
					<div>
						<label for="mail">E-mail</label>
						<input type="email" id="mail" name="email" placeholder="abcd@mail.com">
					</div>
					
					<div>
						<label for="pw">비밀번호</label>
						<input type="password" id="pw" name="pw">
					</div>
					
					<div>
						<label for="name">이름</label>
						<input type="text" id="name" name="name">
					</div>
					
					<div>
						<label for="birth">생년월일</label>
						<input type="date" id="birth" name="birth">
					</div>
					
					<div>
						<label>성별</label>
						<label for="male">남</label>
						<input type="radio" id="male" name="gender" value="male">
						
						<label for="female">여</label>
						<input type="radio" id="female" name="gender" value="female">
					</div>
					
					<div>
					<button type="submit" class="ms-5 mt-3">로그인</button>		
					</div>			
				</form>
			</div>
		<div class="col-4"></div>
	</div>
</body>
</html>


