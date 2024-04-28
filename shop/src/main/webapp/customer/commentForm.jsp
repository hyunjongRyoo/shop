<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<style>
		@import url(//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css);
       	.rate { display: inline-block;border: 0;margin-right: 15px;}
		.rate > input {display: none;}
		.rate > label {float: right;color: #ddd}
		.rate > label:before {display: inline-block;font-size: 1rem;padding: .3rem .2rem;margin: 0;cursor: pointer;font-family: FontAwesome;content: "\f005 ";}
		.rate .half:before {content: "\f089 "; position: absolute;padding-right: 0;}
		.rate input:checked ~ label, 
		.rate label:hover,.rate label:hover ~ label { color: #f73c32 !important;  } 
		.rate input:checked + .rate label:hover,
		.rate input input:checked ~ label:hover,
		.rate input:checked ~ .rate label:hover ~ label,  
		.rate label:hover ~ input:checked ~ label { color: #f73c32 !important;  } 
	</style>
</head>
	<body>
		<form method="post" action="/shop/customer/commentAction.jsp">
			<table class="table table-hover">
				<tr>
					<td>주문번호</td>
					<td><input type="text" name="ordersNo" value="<%=ordersNo%>"></td>
				</tr>
		
				<tr>
					<td>별점</td>
					<td>
		      			<fieldset class="rate">
			                <input type="radio" id="rating10" name="rating" value="10"><label for="rating10" title="5점"></label>
			                <input type="radio" id="rating9" name="rating" value="9"><label class="half" for="rating9" title="4.5점"></label>
			                <input type="radio" id="rating8" name="rating" value="8"><label for="rating8" title="4점"></label>
			                <input type="radio" id="rating7" name="rating" value="7"><label class="half" for="rating7" title="3.5점"></label>
			                <input type="radio" id="rating6" name="rating" value="6"><label for="rating6" title="3점"></label>
			                <input type="radio" id="rating5" name="rating" value="5"><label class="half" for="rating5" title="2.5점"></label>
			                <input type="radio" id="rating4" name="rating" value="4"><label for="rating4" title="2점"></label>
			                <input type="radio" id="rating3" name="rating" value="3"><label class="half" for="rating3" title="1.5점"></label>
			                <input type="radio" id="rating2" name="rating" value="2"><label for="rating2" title="1점"></label>
		              		 <input type="radio" id="rating1" name="rating" value="1"><label class="half" for="rating1" title="0.5점"></label>
		   				</fieldset>
   					</td>	
	 			</tr>
				<tr>
					<td>상품후기를 작성해주세요</td>
					<td>
						<textarea name="opinion" cols="30" rows="5" id="detail"></textarea>
					</td>
				</tr>
			</table>
			<div>
					<button type="submit">제출</button>
			</div>	
		</form>
	</body>
</html>