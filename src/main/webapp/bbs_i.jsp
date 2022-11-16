<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="bbs_h.Bbs_hDAO"%>
<%@ page import="bbs_h.Bbs_hDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="home.css" />
<link rel="stylesheet" type="text/css" href="bbs.css" />
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
</script>
</head>
<body>
	<%
	String userID = (String) session.getAttribute("userID");
	String userName = (String) session.getAttribute("userName");

	int pageNumber = 1; //기본 1 페이지 할당

	//파라미터의 기본 데이터형식이 object이기 때문에 형변환 필요
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
					<li><a href="javascript:load('login.jsp')">로그인</a></li>
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
		
		<!-- 테이블 생성 -->
		<h3>양식 추천 목록</h3>
		<div class="container">
			<div class="row">
				<table class="table table-striped table-hover">
					<thead class="table-dark">
						<tr>
							<th>번호</th>
							<th>음식점</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>추천수</th>
						</tr>
					</thead>
					<tbody>
						<%
						Bbs_hDAO bbs = new Bbs_hDAO();
						ArrayList<Bbs_hDTO> list = bbs.getCategoryList(pageNumber, "ita");
						for (int i = 0; i < list.size(); i++) {
						%>
						<tr onclick="location.href='view.jsp?no=<%= list.get(i).getNo() %>'">
							<td><%=i+1 %></td>
							<td><%=list.get(i).getRest() %></td>
							<td><%=list.get(i).getTitle() %></td>
							<td><%=list.get(i).getUserID()%></td>
							<td><%=list.get(i).getDate().substring(0, 11) + list.get(i).getDate().substring(11, 13) + "시"
									+ list.get(i).getDate().substring(14, 16) + "분"%></td>
							<td><%=list.get(i).getLikecount() %></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>

				<!-- 페이징 처리 영역 -->
				<%
				if(pageNumber != 1) {
				%>
				<a href="bbs_i.jsp?pageNumber=<%= pageNumber - 1 %>" class="btn btn-light">이전</a>
				<%
				} if(bbs.nextPage(pageNumber + 1, "ita")) {
				%>
				<a href="bbs_i.jsp?pageNumber=<%= pageNumber + 1 %>" class="btn btn-light">다음</a>
				<%
				}
				%> 				
				<br>
				
				<!-- 글쓰기 버튼 생성 -->
				<input type="button" class="btn btn-dark" value="글쓰기"
					id="write" onClick="location.href='write.jsp'">
			</div>
		</div>
		<br> <br>

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