<%@page import="java.math.BigInteger"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인 페이지</title>
<link rel = "stylesheet" type = "text/css" href="assets/css/all.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&family=Jua&family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<style>
*  {
  font-family: "Jua", sans-serif;
  font-weight: 400;
  font-style: normal;

}


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
    height: 100vh;
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
}

.logo img {
    width: 130px; /* 로고 이미지 크기 조정 */
}

.menu a {
    margin-left: 1em;
    text-decoration: none;
    color: #000;
    font-size: 0.9em;
}

.main-header {
    text-align: center;
    font-size: 1.5em;
    font-weight: bold;
    margin-bottom: 1.5em;
    line-height: 1.4em;
}
.sub-header {
    text-align: center;
    font-size: 1.3em;
    font-weight: bold;
    margin-bottom: 1.5em;
    line-height: 1.4em;
}

.input-group {
    margin-bottom: 1.2em; /* 간격 조금 줄임 */
}

.input-field {
    width: 82%;
    padding: 6px; /* 입력 필드 패딩 줄임 */
    font-size: 1em;
    border: 1px solid #ddd;
    border-radius: 8px;
    margin-bottom: 0.5em; /* 간격 조금 줄임 */
    box-sizing: border-box;
}

.login-btn {
    width: 100%;
    max-width: 300px; /* 카카오 로그인 크기에 맞춤 */
    padding: 12px; /* 버튼 패딩 줄임 */
    font-size: 1.2em;
    background-color: #A3ECF2;
    border: 1px solid #ddd;
    border-radius: 8px;
    cursor: pointer;
    text-decoration: none;
    color: #000;
    text-align: center;
    margin: 0.5em auto;
    display: block;
}

.social-login-btn img {
    width: 100%;
    max-width: 300px;
    object-fit: cover; /* 이미지가 버튼 크기에 맞게 조절 */
    height: auto;
    margin: 0.5em auto;
}

.buttons-container {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.box-container {
    background-color: #ffffff;
    padding: 20px;
    border-radius: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    position: relative; /* relative로 설정 */
    top: -140px; /* 위로 50px 이동 */
    text-align: center;
}

}
</style>
</head>
<body>
	<div class="container">
		<div class="header">
			<div class="logo"><a href="GoMain"><img src="img/로고.png" alt="로고"></div>
			<div class="menu">
				<a href="GoJoinPage">회원가입</a>
			</div>
		</div>

		<div class="box-container"> <!-- 네모 상자 시작 -->
			<div class="main-header">환영합니다!</div>
			<div class="sub-header">더 많은 서비스 이용을 위해 <br>로그인 해주세요.</div>

			<form action="login" method="post">
				<div class="input-group">
					<input type="text" name="usr_id" class="input-field" placeholder="아이디를 입력해주세요">
				</div>
				<div class="input-group">
					<input type="password" name="usr_pw" class="input-field" placeholder="비밀번호를 입력해주세요">
				</div>

				<button type="submit" class="login-btn">로그인</button>
			</form>
		 <!-- 네모 상자 끝 -->

		<div class="buttons-container">
			<a href="<%=request.getContextPath()%>/kakaologin" class="social-login-btn">
				<img src="img/카카오버튼.png" alt="카카오 로그인">
			</a>
			<a href="<%=request.getContextPath()%>/naverlogin" class="social-login-btn">
				<img src="img/btnG_완성형.png" alt="네이버 로그인">
			</a>
		</div>
	</div>
	</div>
</body>
</html>
