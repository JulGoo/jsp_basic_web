<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs_h.Bbs_hDAO"%>
<%@ page import="bbs_h.Bbs_hDTO"%>
<%@ page import="comment.CommentDAO"%>
<%@ page import="comment.CommentDTO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="home.css" />
<link rel="stylesheet" type="text/css" href="write.css" />
<link rel="stylesheet" href="css/bootstrap.css">

<script type="text/javascript">
	var imgArray = new Array();
	imgArray = [ "김치찌개.png", "돈까스.jpg", "떡볶이.png", "라멘.png", "보쌈.png",
			"부대찌개.jpeg", "비빔밥.png", "삼겹살.jpeg", "샌드위치.png", "알밥.jpg", "우동.png",
			"제육볶음.png", "족발.png", "짜장면.jpg", "초밥.jpeg", "치킨.png", "카레.png",
			"칼국수.jpeg", "피자.png", "햄버거.jpeg", "훠궈.png" ];
	function showImage() {
		var imgNum = Math.round(Math.random() * 11);
		var objImg = document.getElementById("introImg");
		objImg.src = "flist/" + imgArray[imgNum];
	}

	function load(URL) {
		window.open(URL, "mywin", "left=300, top=300, width=450, height=800");
	}
	function loadl(URL) {
		window.open(URL, "mywindow", "left=300, top=100, width=450, height=430");
	}
</script>
</head>

