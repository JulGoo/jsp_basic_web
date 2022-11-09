package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import util.DatabaseUtil;

public class UserDAO {
	Connection conn = DatabaseUtil.getConnection();

	public int join(String userID, String userPW, String userName, String userEmail, String userPhone,
			String userGender) {
		String SQL = "INSERT INTO user VALUES (?,?,?,?,?,?)";
		try {
			// 각각의 데이터를 실제로 넣어준다.
			PreparedStatement pstmt = conn.prepareStatement(SQL);

			// 쿼리문의 ?안에 각각의 데이터를 넣어준다.
			pstmt.setString(1, userID);
			pstmt.setString(2, userPW);
			pstmt.setString(3, userName);
			pstmt.setString(4, userEmail);
			pstmt.setString(5, userPhone);
			pstmt.setString(6, userGender);

			// 명령어를 수행한 결과 반환, 반환값: insert가 된 데이터의 개수
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public String login(String userID, String userPW) {
		String SQL = "SELECT userPW, userName FROM user where userID = ?";
		ResultSet rs = null;

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (rs.getString(1).equals(userPW)) {
					return rs.getString(2);
				} else
					return "a";
			} else
				return "b"; // 아이디 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "c"; // 데이터배이스 오류
	}
}
