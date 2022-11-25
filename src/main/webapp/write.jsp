<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
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
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요한 서비스입니다.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
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
			<img alt="사진에러" src="media/logo.png" height="110px" onclick="javascript:location.href='home.jsp'" style="cursor: pointer;">
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
		<br> <br>

		<div class="container">
			<div class="row">
				<form method="post" action="writeAction.jsp">
					<table class="table table-bordered">
						<tr>
							<th>카테고리</th>
							<td>
								<select name="category">
									<option value="">===선택===</option>
									<option value="kor">한식</option>
									<option value="ita">양식</option>
									<option value="chn">중식</option>
									<option value="jpn">일식</option>
									<option value="cafe">카페</option>
									<option value="etc">기타</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>음식점</th>
							<td><input type="text" class="form-control"
								placeholder="음식점 이름을 적어주세요." name="rest" maxlength="30"></td>
						</tr>
						<tr>
							<th>제목</th>
							<td><input type="text" class="form-control"
								placeholder="제목을 적어주세요." name="title" maxlength="30"></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea class="form-control" placeholder="내용을 적어주세요."
									name="content" maxlength="1024"></textarea></td>
						</tr>
					</table>
					<input type="submit" class="btn btn-outline-dark" value="작성"
						id="save">
				</form>
			</div>
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