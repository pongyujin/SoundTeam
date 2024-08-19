<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입 페이지</title>
<link rel = "stylesheet" type = "text/css" href="assets/css/all.css">
<style>
* {
	box-sizing: border-box;
	}
body {
    font-family: Arial, sans-serif;
    background-color: #ffffff;
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    flex-direction: column;
    padding: 0 10px;
    box-sizing: border-box;
    
}



.container {
    background-color: #ffffff;
    width: 100%;
    max-width: 430px;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    height: 120vh; /* 배경을 늘리기 위해 100vh 이상으로 설정 */
}


}

.main-header {
	text-align: center;
	font-size: 1.5em;
	font-weight: bold;
	margin-bottom: 1.5em;
	line-height: 1.4em; /* 줄 간격 조정 */
}


.input-group {
	margin-bottom: 1.5em;
}
.input-id {
	margin-bottom: 1.5em;
	
	

}
.container {
    box-sizing: border-box;
    width: 100%;
    
    max-width: 430px;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
   
    box-sizing: border-box;
    

}
.container1 {
    box-sizing: border-box;
    width: 100%;
    
    max-width: 430px;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
   border-radius: 20px;
    box-sizing: border-box;
    

}


.input-group input,
.input-id input {
    width: 100%; /* 입력 필드가 컨테이너의 가로 길이를 채우도록 설정 */
    padding: 10px; /* 패딩 설정 */
    box-sizing: border-box;
    /* 패딩과 보더를 포함한 전체 크기를 계산 */
}

.main-header{
            text-align: center;
            font-size: 1.5em;
            font-weight: bold;
            margin-bottom: 1.5em;

}

.input-group label {
	font-size: 1em;
	margin-bottom: 0.5em;
	display: block;
}
.input-id label {
	font-size: 1em;
	margin-bottom: 0.5em;
	display: block;
}

.input-group input, .input-group select {
	width: 100%;
	padding: 0.5em;
	font-size: 1em;
	border: 1px solid #ddd;
	border-radius: 4px;
}
.input-id input, .input-group select {
	width: calc(100% - 100px); /* 여유를 주기 위해 입력창의 폭을 줄임 */
	padding: 0.5em;
	font-size: 1em;
	border: 1px solid #ddd;
	border-radius: 4px;
	display: inline-block;
	vertical-align: middle;
}

.id-btn {
	width: 80px; /* 버튼 폭 조절 */
	height: 35px; /* 입력창 높이에 맞춤 */
	font-size: 0.9em;
	background-color: #f0f0f0;
	border: 1px solid #ddd;
	border-radius: 4px;
	cursor: pointer;
	display: inline-block;
	vertical-align: middle;
	margin-left: 5px; /* 입력창과 버튼 사이에 약간의 간격 */
}

.submit-btn {
	width: 100%;
	max-width: 300px;
	padding: 1em;
	font-size: 1.5em;
	background-color: #f0f0f0;
	border: 1px solid #ddd;
	border-radius: 8px;
	cursor: pointer;
	text-decoration: none;
	color: #000;
	margin-top: 1.5em;
	text-align: center;
	display: block;
	margin-left: 30px;
	margin-right: 30px; /* 오른쪽으로 이동할 거리 */
}


.submit-btn:hover {
	background-color: #e0e0e0;
}
</style>
</head>
<body>
<div class="container">
	<div class="header">
		<div class="logo"><img src="img/로고.png" alt="로고"></div>
		<div class="menu">
			<a href="Gologin">로그인</a>
		</div>
	</div>
	<div class="container1">
		<div class="main-header">
			<br>더 많은 서비스 이용을 위해<br> 회원가입 해주세요
		</div>

		<form action="join" method="post">

			<div class="input-group">
				<label for="name">이름</label>
				<input type="text" name="name" placeholder="이름을 입력해주세요">
			</div>

			<div class="input-group input-id">
				<label for="userid">아이디</label>
				<input type="text" id="userid" name="userid" placeholder="아이디를 입력해주세요">
				<button type="button" class="id-btn">중복체크</button>
				<p id="useridCheckMessage"></p>
				
			</div>

			<div class="input-group">
				<label for="password">비밀번호</label>
				<input type="password" id="password" name="password" placeholder="비밀번호를 입력해주세요">
			</div>

			<div class="input-group">
				<label for="password-confirm">비밀번호 확인</label>
				<input id="password-confirm" type="password" name="password-confirm" placeholder="비밀번호를 입력해주세요">
				<p id="passwordCheckMessage"></p>
			</div>

			<div class="input-group">
				<label for="email">이메일</label>
				<input type="email" name="email" placeholder="이메일을 입력해주세요">
			</div>

			<div class="input-group">
				<label for="birthdate">생년월일</label>
				<input type="date" name="birthdate">
			</div>

			<div class="input-group">
				<label for="gender">성별</label>
				<select name="gender">
					<option value="male">남</option>
					<option value="female">여</option>
				</select>
			</div>

			<button type="submit" class="submit-btn">회원가입</button>
		</form>
		<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
		<script src="assets/js/join.js"></script>
	</div>
</body>
</html>
