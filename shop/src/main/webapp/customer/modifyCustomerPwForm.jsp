<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<body>
	<div class="row">
		<jsp:include page ="/customer/include/customerMenu.jsp"></jsp:include> 
		<div class="col-2"></div>
	 	<div class="col-2"></div>
		<div class="col-4">
			<h1>비밀번호 변경하기</h1>
				<form method="post" action="/shop/customer/modifyCustomerPw.jsp">
					<div>
						<label for="mail">email</label>
						<input type="email" id="mail" name="mail" >
					</div>
					<div>
						<label for="OldPw">OldPw</label>
						<input type="password" id="OldPw" name="OldPw" >
					</div>
					<div>
						<label for="newPw">newPw</label>
						<input type="password" id="newPw" name="newPw" >
					</div>
					<div style="text-align">
						<button type="submit" class="btn btn-primary">변경하기</button>	
					</div>	
				</form>
			</div>
		<div class="col-4"></div>
	</div>
</body>
</html>