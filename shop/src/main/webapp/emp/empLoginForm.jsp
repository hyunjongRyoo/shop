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
	<style>
	 body {
            background-color: #1BBC9B;
        }
        input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border-radius: 5px;
            border: none;
        }

        .in {
            margin-bottom: 10px;
        }

        #btn {
            background-color: #1BBC9B;
            margin-bottom: 30px;
            color: white;
        }

        a {
            text-decoration: none;
            color: #9B9B9B;
            font-size: 12px;
        }
	</style>
</head>
<body class="container">
	<div class="row">
		<div class="col-4"></div>
			<div class="col-4">
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
            <h1 class="text-center mt-4 fw-bold " style="color: #000000">welcome</h1>	
       			<form method="post" action="/shop/emp/empLoginAction.jsp" >
            		<div>
            			<label class="form-label" style="color: #000000">사원 아이디</label><br>
            			<input type="text" name="empId" class="form-control rounded-pill" value="admin">
           			</div>
       				<div>
            			<label class="form-label" style="color: #000000">사원 비밀번호</label><br>
            			<input type="password" name="empPw" class="form-control rounded-pill" value="1234">
   					</div>
   					<button type="submit"  class="ms-5 mt-3 w-75 btn btn btn-primary" style="color: #000000">로그인</button>
    			</form>
    		</div>
    	</div>
	</body>
</html>