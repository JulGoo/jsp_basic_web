<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="bbs_h.Bbs_hDAO"%>
<%@ page import="likey.LikeyDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%!
	public static String getClientIP(HttpServletRequest request) {
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
%>
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
	//로그인한 회원만 추천 가능
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
	}
	
	String no = null;
	no = (String) request.getParameter("no");

	Bbs_hDAO bbs = new Bbs_hDAO();
	LikeyDAO likey = new LikeyDAO();
	int result = likey.like(userID, no, getClientIP(request));
	if(result == 1) {
		result = bbs.like(no);
		if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('좋아요:)');");
			script.println("history.back()");
			script.println("</script>");
			script.close();
		}else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Database error');");
			script.println("history.back()");
			script.println("</script>");
			script.close();
		}
	}else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 추천한 글입니다.');");
		script.println("history.back()");
		script.println("</script>");
		script.close();
	}
%>
</body>
</html>