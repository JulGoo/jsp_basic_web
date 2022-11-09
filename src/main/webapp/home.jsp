<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="home.css" />
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
					<li><a href="#">양식</a></li>
					<li><a href="#">중식</a></li>
					<li><a href="#">일식</a></li>
					<li><a href="#">카페</a></li>
					<li><a href="#">기타</a></li>
				</ul>
			</nav>
		</header>

		<section>
			<h2>오늘의 추천 메뉴!</h2>
			<br>
			<div onclick="showImage()">
				<img id="introImg" src="flist/Food_recmd.png" width="650px"
					height="500px">
			</div>

		</section>

		<aside>
			<div>
				<h3>&lt; 학식 바로가기 &gt;</h3>
				<nav class="aside">
					<ul>
						<li><a href="https://www.inha.ac.kr/kr/1072/subview.do" target="_blank"><img
								src="media/inha.png" alt="inha" width="150px"></a></li>
						<li><a href="https://www.inhatc.ac.kr/kr/485/subview.do" target="_blank"><img
								src="media/inhatc.png" alt="inhatc" width="150px"></a></li>
						<li><a
							href="https://map.naver.com/v5/search/%EC%9D%8C%EC%8B%9D%EC%A0%90?c=14099551.4981294,4501937.4959964,15,0,0,0,dh" target="_blank"><img
								src="media/navermap.png" alt="navermap" width="150px"></a></li>
					</ul>
				</nav>
			</div>
		</aside>

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