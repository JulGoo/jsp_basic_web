<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.UserDTO" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPW" />

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Insert title here</title>
</head>
<body>
	<%
	String userID = (String) request.getParameter("floatingInput");
	String userPW = (String) request.getParameter("floatingPassword");
	UserDAO UserDAO = new UserDAO();
	String result = UserDAO.login(userID, userPW);
	if (result == "a") { //비밀번호 오류
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 일치하지 않습니다:(')");
		script.println("history.back()");
		script.println("</script>");
	} else if (result == "b") { //아이디 없음
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다!')");
		script.println("history.back()");
		script.println("</script>");
	} else if (result == "c") { //데이터베이스 오류
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Database error')");
		script.println("history.back()");
		script.println("</script>");
	}
	else { //로그인 성공
		PrintWriter script = response.getWriter();
		session.setAttribute("userID", userID);
		session.setAttribute("userName", result);
		script.println("<script>");
		script.println("javascript:window.close();");
		script.println("opener.parent.location.reload();");
		script.println("</script>");
	}
	%>
</body>
</html>