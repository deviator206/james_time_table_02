package rest.code;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBProperties {
	
	
	static String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static String DB_URL ="jdbc:mysql://localhost/dev_teacher";
	
	static  String User = "root";
	//static  String Password = "root";
	static  String Password = "Temp1234";
	
	static Connection conn = null;
	
	static Connection getConnection()
	{
		conn = null;
		try {
			Class.forName(JDBC_DRIVER);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		try {
			conn = DriverManager.getConnection(DB_URL,User,Password);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return conn;
	}
	
	static void closeConnection ()
	{
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

}
