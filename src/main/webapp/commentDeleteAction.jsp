<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="comment.CommentDAO"%>
<%@ page import="comment.CommentDTO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	//현재 세션 확인
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	//로그인한 회원만 글쓰기 가능
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
	}
	
	
	int no = 0;
	no = Integer.parseInt(request.getParameter("no"));
	
	int commentID = 0;
	commentID = Integer.parseInt(request.getParameter("commentID"));
	
	if (no == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 게시글입니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
	}
	
	//작성자 본인인지 체크
	CommentDTO comment = new CommentDAO().getCommentID(commentID);
	CommentDAO test = new CommentDAO();
	String dbvalue = test.whatuserID(commentID);
	if(!userID.equals(dbvalue)) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
	}else {
		//게시글 삭제 로직 수행
		CommentDAO cmmt = new CommentDAO();
		int result = cmmt.delete(commentID);
		//데이터베이스 오류인 경우
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('Database error')");
				script.println("history.back()");
				script.println("</script>");
				script.close();
			//정상적으로 실행됐을 경우
			}else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('댓글을 삭제했습니다:)')");
				script.print("location.href='view.jsp?no=");
				script.print(no);
				script.println("';");
				script.println("</script>");
				script.close();
			}	
		}
%>

</body>
</html>