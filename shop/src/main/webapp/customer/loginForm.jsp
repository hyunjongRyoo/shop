<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//  customer 로그인 인증 분기
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/emp/goodsList.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인폼</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body class="container">
	<div class="row">
			<div class="col-4"></div>
				<div class="col-4">
					<h1> 로그인 페이지</h1>
						<form method="post" action="loginAction.jsp">
						<div>
							<label for="mail">이메일</label>
							<input type=email id="mail" name="mail">
						</div>
					
						<div>
							<label for="pw">비밀번호 </label>
							<input type="password" id="pw" name="pw">
						</div>
					
						<div>
							<button type="submit">로그인</button>
						</div>
					</form>
				</div>
			<div class="col-4"></div>
		</div>
</body>
</html>