package bbs_h;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class Bbs_hDAO {
	Connection conn = DatabaseUtil.getConnection();
	
	//getNext() == 새 게시글 번호 부여 메소드
		public int getNext() {
			String SQL = "select no from bbs_h order by no desc";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getInt(1) + 1;
				}
				return 1; //첫번째 게시물인 경우
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
		}
		
		//getDate() == 작성 일자를 구하는 메소드
		public String getDate() {
			String SQL = "select now()";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return ""; //데이터베이스 오류		
		}
	
	public int write(String rest, String title, String userID, String content, String category) {
		String SQL = "insert into bbs_h values(?,?,?,?,?,?,?,0,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, getNext());
			pstmt.setString(2, rest);
			pstmt.setString(3, title);
			pstmt.setString(4, userID);
			pstmt.setString(5, getDate());
			pstmt.setString(6, content);
			pstmt.setInt(7, 1);	//글의 유효번호
			pstmt.setString(8, category);
			
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	//존재하는 게시글 리스트를 불러오는 메소드
	//게시글 모두보기 시 필요 --> 현재 사용x
//	public ArrayList<Bbs_hDTO> getList(int pageNumber) {
//		String SQL = "select * from bbs_h where no < ? and available = 1 order by no desc limit 10";
//		ArrayList<Bbs_hDTO> list = new ArrayList<Bbs_hDTO>();
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
//			ResultSet rs = pstmt.executeQuery();
//			while(rs.next()) {
//				Bbs_hDTO bbs = new Bbs_hDTO();
//				bbs.setNo(rs.getInt(1));
//				bbs.setRest(rs.getString(2));
//				bbs.setTitle(rs.getString(3));
//				bbs.setUserID(rs.getString(4));
//				bbs.setDate(rs.getString(5));
//				bbs.setContent(rs.getString(6));
//				bbs.setAvailable(rs.getInt(7));
//				bbs.setLikecount(rs.getInt(8));
//				bbs.setCategory(rs.getString(9));
//				list.add(bbs);
//			}
//		}catch (Exception e) {
//			e.printStackTrace();
//		}
//		return list;
//	}
	
	//카테고리 별 게시판 출력 메소드
	public ArrayList<Bbs_hDTO> getCategoryList (int pageNumber, String category) {
		String SQL = "select * from bbs_h where no < ? and available = 1 and category = ? order by no desc limit 10";
		ArrayList<Bbs_hDTO> list = new ArrayList<Bbs_hDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			pstmt.setString(2, category);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs_hDTO bbs = new Bbs_hDTO();
				bbs.setNo(rs.getInt(1));
				bbs.setRest(rs.getString(2));
				bbs.setTitle(rs.getString(3));
				bbs.setUserID(rs.getString(4));
				bbs.setDate(rs.getString(5));
				bbs.setContent(rs.getString(6));
				bbs.setAvailable(rs.getInt(7));
				bbs.setLikecount(rs.getInt(8));
				bbs.setCategory(rs.getString(9));
				list.add(bbs);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//페이징 처리 메소드: 불타입으로 페이지가 존재하는지 조회하는 메소드로 게시글이 10개에서 11개로 넘어갈때 '다음'버튼으로 페이징 처리 
	public boolean nextPage(int pageNumber, String category) {
		String SQL = "select * from bbs_h where available = 1 and category = ? limit ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, category);
			pstmt.setInt(2, listofcategoryCount(category) - (pageNumber - 1) * 10);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//카테고리 별 리스트의 개수
	public int listofcategoryCount(String category) {
		String SQL = "select count(category) from bbs_h where category = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, category);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}	
	
	//게시글 보기 메소드	
	public Bbs_hDTO getBbs_h(int no) {
		String SQL ="select * from bbs_h where no = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, no);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs_hDTO bbs = new Bbs_hDTO();
				bbs.setNo(rs.getInt(1));
				bbs.setRest(rs.getString(2));
				bbs.setTitle(rs.getString(3));
				bbs.setUserID(rs.getString(4));
				bbs.setDate(rs.getString(5));
				if (rs.getString(6) == null) {
					bbs.setContent("");
				} else {
					bbs.setContent(rs.getString(6));
				}
				bbs.setAvailable(rs.getInt(7));
				bbs.setCategory(rs.getString(8));
				return bbs;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//게시글 수정 메소드
	public int update(int no, String rest, String title, String content, String category) {
		String SQL = "update bbs_h set rest = ?, title = ?, content = ? ,category = ? where no = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, rest);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.setString(4, category);
			pstmt.setInt(5, no);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//데이터베이스 오류
	}
	
	//게시글 삭제 메소드 --> 실제 삭제가 아닌 유효번호를 0으로 설정
	public int delete(int no) {
		String SQL = "update bbs_h set available = 0 where no = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, no);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	//데이터베이스 오류
	}
	
	//좋아요
	public int like(String no) {
		PreparedStatement pstmt = null;
		try {
			String SQL = "update bbs_h set likecount = likecount + 1 where no = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(no));
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
}
