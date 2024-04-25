<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shop.dao.GoodsDAO"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!-- controller layer 요청분석 -->

<%
// 인증분기	 : 세션변수 이름 - loginEmp
if(session.getAttribute("loginEmp") == null) {
	response.sendRedirect("/shop/emp/empLoginForm.jsp");
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
	
%>



<%
	
	
	String category =request.getParameter("category");
	System.out.println(category+"<--category");
	

		
	ArrayList<HashMap<String , Object>> 
	paging= GoodsDAO.paging();
	
	
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
	goodsList= GoodsDAO.goodsList(category,startRow,rowPerPage);

	

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
            width: calc(33.33% - 10px); 
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
	  			<!--상단 바 -->
	  		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
				<div class="col-2" >
			  		<jsp:include page="/emp/inc/sidebar.jsp"></jsp:include>
						<div>
							<a href="/shop/emp/addGoodsForm.jsp">상품등록</a>	
						</div>
						<!-- 카테고리별 상품리스트 -->
						<div>
							<a href="/shop/emp/goodsList.jsp">전체</a>
						</div>	
					<div>
						<%
							for(HashMap m : paging) {
						%>
							<a href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
								<!-- 카테고리별 상품 숫자,상품 목록 -->
								<div>
									<%=(String)(m.get("category"))%>
									(<%=(Integer)(m.get("cnt"))%>) 
								</div>
							</a>	
						<%		
							}
						%>
					</div>
				</div>
				<!--메인 상품 표시되는 부분 -->
	<div class="col-8" >
		<div class="goods-container">			
	  <!-- map으로 값 받아주기 -->
			<%
				for(HashMap m: goodsList) { 
			%>
	 			<div class="goods-item">
	 			<!-- 사진 -->
				<div>
	                <img src="/shop/upload/<%=(String)(m.get("filename"))%>">
	             </div>
	             <!-- 제품명 :클릭시 goodsOne으로 이동-->
	             	<div>
	                	<a href="/shop/emp/goodsOne.jsp?goodsNo=<%=(int)(m.get("goodsNo"))%>">
	                    	품명:<%=(String)(m.get("goodsTitle"))%>
	                	</a>
	            	</div>
	            	<!-- 가격 -->
		            <div>
		                가격:<%=(Integer)(m.get("goodsPrice"))%>원
		            </div>
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
							<a href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>">첫장</a>
							<a href="/shop/emp/goodsList.jsp?currentPage- 1 %>&category=<%=category%>">이전</a>
							<a href="/shop/emp/goodsList.jsp?currentPage+ 1 %>&category=<%=category%>">다음</a>  
							<a href="/shop/emp/goodsList.jsp?currentPage=lastPage %>&category=<%=category%>">마지막장</a>  
					<%
						}else if(currentPage==1){
					%>
							<a href="/shop/emp/goodsList.jsp?currentPage=<%=currentPage + 1 %>&category=<%=category%>">다음</a>
							<a href="/shop/emp/goodsList.jsp?currentPage=<%=lastPage %>&category=<%=category%>">마지막장</a>  
					<%
					
						}else{
					%>
							<a href="/shop/emp/goodsList.jsp?currentPage=1&category=<%=category%>">처음</a>
							<a href="/shop/emp/goodsList.jsp?currentPage=- 1 %>&category=<%=category%>">이전</a>
					<% 
						}
					%>
				</div>
			</div>
		<div class="col-2" ></div>
	</body>
</html>