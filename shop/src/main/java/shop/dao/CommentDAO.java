package shop.dao;

import java.sql.*;

public class CommentDAO {
	//commentAction.jsp
	//후기 작성(추가)
	//param:ordersNo,score,content
	public static int addCommentAction(
			int ordersNo,int score,String content)throws Exception{
		String sql= "insert into comment(orders_no,score,content,update_date,create_date)values(?,?,?,now(),now())";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		stmt.setInt(2, score);
		stmt.setString(3, content);
		//디버깅
		System.out.println(stmt);
		int row = 0; 
		row = stmt.executeUpdate();
		
		
		conn.close();
		return row;
	}
	
	
	//checkCommentAction.jsp
	//후기 작성이 이미 존재할때 (후기 작성이 가능유무 판단)
	//param:ordersNo
	public static boolean checkCommentAction(
			int ordersNo)throws Exception{
		boolean checkComment =false;
		String sql= "select * from comment where orders_no=?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		//디버깅
		System.out.println(stmt);
		ResultSet rs= stmt.executeQuery();
		
		while(rs.next()) {
			checkComment = true;
		}

		conn.close();
		return checkComment;
	}
	
	
	
	//리뷰 삭제
	public static int deleteComment(int ordersNo) throws Exception{
		Connection conn= DBHelper.getConnection();
		
		String sql="delete from orders whrer orders_no =?";
		PreparedStatement stmt= conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		
		System.out.println(stmt);
		int row=0;
		row = stmt.executeUpdate();
		
		
		conn.close();
		return row;
	}
}
