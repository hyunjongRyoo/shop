package shop.dao;

import java.sql.*;
import java.util.Properties;
import java.io.FileReader;

public class DBHelper {
	public static java.sql.Connection getConnection() throws Exception {
		//db 접근
		Class.forName("org.mariadb.jdbc.Driver");
		
		//로컬 pc의 properties의 파일 읽어오기
		FileReader fr = new FileReader("/Users/apple/Desktop/auth/mariadb.properties"); //? 파일 주소 ?
		Properties prop = new Properties();
		prop.load(fr);
		System.out.println(prop.getProperty("id"));
		System.out.println(prop.getProperty("pw"));
		String id = prop.getProperty("id");
		String pw = prop.getProperty("pw");
		
		
		
		Connection conn=DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", id, pw);
		return conn;
	}
	public static void main(String [] args) throws Exception {
		DBHelper.getConnection();
	}

}
