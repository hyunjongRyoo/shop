<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shop.dao.CustomerDAO"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!-- controller layer 요청분석 -->

<%
// 인증분기	 : 세션변수 이름 - loginCustomer
if(session.getAttribute("loginCustomer") == null) {
	response.sendRedirect("/shop/customer/loginForm.jsp");
	return;
}
%>

<%
//페이징 
	int currentPage =1;
	if(request.getParameter("currentPage")!=null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage+"<--currentPage");
	int rowPerPage= 10;
	int startRow = (currentPage-1)*rowPerPage;
	
	
	/*
		null이면 select* from goods 
		null이 아니면 select *from goods where category=?
	*/
%>

<!-- Model Layer -->

<%

	String category =request.getParameter("category");
	System.out.println(category+"<--category");

	//CustomerDAO-페이징
	ArrayList<HashMap<String , Object>> 
	paging= CustomerDAO.paging();
	
	
	int lastPage = 0;  
	int cnt = 0;
	for(HashMap m : paging) {
		if(((String)(m.get("category"))).equals(category)){ //현재 선택한 카테고리(category)와 일치하는 경우 해당 카테고리의 상품 수를 cnt에 저장합니다.
			cnt = (Integer)(m.get("cnt")); //그렇지 않은 경우 모든 카테고리의 상품 수를 cnt에 누적하여 저장합니다.
			break;
		}
		cnt += (Integer)(m.get("cnt"));
	}
	
	if(cnt % rowPerPage == 0){
		lastPage = cnt / rowPerPage;
	} else {
		lastPage = cnt / rowPerPage + 1;
	}
	
	ArrayList<HashMap<String , Object>> 
	goodsList= CustomerDAO.goodsList(category, startRow, rowPerPage);
	
	
	//resultset으로 부터 가져와서 hashmap에 담아서 리스트에 추가
%>

<!-- View Layer -->

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>goodsList</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<style>
	a{
	text-decoration: none;
	color:#000000;
	}
	div{
	text-align: center;
	}
	
    .goods-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-top: 20px;
        }
        .goods-item {
            width: calc(33.33% - 10px); /* 3개의 요소가 한 줄에 들어가도록 폭 조절 */
            margin-bottom: 20px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            padding: 10px;
        }
        .goods-item img {
            max-width: 100%;
            height: auto;
        }
	</style>
</head>
<body>
  	<div class="row">
  	<jsp:include page ="/customer/include/customerMenu.jsp"></jsp:include> 
		<div class="col-2" >
		 
			<!-- 서브메뉴 카테고리별 상품리스트 -->
	
			
				
			<div>
		<%
				for(HashMap m : paging) {
		%>
				<a href="/shop/customer/customerGoodsList.jsp?category=<%=(String)(m.get("category"))%>">
					<%=(String)(m.get("category"))%>
					(<%=(Integer)(m.get("cnt"))%>) <!-- 카테고리별 상품 숫자,상품 목록 -->
				</a>	
		<%		
				}
		%>
	</div>
	
		</div>
		<div class="col-8" >
	<div class="goods-container">
			
	<%
			for(HashMap m: goodsList) { 
	%>
  <!-- map으로 값 받아주기 -->
  
 <div class="goods-item">
                <img src="/shop/upload/default.jpg" alt="??">
                <br>
               <a href="/shop/customer/customerGoodsOne.jsp?goodsNo=<%= m.get("goodsNo") %>&goodsPrice=<%= m.get("goodsPrice") %>">
                    품명:<%=(String)(m.get("goodsTitle"))%>
                </a> <br>
                <%=(Integer)(m.get("goodsPrice"))%>원
            </div>
            <%
                }
            %>
        </div>
	</div>
	<!-- 페이징 -->
	<div>
		<%
			if(currentPage>1 && currentPage<lastPage){
		%>
				<a href="/shop/customer/customerGoodsList.jsp?currentPage=1&category=<%=category%>">첫장</a>
				<a href="/shop/customer/customerGoodsList.jsp?currentPage- 1 %>&category=<%=category%>">이전</a>
				<a href="/shop/customer/customerGoodsList.jsp?currentPage+ 1 %>&category=<%=category%>">다음</a>  
				<a href="/shop/customer/customerGoodsList.jsp?currentPage=lastPage %>&category=<%=category%>">마지막장</a>  
		<%
			}else if(currentPage==1){
		%>
				<a href="/shop/customer//customerGoodsList.jsp?currentPage=<%=currentPage + 1 %>&category=<%=category%>">다음</a>
				<a href="/shop/customer//customerGoodsList.jsp?currentPage=<%=lastPage %>&category=<%=category%>">마지막장</a>  
		<%
		
			}else{
		%>
				<a href="/shop/customer/customerGoodsList.jsp?currentPage=1&category=<%=category%>">처음</a>
				<a href="/shop/customer/customerGoodsList.jsp?currentPage=- 1 %>&category=<%=category%>">이전</a>
		<% 
			}
		%>
	</div>
	</div>
	<div class="col-2" ></div>
	</div>
</body>

</html>