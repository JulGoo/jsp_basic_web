<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="comment.CommentDAO"%>
<%@ page import="java.io.PrintWriter"%>
<jsp:useBean id="comment" class="comment.CommentDTO" scope="page" />
<jsp:setProperty name="comment" property="commentText" />
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
	
	String commentText = "";
	commentText = request.getParameter("commentText");
	
	int no =0;
	no = Integer.parseInt(request.getParameter("no"));
 
	//로그인한 회원만 댓글쓰기 가능
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
	}else {
		//입력이 안 된 부분 체크
		if(commentText == ""){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('댓글을 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
			script.close();
		}else {
		//댓글 쓰기
		CommentDAO Comment = new CommentDAO();
		int result = Comment.write(no, userID, commentText);
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
				script.println("alert('댓글을 업로드했습니다:)')");
				script.print("location.href='view.jsp?no=");
				script.print(no);
				script.println("';");
				script.println("</script>");
				script.close();
			}	
		}
	}
%>

</body>
</html>