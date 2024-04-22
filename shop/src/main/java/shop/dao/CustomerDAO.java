package shop.dao;
import java.sql.*;
import java.util.*;

public class CustomerDAO {
	//디버깅용 메인 메소드
	public static void main(String[] args)throws Exception{
		//메일 체크 메서드 디버깅
		System.out.println(CustomerDAO.checkMail("a@goodee.com")); //false
		System.out.println(CustomerDAO.addCustomer(	"z@goodee.com","1234","zzz","1999/09/09","여")); // 성공
		System.out.println(CustomerDAO.login("z@goodee.com", "1234"));
		System.out.println(CustomerDAO.deleteCustomer("z@goodee.com", "1234"));
		System.out.println(CustomerDAO.selectCustomerListBypage(10,10));  //10번쨰 부터 10개  출력
		
	}
	//관리자 페이지에서 전체 회원정보보기(pw제외)
	//호출: /emp/customerList.jsp
	//매개변수: 없음 (void)
	//return : Customer배열(리스트) -> ArrayList<HashMap<String, Object >>
	//페이징
	
	public static ArrayList<HashMap<String, Object >> selectCustomerListBypage( 
			int startRow, int rowPerPage) throws Exception{
		//currentPage + rowPerpage 로  startRow를 구하는 알고리즘을 dao가 아닌 액션에 구현
		ArrayList<HashMap<String, Object >>list =   //list 객체
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql="select "
				+ "mail,name,birth,gender,update_date updateDate,create_date createDate from customer"
				+ "order by mail"
				+ "offset 0 rows fetch next 10 rows only";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		//jdbc Result (자바에서 일반적이지 않은 구조)
		//->collections API 타입 -> list , set ,Map
		
		while(rs.next()) {
			HashMap<String ,Object>m = new HashMap<String, Object>();  //HashMap 이름 m
			m.put("mail", rs.getString("mail"));
			m.put("name", rs.getString("name"));
			
		}
		
		return list;
	}
	
	
	
	//로그인 사용자 회원정보보기- 완료
	//호출: customerOne.jsp 
	//매개변수 String()
	//return: customer (비밀번호 제외)
	
	public static ArrayList<HashMap<String , Object>>selectCustomerOne(String mailParam)
												throws Exception	{
		ArrayList<HashMap<String, Object>> One
		= new ArrayList<HashMap<String,Object>>();
		Connection conn = DBHelper.getConnection();
		String sql ="select mail , name ,birth , gender from customer where mail= ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mailParam);
		
		ResultSet rs=stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("mail",rs.getString("mail"));
			m.put("name",rs.getString("name"));
			m.put("birth",rs.getString("birth"));
			m.put("gender",rs.getString("gender"));
			
			One.add(m);
			
		}
		conn.close();

		
		return One;
	}
	
	
	
	
	
	//비밀번호 수정 
	//호출:editPwAction.jsp
	//param:String(mail),String(수정전 pw), String(수정할 pw)
	//return: int (1 성공 2 실패)
	public static int updatePW(String mail, String OldPw, String newPw) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql= "update customer set pw=? where mail= ? and pw =?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, newPw);
		stmt.setString(2, mail);
		stmt.setString(3, OldPw);
		
		row= stmt.executeUpdate();
		
		return row;
	}
	
	
	
	
	
	
	//회원탈퇴 --완료
	//호출
	//param: String (세션안의 mail), String (pw)
	//return: int (1이면 탈퇴 	0이면 탈퇴실패)
	public static int deleteCustomer(String mail, String pw) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql= "delete from customer"
				+ " where mail = ? and pw = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		
		row = stmt.executeUpdate();
		
		return row;
	}
	
	
	
	//customerGoodsList페이징 --완성
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
	
	//customerList --완성
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
	
	//CustomeGoodsOne.jsp--완성
	public static ArrayList<HashMap<String , Object>>GoodsOne( //메소드 이름
			int goodsNo)throws Exception{
		ArrayList<HashMap<String ,  Object>> GoodsOne = //객체 
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "select goods_no goodsNo , category ,filename , goods_title goodsTitle , "
				+ "goods_content goodsContent , goods_price goodsPrice ,goods_amount goodsAmount "
				+ ",update_date updateDate, create_date createDate  from goods where goods_no= ?  ";
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setInt(1,goodsNo);
				
				
				ResultSet rs = stmt.executeQuery();
				if(rs.next()) {
			    	HashMap<String, Object> m = new HashMap<String, Object>();
			    	
			    	m.put("goodsNo", rs.getInt("goodsNo"));
			    	m.put("filename", rs.getString("filename"));
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
	
	//로그인 메서드 --완성 
	// 호출:loginAction.jsp
	//param :String(mail) ,String(pw)
	//return: HashMap(메일,이름)
	public static HashMap<String, String>login(String mail, String pw)throws Exception{
		HashMap<String,String>map=null;
		
		Connection conn=DBHelper.getConnection();
		String sql="select mail, name,  birth , gender from customer where mail=? and pw= password(?)";
		PreparedStatement stmt= conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			map = new HashMap<String, String>();
			map.put("mail", rs.getString("mail"));
			map.put("name", rs.getString("name"));
			
		}
		conn.close();
		return map;
	}
	
	

	
	
	
	
	
	//메일중복확인-회원가입시
	//check CustomerKeyActrion.jsp
	//param :String (메일 문자열)
	// return : boolean(사용 가능하면 true , 불가면 false)
	public static String checkMail(String mail) throws Exception {
		String result = "O";
		
		Connection conn = DBHelper.getConnection();
		
		String sql="select mail, pw, name, birth, gender from customer where mail =?";
		
		PreparedStatement stmt =conn.prepareStatement(sql);
		stmt.setString(1, mail);
		ResultSet rs =stmt.executeQuery();		
		
		if(!rs.next()) { //사용불가
			result ="O";
			
		}
		conn.close();
		
		return result;
	}
	
	
	//회원가입 액션 --끝 
	//호출: addCustomerAction.jsp
	//param:customer
	//return: int(입력 실패 0,입력 성공 1)
	public static int addCustomer(String mail, String pw, String name , String birth, String gender ) throws Exception {
		int row=0;
		Connection conn = DBHelper.getConnection();
		String sql= "insert into customer (mail,pw,name,birth,gender) values (?,password(?), ? ,? , ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		stmt.setString(3, name);
		stmt.setString(4, birth);
		stmt.setString(5, gender);
		
		conn.close();
		
		return row;
	}
	

}
