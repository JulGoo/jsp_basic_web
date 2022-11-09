<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs_h.Bbs_hDAO"%>
<%@ page import="bbs_h.Bbs_hDTO"%>

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
	
	if (no == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 게시글입니다.')");
		script.println("location.href='bbs_h.jsp'");
		script.println("</script>");
		script.close();
	}
	
	//작성자 본인인지 체크
	Bbs_hDTO bbs = new Bbs_hDAO().getBbs_h(no);
	if(!userID.equals(bbs.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href='bbs_h.jsp'");
		script.println("</script>");
		script.close();
	}else {
		//입력이 안 된 부분 또는 빈칸 체크
		if(request.getParameter("rest") == null || request.getParameter("title") == null 
		|| request.getParameter("rest").equals("") || request.getParameter("title").equals("")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('음식점과 제목을 적어주세요.')");
			script.println("history.back()");
			script.println("</script>");
			script.close();
		}else {
		//글쓰기 로직 수행
		Bbs_hDAO Bbs_hDAO = new Bbs_hDAO();
		int result = Bbs_hDAO.update(no, request.getParameter("rest"), request.getParameter("title"), request.getParameter("content"));
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
				script.println("alert('게시물을 수정했습니다:)')");
				script.println("location.href='bbs_h.jsp'");
				script.println("</script>");
				script.close();
			}	
		}
	}
%>

</body>
</html>