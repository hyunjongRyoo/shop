package shop.dao;
import java.sql.*;
import java.util.*;


public class ordersDAO {
	//고객의 자신의 주문을 확인 (페이징)
	//param: mail로  고객 개개인 확인
	//ordersList.jsp
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
			System.out.println(m);
		}
		conn.close();
		return list;
	}
	//관리자의 전체주문을 확인(페이징)--수정 
	//고객페이지와의 차이점: state를 바꿀수있어야함
	//param: startRow,rowPerPage -> 페이징
	//empOrdersList.jsp
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
	//주문추가
	//param:mail,goodsNo,amount, address,price
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
	//param: ordersNo
	public static ArrayList<HashMap<String,Object>>orderOne(int ordersNo) throws Exception {
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String, Object>>();		
		String sql = "select o.orders_no ordersNo,o.goods_no goodsNo, g.goods_title goodsTitle, "
				+ " o.total_amount totalAmount, o.total_price totalPrice,o.state state, o.create_date createDate "
				+ "from orders o inner join goods g on o.goods_no = g.goods_no "
				+ "where o.orders_no =?";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ordersNo);
		System.out.println(stmt);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			//값을 넣어준다
			m.put("ordersNo", rs.getInt("ordersNo"));
			m.put("goodsNo", rs.getInt("goodsNo"));
			m.put("goodsTitle", rs.getString("goodsTitle"));
			m.put("totalAmount", rs.getInt("totalAmount"));
			m.put("totalPrice", rs.getInt("totalPrice"));
			m.put("state", rs.getString("state"));
			m.put("createDate", rs.getString("createDate"));

			list.add(m);
			System.out.println(m);
		}
		conn.close();
		return list;
		
	}
	
	//주문수량
	//여러개 주문시
	//파라미터 없음
	public static int ordersCount() throws Exception{
		String sql="select count(*) count from orders";
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt= conn.prepareCall(sql);
		ResultSet rs= stmt.executeQuery();
		
		int count = 0;
		
		if(rs.next()) {
			count=rs.getInt("count");
			}
		
		conn.close();
		return count;
		
	}
	
	//관리자 state 바꾸기
	//결제완료,배송중,배송완료-> 배송완료일때 리뷰 작성가능 
	//param: state,ordersNo
	public static int updateState(String state, int ordersNo)throws Exception{
		Connection conn=DBHelper.getConnection();
		// 몇번 주문의 주문상태를 변경할것인지?->리뷰작성을 위해서
		String sql="update orders set state=? where orders_no=?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, state);
		stmt.setInt(2, ordersNo);
		
		System.out.println(stmt);
		
		int row=0;
		row=stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	//주문 취소하기(삭제)
	//deleteOrdersAction.jsp
	//param:ordersNo
	public static int deleteOrder(int ordersNo) throws Exception{
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
