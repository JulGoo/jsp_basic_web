package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class CommentDAO {
	Connection conn = DatabaseUtil.getConnection();

	// 새 댓글 번호 메소드
	public int getNext() {
		String SQL = "select commentID from comment order by commentID desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	// 댓글 작성 일자 메소드
	public String getDate() {
		String SQL = "select now()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	
	//댓글 작성 메소드
	public int write(int no, String userID, String commentText) {
		String SQL = "insert into comment values(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, no);
			pstmt.setInt(2, getNext());
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, commentText);
			pstmt.setInt(6, 1);	//댓글의 유효번호
			
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	//댓글 보기 메소드
	public ArrayList<CommentDTO> getCommentList(int no) {
		String SQL = "select * from comment where no = ? and commentAvailable = 1 order by no desc";
		ArrayList<CommentDTO> list = new ArrayList<CommentDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, no);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				CommentDTO cmmt = new CommentDTO();
				cmmt.setNo(rs.getInt(1));
				cmmt.setCommentID(rs.getInt(2));
				cmmt.setUserID(rs.getString(3));
				cmmt.setCommentDate(rs.getString(4));
				cmmt.setCommentText(rs.getString(5));
				cmmt.setCommentAvailable(rs.getInt(6));
				list.add(cmmt);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;	//데이터베이스 오류
	}
	
	//댓글 삭제 메소드 --> 실제 삭제가 아닌 유효번호를 0으로 설정
		public int delete(int commentID) {
			String SQL = "update comment set commentAvailable = 0 where commentID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, commentID);
				return pstmt.executeUpdate();
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1;	//데이터베이스 오류
		}
		
		
		public CommentDTO getCommentID(int commentID) {
			String SQL ="select * from comment where commentID = ? order by commnetID desc";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, commentID);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) {
					CommentDTO comment = new CommentDTO();
					comment.setNo(rs.getInt(1));
					comment.setCommentID(rs.getInt(2));
					comment.setUserID(rs.getString(3));
					comment.setCommentDate(rs.getString(4));
					comment.setCommentText(rs.getString(5));
					comment.setCommentAvailable(rs.getInt(6));
					return comment;
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		//*******?
		public String getUpdateComment(int commentID) {
			String SQL = "select commentText from comment where commentID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, commentID);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return "";
		}
		
		public String whatuserID(int commentID) {
			String SQL = "select userID from comment where commentID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, commentID);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return "";
		}
		
}










