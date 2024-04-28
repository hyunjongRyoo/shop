<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="shop.dao.CommentDAO"%>
<!DOCTYPE html>
<%
	//로그인 인증 분기
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginForm.jsp");
		return;
	}
%>
<%
	//개개인의 주문정보를 판별하기위해 mail값을 받아줌
	HashMap<String, Object> sessionInfo = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));//mail 값 
	String mail = (String)(sessionInfo.get("mail"));
	//리뷰에 필요한 주문번호 별점 리뷰내용 값  추가 
	int ordersNo = Integer.parseInt(request.getParameter("odersNo"));
	int score = Integer.parseInt(request.getParameter("score"));
	String content = request.getParameter("content");

	int row=CommentDAO.addCommentAction(ordersNo,score,content);
	if(row ==1){
		System.out.println("리뷰가 추가되었습니다");
		response.sendRedirect("/shop/customer/orderList.jsp?mail="+mail);
	}else{
		System.out.println("리뷰를 다시 작성해주세요");
		response.sendRedirect("/shop/customer/commentForm.jsp?mail="+mail);
	}
	
%>