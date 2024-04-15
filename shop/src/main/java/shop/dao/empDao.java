package shop.dao;

import java.sql.*;
import java.util.*;

	public class empDao {
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
		public static ArrayList<HashMap<String, Object>> list(
				String empNameParam) throws Exception{
		ArrayList<HashMap<String , Object>> list =
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
	    	
	    	list.add(m);
		}
	    conn.close();
		
		
		return list;
		}
}

