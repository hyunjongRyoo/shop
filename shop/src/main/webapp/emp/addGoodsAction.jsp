<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shop.dao.GoodsDAO"%>
<%@ page import="java.util.*"%>
<%@page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<!-- Controller Layer -->
<%
	request.setCharacterEncoding("UTF-8");
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<!-- Session 설정값 : 입력시 로그인 emp의 emp_id값이 필요해서... -->
<%
HashMap<String,Object> loginMember = (HashMap<String,Object>)(session.getAttribute("loginEmp"));
%>
<%
String category = request.getParameter("category");
String goodsTitle =request.getParameter("goodsTitle");
String empId = (String)(loginMember.get("empId"));
String fileN =request.getParameter("goodsTitle");
String goodsPrice =request.getParameter("goodsPrice");
String goodsAmount =request.getParameter("goodsAmount");
String goodsContent =request.getParameter("goodsContent");

Part part = request.getPart("goodsImg");
String originalName = part.getSubmittedFileName();
// 원본이름에서  확장자만 분리
int dotIdx = originalName.lastIndexOf(".");
String exe = originalName.substring(dotIdx);  //.png
System.out.println(exe);

UUID uuid = UUID. randomUUID();
String filename = uuid.toString().replace("-", "");
filename = filename + exe;




%>

<!-- Controller Layer -->
<%
	int row;
	row= GoodsDAO.addGoodsAction(category, goodsTitle, empId, filename, goodsPrice, goodsAmount, goodsContent);

	if(row == 1){ //insert 성공 -> 파일업로드 진행 
		//Part -> is(inputStream) -> os(outputStream) -> 빈파일
		//1)
		InputStream is = part.getInputStream();
		//3) +2
		String filePath = request.getServletContext().getRealPath("upload");
		File f = new File(filePath, filename); //빈파일
		OutputStream os = Files.newOutputStream(f.toPath()); //os +file //객체생성없이 클래스이름으로 생성가능 /Static 메소드/
		is.transferTo(os);
		
		os.close();
		is.close();
		
		//	part.transferTo(os); //part안에 파일을 is-> os-> file 까지 바꿔줌 (스프링)
		
	}
	//파일 삭제 
	/*
	File df = new File (filePath, rs.getString("filename"));   // 이미 존재하는 파일을 가져오기
	df.delete()
	*/
	
	
	if(row==1){
		System.out.println("등록하였습니다");
	}else{
		System.out.println("등록에 실패하였습니다");
	}
	 response.sendRedirect("/shop/emp/goodsList.jsp");
%>
