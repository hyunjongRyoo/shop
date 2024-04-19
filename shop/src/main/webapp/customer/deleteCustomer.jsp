<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>deleteCustomerForm</title>
</head>
<body>
	<form method="post" href="deleteCustomerForm.jsp">
		<div>
		<label for="id">id</label>
		<input type="email" id="id" name="id">
		</div>
		<div>
		<label for="pw">PW</label>
		<input type="password" id="pw" name="pw">
		</div>
		<button type="submit">삭제하기</button>
	</form>
</body>
</html>