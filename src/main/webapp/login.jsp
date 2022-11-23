<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="join.css">
<link rel="stylesheet" href="css/bootstrap.css">
</head>
<body>
	<br>
	<h1>로그인</h1>
	<br>
	<div id="container">
		<form method="post" action="loginAction.jsp">
			<br> <img alt="logo" src="media/logo.png" width="450px">
			<div id="inner">
				<div class="form-floating mb-3">
					<input type="text" class="form-control" id="floatingInput" name="floatingInput"
						placeholder="ID"> <label for="floatingInput">ID</label>
				</div>
				<div class="form-floating">
					<input type="password" class="form-control" id="floatingPassword" name="floatingPassword"
						placeholder="Password"> <label for="floatingPassword">Password</label>
				</div>
				<br>
				<button type="submit" id="submit" class="btn btn-dark">Sign
					in</button>
			</div>
		</form>
	</div>
</body>
</html>