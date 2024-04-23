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
		
		String sql=	"select o.orders_no ordersNo,o.goods_no "
					+ " goodsNo, g.goods_title goodsTitle "
					+"from orders o inner join goods g "
					+"on o.goods_no = g.goods_no "
					+"where o.mail=? "
					+"order by o.orders_no desc "
					+"offset 0 rows fetch next 10 rows only";
			
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
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("price", rs.getInt("price"));
			m.put("ordersNo", rs.getString("ordersNo"));
			m.put("state", rs.getString("state"));
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
		
		String sql=	"select o.orders_no ordersNo,o.goods_no "
					+"goodsNo, g.goods_title goodsTitle "
					+"from orders o inner join goods g "
					+"on o.goods_no = g.goods_no "
					+"where o.mail=? "
					+"order by o.orders_no desc "
					+"offset 0 rows fetch next 10 rows only";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1,startRow);
		stmt.setInt(2,rowPerPage);
		System.out.println(stmt);
		ResultSet rs= stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new  HashMap<String, Object>();
			m.put("ordersNo",rs.getInt("ordersNo"));
			m.put("mail",rs.getString("mail"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("price", rs.getInt("price"));
			m.put("ordersNo", rs.getString("ordersNo"));
			m.put("state", rs.getString("state"));
			list.add(m);
		}
		conn.close();
		
		return list;
	}
	//ordersAction.jsp
	public static int ordersAction(String mail, int amount, int price , String address)
	throws Exception{
		String sql="insert into orders (mail,amount,price,address) values (?,?,?,?)";
		Connection conn=DBHelper.getConnection();
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, amount);
		stmt.setInt(3, price);
		stmt.setString(4, address);
		System.out.println(stmt);
		int row =0;
		row=stmt.executeUpdate();
		return row;
	}
	
	
}
