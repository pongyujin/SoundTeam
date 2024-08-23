<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.sound.entity.Users"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원정보 수정</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&family=Jua&family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<style>
*  {
  font-family: "Jua", sans-serif;
  font-weight: 400;
  font-style: normal;
    text-rendering: optimizeLegibility;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;

  
  }
body {
	font-family: Arial, sans-serif;
	background-color: #ffffff;
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.container {
	background-color: #ffffff;
	width: 100%;
	max-width: 430px;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	display: flex;
	flex-direction: column;
	overflow-y: auto;
	height: 100%;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 0;
	position: relative; /* 드롭다운 메뉴 위치를 설정하기 위해 relative 추가 */
}

.logo img {
	width: 130px;
}

.menu-icon {
	width: 30px;
	height: 30px;
	cursor: pointer;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.menu-icon div {
	width: 100%;
	height: 4px;
	background-color: #000;
}

.dropdown-menu {
	display: none;
	position: absolute;
	top: 30%; /* 아이콘 바로 아래에 위치하도록 설정 */
	right: 0; /* 아이콘에 맞추어 오른쪽 정렬 */
	background-color: #ffffff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 5px;
	overflow: hidden;
	z-index: 1000;
	margin-top: 10px; /* 아이콘과 드롭다운 메뉴 사이의 간격을 조금 추가 */
	font-family: "Jua", sans-serif;
	font-weight: 400;
	font-style: normal;
}

.dropdown-menu a {
	display: block;
	padding: 10px;
	text-decoration: none;
	color: #000;
	border-bottom: 1px solid #ddd;
}

.dropdown-menu a:last-child {
	border-bottom: none;
}

.dropdown-menu a:hover {
	background-color: #f0f0f0;
}
.main-header {
	text-align: center;
	font-size: 1.5em;
	font-weight: bold;
	margin-bottom: 1.5em;
}

.input-group {
	margin-bottom: 1.5em;
	margin-top: 2.0em;
}

.input-group input {
	width: 100%;
	padding: 10px;
	box-sizing: border-box;
	border: 1px solid #ddd;
	border-radius: 4px;
	font-size: 1em;
}

.input-group label {
	font-size: 1em;
	margin-bottom: 0.5em;
	display: block;
}

.submit-btn {
	width: 100%;
	max-width: 300px;
	padding: 1em;
	font-size: 1.5em;
	background-color: #B0E9EE;
	border: 1px solid #ddd;
	border-radius: 8px;
	cursor: pointer;
	text-decoration: none;
	color: #000;
	margin-top: 4.0em;
	text-align: center;
	display: block;
	margin-left: auto;
	margin-right: auto;
}

.submit-btn:hover {
	background-color: #e0e0e0;
}
</style>
</head>
<body>
	<div class="container">
		<div class="header">
			<div class="logo">

				<a href="GoMain"> <img src="img/로고.png" alt="로고">
				</a>
			</div>
			<div class="menu-icon">
				<div></div>
				<div></div>
				<div></div>
			</div>
			<div class="dropdown-menu" id="dropdownMenu">
				<a href="GoMyPage1">마이페이지</a> <a href="GoBoard">게시판</a> <a href="LogoutController">로그아웃</a>
			</div>
		</div>
		<div class="main-header">
			<br>회원정보 수정
		</div>

		<form action="<%= request.getContextPath() %>/update" method="post">
			<div class="input-group">
				<label for="name">이름</label> <input type="text" id="name"
					name="name"
					value="<%= ((Users) session.getAttribute("user")).getUsrName() %>"
					required>
			</div>

			<div class="input-group">
				<label for="password">비밀번호</label> <input type="password"
					id="password" name="password" placeholder="비밀번호를 입력해주세요" required>
			</div>

			<div class="input-group">
				<label for="password-confirm">비밀번호 확인</label> <input
					id="password-confirm" type="password" name="password-confirm"
					placeholder="비밀번호를 다시 입력해주세요">
			</div>


			<div class="input-group">
				<label for="email">이메일</label> <input type="email" id="email"
					name="email"
					value="<%= ((Users) session.getAttribute("user")).getUsrEmail() %>"
					required>
			</div>

			<button type="submit" class="submit-btn">정보 수정하기</button>
		</form>
	</div>

	<%-- 정보 수정 성공 또는 실패 시 알람 표시 --%>
	<%
        String updateStatus = (String) request.getAttribute("updateStatus");
        if ("success".equals(updateStatus)) {
    %>
	<script>
            alert("회원정보가 성공적으로 수정되었습니다.");
            window.location.href = "<%= request.getContextPath() %>/Mypage.jsp";
        </script>
	<%
        } else if ("fail".equals(updateStatus)) {
    %>
	<script>
            alert("회원정보 수정에 실패했습니다. 다시 시도해주세요.");
            window.location.href = "<%= request.getContextPath() %>/information.jsp";
        </script>
	<%
        }
    %>
    <script >document.querySelector('.menu-icon').addEventListener('click', function() {
	    var dropdownMenu = document.getElementById('dropdownMenu');
	    if (dropdownMenu.style.display === 'block') {
	        dropdownMenu.style.display = 'none';
	    } else {
	        dropdownMenu.style.display = 'block';
	    }
	});</script>
</body>
</html>