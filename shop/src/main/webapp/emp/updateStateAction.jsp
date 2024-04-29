<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shop.dao.ordersDAO"%>

    <%
    	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
    	String state = request.getParameter("state");
    	int row = ordersDAO.updateState(state, ordersNo);
    	
    	if(row==1){
    		System.out.println("변경에 성공하였습니다");
    		response.sendRedirect("/shop/emp/empOrderList.jsp");
    	}else{
    		System.out.println("변경에 실패했습니다");
    	}
    %>