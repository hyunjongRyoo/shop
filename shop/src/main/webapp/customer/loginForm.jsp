<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//  customer 로그인 인증 분기
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인폼</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<style>
     body{
   		background-size: cover;
        height: 100vh;
        display: flex;
        flex-direction: column;
        justify-content: center;
   }
</style>
</head>
<body class="container">
	<div class="row">
		<div class="col-4"></div>
			<div class="col-4">
				<h1 class="text-center mt-4 fw-bold " style="color: #0000000">Welcome</h1>
					<form method="post" action="/shop/customer/loginAction.jsp">
						<div class="ms-5 mb-3 mt-3 w-75">
           					 <label class="form-label" style="color: #0000000">ID</label>
							<input type=email id="mail" class="form-control rounded-pill" name="mail">
						</div>
						<div class="ms-5 mb-3 w-75">
              				<label class="form-label" style="color: #0000000">Pw️</label>
							<input type="password" class="form-control rounded-pill" id="pw" name="pw">
						</div>
						<div>
							<button type="submit" class="ms-5 mt-3 w-75 btn" style="color: #000000">sign up</button>
						</div>
					</form>
				</div>
		<div class="col-4"></div>
	</div>
</body>
</html>