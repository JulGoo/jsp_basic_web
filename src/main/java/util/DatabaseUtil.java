package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
	public static Connection getConnection() { //데이터베이스와 연결상태 관리
		try {
			String dbURL = "jdbc:mysql://localhost:3306/TOC?useSSL=false&serverTimezone=UTC";
			String dbID = "root";
			String dbPW = "toc1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbID, dbPW);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}

