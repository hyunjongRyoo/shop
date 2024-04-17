package shop.dao;

import java.sql.*;
import java.util.*;

public class GoodsDAO {
	public static ArrayList<HashMap<String, Object>> categoryList() throws Exception{
		ArrayList<HashMap<String , Object>>categoryList =
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql1 = "select category, count(*) cnt from "
				+ "goods group by category order by category";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		
		ResultSet rs1 = stmt1.executeQuery();
		
		while(rs1.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>(); //키 & 벨류
			m.put("category", rs1.getString("category"));
			m.put("cnt", rs1.getInt("cnt"));
			categoryList.add(m);
		}
		conn.close();
	return categoryList;
	}


	public static ArrayList<HashMap<String , Object>>  goodsList(
			String category, int startRow , int rowPerPage) throws Exception{
		ArrayList<HashMap<String , Object>>goodsList =
					new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		 //전체 상품 가져옴 
		PreparedStatement stmt = null;
		if(category == null || category.equals("null")){
			String sql = "select goods_no goodsNo, category, filename,emp_id empId, goods_title " + 
					"goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, " + 
					"update_date updateDate, create_date createDate from goods order by goods_no asc limit ?, ?";
			 stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
			System.out.println(stmt);
		} else { //해당 카테고리에 속하는 상품만 가져옴
			String sql = "select goods_no goodsNo, category,filename, emp_id empId, goods_title " + 
					"goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, " + 
					"update_date updateDate, create_date createDate from goods where category = ? order by goods_no asc limit ?, ?";
			
			 stmt = conn.prepareStatement(sql);
		stmt.setString(1, category);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		}
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String , Object> m  = new HashMap<String, Object >();
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("category", rs.getString("category"));
			m.put("filename", rs.getString("filename"));
			m.put("empId", rs.getString("empId"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("goodsContent", rs.getString("goodsContent"));
			m.put("goodsPrice", rs.getInt("goodsPrice"));
			m.put("goodsAmount", rs.getInt("goodsAmount"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));
			
			goodsList.add(m);
		}
		conn.close();
		
		
		return goodsList;
		
	}
 //	public static 
}
