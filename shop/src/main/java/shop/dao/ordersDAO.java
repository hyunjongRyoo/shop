package shop.dao;
import java.sql.*;
import java.util.*;


public class ordersDAO {
	//고객의 자신의 주문을 확인 (페이징)--완료(값 확인해야함)
	public static ArrayList<HashMap<String, Object>>selectOrdersListByCustomer(
			String mail, int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>>list
		= new ArrayList<HashMap<String, Object>>();
		
		Connection conn =DBHelper.getConnection();
		
		String sql = "select o.orders_no ordersNo, o.goods_no goodsNo, "
				+ "o.mail mail, o.total_amount totalAmount, o.total_price totalPrice,"
				+ "o.address address, o.state state, o.update_date updateDate, o.create_date createDate, "
				+ "g.goods_title goodsTitle, g.category category, "
				+ " g.goods_price goodsPrice "
				+ "from orders o inner join goods g "
				+ "on o.goods_no = g.goods_no "
				+ "where o.mail = ? "
				+ "order by o.orders_no desc "
				+ "limit ?, ?";
			
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		System.out.println(stmt);
		ResultSet rs =stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new  HashMap<String, Object>();
			m.put("ordersNo",rs.getInt("ordersNo"));
			m.put("mail",rs.getString("mail"));
			m.put("goodsNo",rs.getInt("goodsNo"));
			m.put("totalAmount", rs.getInt("totalAmount"));
			m.put("totalPrice", rs.getInt("totalPrice"));
			m.put("address", rs.getString("address"));
			m.put("state", rs.getString("state"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));
			m.put("goodsPrice", rs.getInt("goodsPrice"));
			m.put("goodsTitle", rs.getString("goodsTitle"));

			
			list.add(m);
		}
		conn.close();
		return list;
	}
	//관리자의 전체주문을 확인(페이징)--완료(값 확인해야함)
	public static ArrayList<HashMap<String, Object>>selectOrdersListAll(
			int startRow , int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>>list
		= new ArrayList<HashMap<String, Object>>();
		Connection conn=DBHelper.getConnection();
		
		String sql = "select o.orders_no ordersNo, o.goods_no goodsNo, "
				+ "o.mail mail, o.total_amount totalAmount, o.total_price totalPrice,"
				+ "o.address address, o.state state, o.update_date updateDate, o.create_date createDate, "
				+ "g.goods_title goodsTitle, g.category category, "
				+ " g.goods_price goodsPrice "
				+ "from orders o inner join goods g "
				+ "on o.goods_no = g.goods_no "
				+ "order by o.orders_no desc "
				+ "limit ?, ?";
			
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		System.out.println(stmt);
		ResultSet rs =stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new  HashMap<String, Object>();
			m.put("ordersNo",rs.getInt("ordersNo"));
			m.put("mail",rs.getString("mail"));
			m.put("goodsNo",rs.getInt("goodsNo"));
			m.put("totalAmount", rs.getInt("totalAmount"));
			m.put("totalPrice", rs.getInt("totalPrice"));
			m.put("address", rs.getString("address"));
			m.put("state", rs.getString("state"));
			m.put("updateDate", rs.getString("updateDate"));
			m.put("createDate", rs.getString("createDate"));
			m.put("goodsPrice", rs.getInt("goodsPrice"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			list.add(m);
		}
		conn.close();
		return list;
	}
	//ordersAction.jsp
	public static int ordersAction(String mail, int goodsNo, int amount, int price, String address) throws Exception {
		String sql = null;
		sql = "insert into orders(mail, goods_no, total_amount, total_price, address) values(?, ?, ?, ?, ?);";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, goodsNo);
		stmt.setInt(3, amount);
		stmt.setInt(4, price);
		stmt.setString(5, address);
		System.out.println(stmt);
		int row = 0;
		row = stmt.executeUpdate();
		
		return row;
	}
	//orderOne
	//상품주문정보  상세보기
	//param = ordersNo
	public static ArrayList<HashMap<String,Object>>orderOne(int ordersNo) throws Exception {
		String sql = "select o.orders_no ordersNo,o.goods_no goodsNo, g.goods_title goodsTitle, g.filename filename, "
				+ " o.total_amount totalAmount, o.total_price totalPrice,o.state state, o.create_date createDate "
				+ "from orders o inner join goods g on o.goods_no = g.goods_no "
				+ "where o.orders_no =?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		System.out.println(stmt);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			
			
		}
		
		
	}
	
	
	
}
