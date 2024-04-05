<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
String errMsg = request.getParameter("errMsg");

System.out.println(errMsg + " <-- loginForm param errMsg");
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

</head>
<body>
 <%
               if(errMsg != null) {
            %>
                  <%=errMsg %>
            <%
               } else {
            %>
                  <div>&nbsp;</div>
            <%
               }
            %>
            <h1 style="text-align: center"> 사원 로그인 창</h1>
            <form method="post" action="/shop/emp/empLoginAction.jsp" class="position-absolute top-50 start-50 translate-middle">
            	<div>
            		<label>사원 아이디</label><br>
            		<input type="text" name="empId" value="admin">
           		</div>
           		<div>
            		<label>사원 비밀번호</label><br>
            		<input type="password" name="empPw" value="1234">
           		</div>
           		<button type="submit" class="ms-5 mt-3">로그인</button>
           		
            </form>
</body>
</html>
