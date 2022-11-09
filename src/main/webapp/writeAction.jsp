<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs_h.Bbs_hDAO"%>
<%@ page import="java.io.PrintWriter"%>
<jsp:useBean id="bbs_h" class="bbs_h.Bbs_hDTO" scope="page" />
<jsp:setProperty name="bbs_h" property="title" />
<jsp:setProperty name="bbs_h" property="rest" />
<jsp:setProperty name="bbs_h" property="content" />
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
	}else {
		//입력이 안 된 부분 체크
		if(bbs_h.getRest() == null || bbs_h.getTitle() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('음식점과 제목을 적어주세요.')");
			script.println("history.back()");
			script.println("</script>");
			script.close();
		}else {
		//글쓰기 로직 수행
		Bbs_hDAO Bbs_hDAO = new Bbs_hDAO();
		int result = Bbs_hDAO.write(bbs_h.getRest(), bbs_h.getTitle(), userID, bbs_h.getContent());
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
				script.println("alert('게시물을 업로드했습니다:)')");
				script.println("location.href='bbs_h.jsp'");
				script.println("</script>");
				script.close();
			}	
		}
	}
%>

</body>
</html>