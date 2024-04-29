package shop.dao;

import java.sql.*;
import java.util.*;
public class GoodsDAO {
	//싱품 주문 or 취소시  수정할 수량
	// customer/addOrdersAction.jsp or dropOrdersAction.jsp
	// 매개변수 int(상품번호) , int (변경할 수량 + -)
	public static int updateGoodsAmount(int goodsNo, int goodsAmount ) 
												throws Exception {
		Connection conn=DBHelper.getConnection();
		PreparedStatement stmt = null;
		if(goodsAmount>0) {
		String sql= "update goods "
					+ "set goods_amount = goods_amount-? , update_date=now() "
					+ "where goods_no=? "
					+ "and goods_amount > ?";
	stmt= conn.prepareStatement(sql);
	stmt.setInt(1, goodsAmount);
	stmt.setInt(2, goodsNo);
	stmt.setInt(3, goodsAmount-1); //주문후 수량에서 -1 해주기  
	System.out.println(stmt);
	}else{
		String sql= "update goods "
				+ "set goods_amount = goods_amount-? , update_date=now() "
				+ "where goods_no=? ";
		stmt= conn.prepareStatement(sql);
		stmt.setInt(1, goodsAmount);
		stmt.setInt(2, goodsNo);
		System.out.println(stmt);
	}
	int row= 0;
	row=stmt.executeUpdate();
	
	return row;
}
	
	
	//goodsOne.jsp
	//매개변수 goods_no
	//return Goods--> HashMap
	
	public static ArrayList<HashMap<String , Object>>GoodsOne( //메소드 이름
			int goodsNo)throws Exception{
		ArrayList<HashMap<String ,  Object>> GoodsOne = //객체 
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "select goods_no goodsNo , category ,filename , "
				+ "emp_id empId , goods_title goodsTitle , goods_content goodsContent ,"
				+ " goods_price goodsPrice ,goods_amount goodsAmount ,update_date updateDate,"
				+ " create_date createDate  from goods where goods_no= ? ";
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setInt(1,goodsNo);
				
				
				ResultSet rs = stmt.executeQuery();
				if(rs.next()) {
			    	HashMap<String, Object> m = new HashMap<String, Object>();
			    	m.put("goodsNo", rs.getInt("goodsNo"));
			    	m.put("filename", rs.getString("filename"));
			    	m.put("empId", rs.getString("empId"));
			    	m.put("goodsTitle", rs.getString("goodsTitle"));
			    	m.put("goodsContent", rs.getString("goodsContent"));
			    	m.put("goodsPrice", rs.getInt("goodsPrice"));
			    	m.put("goodsAmount", rs.getInt("goodsAmount"));
			    	m.put("updateDate", rs.getString("updateDate"));
					m.put("createDate", rs.getString("createDate"));
					
					GoodsOne.add(m);
			    }
		conn.close();
		
		
		return GoodsOne;
		
	}
	
	
	//goodsList 페이징
	public static ArrayList<HashMap<String, Object>> paging() throws Exception{
		ArrayList<HashMap<String , Object>>paging =
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
			paging.add(m);
		}
		conn.close();
	return paging;
	}
	
	
	
	
	//goodsList
	//param:category,startRow,rowPerPage
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
					//+"offset ? rows fetch next ? rows only";
			 stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
			System.out.println(stmt);
		} else { //해당 카테고리에 속하는 상품만 가져옴
			String sql = "select goods_no goodsNo, category,filename, emp_id empId, goods_title " + 
					"goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, " + 
					"update_date updateDate, create_date createDate from goods where category = ? order by goods_no asc limit ?, ?";
					//+"offset ? rows fetch next ? rows only";
			
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
	
	//categoryList
	public static ArrayList<HashMap<String, Object>> categoryList(
		) throws Exception{
		ArrayList<HashMap<String , Object>>categoryList =
				new ArrayList<HashMap<String, Object>>();
			Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		String sql = "select category, create_date createDate from category";
		stmt = conn.prepareStatement(sql);
	
		ResultSet rs = stmt.executeQuery();
		while(rs.next()){
			HashMap<String, Object> m = new HashMap<String,Object>();
			m.put("category", rs.getString("category"));
			m.put("createDate", rs.getString("createDate"));
			categoryList.add(m);
		}
		conn.close();
	return categoryList;
	}
	
	
	
	
	
	//add GoodsForm
	public static ArrayList<String>addGoods(
			)throws Exception{
		ArrayList<String>GoodsList=
				new ArrayList<String>();
	Connection conn = DBHelper.getConnection();
	PreparedStatement stmt = null;
	String sql="select category from category";
	stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	while(rs.next()) {
		GoodsList.add(rs.getString("category"));
	}
	conn.close();
	return GoodsList;
	}
	
	//addGoodsAction
	//상품 추가
	//param:category,goodsTitle,empId,filename,goodsPrice,goodsAmount,goodsContent
	
	public static int addGoodsAction(
	String category , String  goodsTitle , String empId , String filename, String goodsPrice, String goodsAmount , String goodsContent
	)throws Exception{
		
		int row=0;
		
		PreparedStatement stmt = null;
		Connection conn = DBHelper.getConnection();
		String sql="insert into goods(category,emp_id,goods_title,filename, goods_price, goods_amount,goods_content) values (?, ?, ?, ?, ?, ?, ?)";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category);
		stmt.setString(2, empId);
		stmt.setString(3, goodsTitle);
		stmt.setString(4, filename);
		stmt.setString(5, goodsPrice);
		stmt.setString(6, goodsAmount);
		stmt.setString(7, goodsContent);
		System.out.println(stmt +"<--addgoodsAction.jsp");
		
		row=stmt.executeUpdate();
		conn.close();
		return row;
	}
	
	//addCatrgoryAction.jsp
	//param:category
	public static  int  addCategoryAction(
			String category	) throws Exception{
		int row =0;
		PreparedStatement stmt = null;
		Connection conn=DBHelper.getConnection();
		String sql="insert into category(category)Values(?)";
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, category);
		
		row =stmt.executeUpdate();
		conn.close();
		return row;
		
	}
	
	//addCatrgoryForm.jsp
	public static ArrayList<String>addCategoryForm(
			)throws Exception {
		ArrayList<String> addCategoryForm =
				new ArrayList<String>();
		
		PreparedStatement stmt= null;
		Connection conn = DBHelper.getConnection();
		String sql="select category from category";
		stmt=conn.prepareStatement(sql);
		
		ResultSet rs= stmt.executeQuery();
		
		while(rs.next()) {
			addCategoryForm.add(rs.getString("category"));
		}
		
		conn.close();
		return addCategoryForm;
		
	}
	
	
}
