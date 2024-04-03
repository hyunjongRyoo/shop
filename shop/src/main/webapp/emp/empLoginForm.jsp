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
            <h1> 사원 로그인 창</h1>
            <form method="post" action="/shop/emp/empLoginAction.jsp">
            	<div>
            		<label>사원 아이디</label>
            		<input type="text" name="empId" value="admin">
           		</div>
           		<div>
            		<label>사원 비밀번호</label>
            		<input type="password" name="empPw" value="1234">
           		</div>
           		<button type="submit">로그인</button>
           		
            </form>
</body>
</html>
