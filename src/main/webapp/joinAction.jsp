<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	//사용자가 보낸 데이터를 한글을 사용할 수 있는 형식으로 변환
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPW = null;
	String userName = null;
	String userEmail = null;
	String userPhone = null;
	String userGender = null;
	String phone1 = null;
	String phone2 = null;
	String phone3 = null;

	if (request.getParameter("userID") != null) {
		userID = (String) request.getParameter("userID");
	}

	if (request.getParameter("userPW") != null) {
		userPW = (String) request.getParameter("userPW");
	}
	
	if (request.getParameter("userName") != null) {
		userName = (String) request.getParameter("userName");
	}
	
	if (request.getParameter("userEmail") != null) {
		userEmail = (String) request.getParameter("userEmail");
	}
    
    phone1 = request.getParameter("phone1");
    phone2 = request.getParameter("phone2");
    phone3 = request.getParameter("phone3");
    userPhone = phone1 + "-" + phone2 + "-" + phone3;
    
	if (request.getParameter("userPhone") != null) {
		userPhone = (String) request.getParameter("userPhone");
	}
	
	if (request.getParameter("userGender") != null) {
		userGender = (String) request.getParameter("userGender");
	}

	if (userID == null || userPW == null || userName == null || userEmail == null || userPhone == null || userGender == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('모든 정보를 입력해주세요:(')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}

	UserDAO UserDAO = new UserDAO();
	int result = UserDAO.join(userID, userPW, userName, userEmail, userPhone, userGender);
	if (result == 1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('회원가입을 축하합니다:)')");
		script.println("javascript:window.close();");
		script.println("opener.parent.location.reload();");
		script.println("</script>");
		script.close();
	}
	else if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Database error')");
		script.println("javascript:window.close();");
		script.println("</script>");
		script.close();
	}
%>
