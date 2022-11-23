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
	<h1>회원가입</h1>
	<br>
	<div id="container">
		<form method="post" action="joinAction.jsp">
			<br>
			<img alt="logo" src="media/logo.png" width="450px">
			<div id="inner">
				아이디<br>
					<input type="text" class="form-control" name="userID" maxlength="20" placeholder="UserID"><br>
				비밀번호<br>
    				<input type="password" class="form-control" name="userPW" id="inputPassword" placeholder="Password"><br>
				이름<br>
					<input type="text" class="form-control" name="userName" maxlength="20" placeholder="Name"><br>
					<label for="exampleFormControlInput1" class="form-label">이메일</label>
 					<input type="email" class="form-control" name="userEmail" id="exampleFormControlInput1" placeholder="name@example.com"><br>
				전화번호<br>
 					<select name="phone1">
						<option>010</option>
						<option>02</option>
						<option>031</option>
						<option>032</option>
						<option>033</option>
						<option>041</option>
						<option>042</option>
						<option>043</option>
						<option>044</option>
						<option>051</option>
						<option>052</option>
						<option>053</option>
						<option>054</option>
						<option>055</option>
						<option>061</option>
						<option>062</option>
						<option>063</option>
						<option>064</option>
					</select>
					- <input type="text" name="phone2" maxlength="4" size="6">
					- <input type="text" name="phone3" size="6" maxlength="4"> <br><br>
 				성별<br>
  					<input class="form-check-input" type="radio" name="userGender" id="inlineRadio1" value="여성">
  					<label class="form-check-label" for="inlineRadio1">여성&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> 
  					<input class="form-check-input" type="radio" name="userGender" id="inlineRadio2" value="남성">
					<label class="form-check-label" for="inlineRadio2">남성</label><br><br>
					<button type="submit" class="btn btn-dark">Sign up</button>
			</div>
		</form>
	</div>
		<br>
		<br>
		<br>
	</body>
</html>