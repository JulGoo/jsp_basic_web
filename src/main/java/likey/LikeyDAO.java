package likey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import util.DatabaseUtil;

public class LikeyDAO {
	Connection conn = DatabaseUtil.getConnection();

	public int like(String userID, String no, String userIP) {
		String SQL = "INSERT INTO LIKEY VALUES (?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, no);
			pstmt.setString(3, userIP);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1; // 추천 중복 오류
	}
}
