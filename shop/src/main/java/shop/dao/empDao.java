package shop.dao;

import java.sql.*;
import java.util.*;

	public class empDao { 
		//addEmp
	public static int insertEmp (
			String empId,
			String empPw,
			String empName,
			String empJob
			)
	throws Exception{
		int row =0;
		//db 접근
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn= DriverManager.getConnection(
				"jdbc:mariadb://127.0.0.1:3306/shop", "root", "guswhd6656");
		String sql= "insert ... ?,?,?,?";
		PreparedStatement stmt  = conn.prepareStatement(sql);
		
		stmt.setString(1, empId);
		stmt.setString(2, empPw);
		stmt.setString(3, empName);
		stmt.setString(4, empJob);
		conn.close();
		return row;
	}

	
	
	// 호출코드  HashMap <String , Object> m = EmpDao.empLogin("admin" , "1234");
	
	//loginEmp
		public static HashMap<String, Object> loginEmp(String empId, String empPw) throws Exception {
		
		HashMap<String , Object>resultMap = null;  // resultMap 저장 -> loginEmp에다가 하면 안됌
		
		//db 접근
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn= DriverManager.getConnection(
				"jdbc:mariadb://127.0.0.1:3306/shop", "root", "guswhd6656");
		
		
		String sql = "select emp_id empId, emp_name empName, grade from emp where active='ON' and emp_id =? and emp_pw = password(?)";
		
		PreparedStatement stmt  = conn.prepareStatement(sql);
		
		stmt.setString(1, empId);
		stmt.setString(2, empPw);
		ResultSet rs =stmt.executeQuery();
		
		
		

		if(rs.next()) {
			
			resultMap = new HashMap<String, Object>(); 
			resultMap.put("empId", rs.getString("empId"));
			resultMap.put("empName", rs.getString("empName"));
			resultMap.put("grade", rs.getInt("grade"));
		
			
			System.out.println(rs.getString("empId"));
			System.out.println(rs.getString("empName"));
			System.out.println(rs.getInt("grade"));

		
		}
		conn.close();
		return resultMap;
		
		
	}
		//empList 페이징 
		public static ArrayList<HashMap<String, Object>> empPageList() throws Exception{
			ArrayList<HashMap<String , Object>>empPageList =
					new ArrayList<HashMap<String, Object>>();
			
			Connection conn = DBHelper.getConnection();
			String sql ="select count(*) cnt from emp";
			PreparedStatement stmt = conn.prepareStatement(sql);
			
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>(); //키 & 벨류
				m.put("cnt", rs.getInt("cnt"));
				empPageList.add(m);
			}
			conn.close();
		return empPageList;
		}
		
		
		//empList
		public static ArrayList<HashMap<String , Object>>  empList(
			 int startRow , int rowPerPage) throws Exception{
			ArrayList<HashMap<String , Object>>empList =
						new ArrayList<HashMap<String, Object>>();
			
			Connection conn = DBHelper.getConnection();
			 //전체 상품 가져옴 
		
			String sql = "select emp_id empId, emp_name empName, emp_job "
					+ "empJob, hire_date hireDate, "
					+ "active from emp order by hire_date desc limit ?, ?";
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setInt(1, startRow);
				stmt.setInt(2, rowPerPage);
		
				ResultSet rs = stmt.executeQuery();	
				while(rs.next()) {
				HashMap<String , Object> m  = new HashMap<String, Object >();
				m.put("empId", rs.getString("empId"));
				m.put("empName", rs.getString("empName"));
				m.put("empJob", rs.getString("empJob"));
				m.put("hireDate", rs.getString("hireDate"));
				m.put("active", rs.getString("active"));
				empList.add(m);
			}
			conn.close();
			return empList;
		}
		//empOne
		public static ArrayList<HashMap<String, Object>> One(
				String empNameParam) throws Exception{
		ArrayList<HashMap<String , Object>> One =
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
		
		String sql2="select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp where emp_name= ?";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, empNameParam);
	
		
	    ResultSet rs2 = stmt2.executeQuery();
	    while(rs2.next()) {
	    	HashMap<String, Object> m = new HashMap<String, Object>();
	    	m.put("empId", rs2.getString("empId"));
	    	m.put("empName", rs2.getString("empName"));
	    	m.put("empJob", rs2.getString("empJob"));
	    	m.put("hireDate", rs2.getString("hireDate"));
	    	m.put("active", rs2.getString("active"));
	    	
	    	One.add(m);
		}
	    conn.close();
		
		
		return One;
		}
		
		//updateEmp
		public static int updateEmp (
				String active,
				String empId
				)throws Exception{
			
			int row =0;
			//db 접근
			
			Connection conn = DBHelper.getConnection();
			String sql3="update emp set active = ? where emp_id = ?";
			PreparedStatement stmt3  = conn.prepareStatement(sql3);
			stmt3.setString(1, empId);
			stmt3.setString(2, active);
			
			System.out.println(empId+"<--updateEmp empId");
			System.out.println(active+"<--updateEmp active");
			
			row = stmt3.executeUpdate();
			
			conn.close();
			return row;
		}
}

