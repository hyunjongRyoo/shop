<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	//  customer 로그인 인증 분기
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
%>
<%
	String checkedEmail = request.getParameter("checkEmail");
	String check = request.getParameter("check");

	System.out.println(checkedEmail + "<-- checkedEmail");
	System.out.println(check + "<-- check");
	
	//검사한 이메일 checkEmail, 검사 완료 후 사용가능 판정난 이메일 checkedEmail
	String checkEmail = "";
	String checkMsg = "사용 가능한 이메일입니다.";
	
	if(check == null){
		check = "";
		checkMsg = "";
	}
	
	if(checkedEmail == null){
		checkedEmail = "";
	} else{
		checkEmail = checkedEmail;
	}
	
	if(check.equals("X")){
		checkedEmail = "";
		checkMsg = " 이미 존재하는 아이디입니다";
	}

	 %>
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
				<h1>회원가입</h1>
				
				<form  method="post" action="/shop/customer/customerIdcheck.jsp">
					
					<div>
						EmailCheck : <input type="email" name="customerEmail" value="<%=checkEmail %>">
						<button type="submit">중복 확인 </button>
					</div>
				
				</form>
				<form method="post" action="/shop/customer/addCustomerAction.jsp">
					<div>
						<label for="mail">E-mail</label>
						<input type="email" id="mail" name="mail" placeholder="abcd@mail.com">
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
						<input type="radio" id="male" name="gender" value="남">
						
						<label for="female">여</label>
						<input type="radio" id="female" name="gender" value="여">
					</div>
					
					<div>
					<button type="submit" class="ms-5 mt-3">가입하기</button>		
					</div>			
				</form>
			</div>
		<div class="col-4"></div>
	</div>
</body>
</html>