<body>
	<%
	String userID = (String) session.getAttribute("userID");
	String userName = (String) session.getAttribute("userName");

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

	Bbs_hDTO bbs = new Bbs_hDAO().getBbs_h(no);

	//조회수 올리기
	Bbs_hDAO bbss = new Bbs_hDAO();
	bbss.viewcountUpdate(no);

	String ID;
	if (userID == null) {
		ID = "ID";
	} else {
		ID = userID;
	}
	%>

	<div id="wrapper">
		<header>
			<%
			//로그인하지 않았을 때 보여지는 화면 
			if (userID == null) {
			%>
			<nav class="login">
				<ul>
					<li><a href="javascript:loadl('login.jsp')">로그인</a></li>
					<li><a href="javascript:load('join.jsp')">회원가입</a></li>
				</ul>
			</nav>
			<%
			//로그인이 되어있는 상태에서 보여지는 화면 
			} else {
			%>
			<nav class="login">
				<ul>
					<li><%=userID%>(<%=userName%>)님 안녕하세요:)</li>
					<li><a href="logoutAction.jsp">로그아웃</a></li>
				</ul>
			</nav>
			<%
			}
			%>
			<div class="banner">
				<img alt="사진에러" src="media/logo.png" height="110px"
					onclick="javascript:location.href='home.jsp'"
					style="cursor: pointer;">
			</div>
			<nav class="home">
				<ul>
					<li><a href="home.jsp">Home</a></li>
					<li><a href="bbs_h.jsp">한식</a></li>
					<li><a href="bbs_i.jsp">양식</a></li>
					<li><a href="bbs_c.jsp">중식</a></li>
					<li><a href="bbs_j.jsp">일식</a></li>
					<li><a href="bbs_cafe.jsp">카페</a></li>
					<li><a href="bbs_etc.jsp">기타</a></li>
				</ul>
			</nav>
		</header>
		<br>
		
			<div class="moddel">
			<!-- 해당 글의 작성자만 수정, 삭제 가능-->
			<%
			if (userID != null && userID.equals(bbs.getUserID())) {
			%>
			
			<a href="deleteAction.jsp?no=<%=no%>" class="btn btn-outline-dark"
				id="del" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
				<a href="update.jsp?no=<%=no%>" class="btn btn-outline-dark" id="mod">수정</a>
				<br><br>
			<%
			}
			%>
		</div>
		
		<div class="container" id="aaa">
			<div class="row">
				<form method="post" action="writeAction.jsp">
					<table class="table table-bordered" id="bbs">
						<tr>
							<th width=20%>작성자</th>
							<td width=42%><%=bbs.getUserID()%></td>
							<th width=18%>작성일자</th>
							<td width=20%><%=bbs.getDate().substring(0, 11) + bbs.getDate().substring(11, 13) + "시" + bbs.getDate().substring(14, 16) + "분"%></td>
						</tr>
						<tr>
							<th>음식점</th>
							<td colspan=3><%=bbs.getRest()%></td>
						</tr>
						<tr>
							<th>제목</th>
							<td colspan=3><%=bbs.getTitle()%></td>
						</tr>

						<tr>
							<th>내용</th>
							<td colspan=3><%=bbs.getContent().replace("\n", "<br>")%></td>
						</tr>
					</table>
				</form>
			</div>
		</div>

		<a href="likeAction.jsp?no=<%=bbs.getNo()%>"
			class="btn btn-outline-dark" id="like">추천하기</a>

		<%
		String category = bbs.getCategory();
		if (category.equals("kor")) {
		%>

		<a href="bbs_h.jsp" class="btn btn-dark" id="list">목록</a>
		<%
		} else if (category.equals("ita")) {
		%>
		<a href="bbs_i.jsp" class="btn btn-dark" id="list">목록</a>
		<%
		} else if (category.equals("chn")) {
		%>
		<a href="bbs_c.jsp" class="btn btn-dark" id="list">목록</a>
		<%
		} else if (category.equals("jpn")) {
		%>
		<a href="bbs_j.jsp" class="btn btn-dark" id="list">목록</a>
		<%
		} else if (category.equals("cafe")) {
		%>
		<a href="bbs_cafe.jsp" class="btn btn-dark" id="list">목록</a>
		<%
		} else {
		%>
		<a href="bbs_etc.jsp" class="btn btn-dark" id="list">목록</a>
		<%
		}
		%>

		<br> <br> <br>

		<p>&nbsp;댓글</p>
		<%--댓글쓰기--%>
		<div class="container" id="wc">
			<div class="group">
				<form method="post" action="commentAction.jsp?no=<%=no%>">
					<table>
						<tr>
							<td id="id" width=15%><%=ID%></td>
							<td width=75%><input type="text" class="form-control"
								placeholder="댓글을 남겨주세요." name="commentText"></td>
							<td width=3%></td>
							<td width=7%><input type="submit" class="btn-primary pull"
								value="등록"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>


		<br>

		<%--댓글보기--%>
		<div class="container">
			<form method="post" action="commentAction.jsp?no=<%=no%>">
				<%
				CommentDAO commentDAO = new CommentDAO();
				ArrayList<CommentDTO> list = commentDAO.getCommentList(no);
				for (int i = 0; i < list.size(); i++) {
				%>
				<%--댓글 하나하나 당 div --%>
				<div class="con">
					<div class="row">
						<table class="inc">
							<tbody>
								<tr>
									<td width=5%></td>
									<td width=75%><%=list.get(i).getUserID()%></td>
									<td><%=list.get(i).getCommentDate().substring(0, 11) + list.get(i).getCommentDate().substring(11, 13) + "시"
		+ list.get(i).getCommentDate().substring(14, 16) + "분"%></td>
								</tr>
								<tr>
									<td></td>
									<td colspan=2><%=list.get(i).getCommentText()%></td>
								</tr>
								<tr>
									<td colspan=3>
										<%
										if (list.get(i).getUserID() != null && list.get(i).getUserID().equals(userID)) {
										%> <a onclick="return confirm('정말 삭제하시겠습니까?')"
										href="commentDeleteAction.jsp?commentID=<%=list.get(i).getCommentID()%>&&no=<%=no%>"
										class="del">삭제</a> <%
 }
 %>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<br>
				<%
				}
				%>
			</form>
		</div>

		<footer>
			<hr>
			<ul>
				<li><a href="이용약관.pdf">이용약관</a></li>
				<li><a href="">개인정보처리약관</a></li>
				<li>©GYR</li>
			</ul>
		</footer>
	</div>
</body>

</html>