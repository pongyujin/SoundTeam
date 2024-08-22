<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자유게시판</title>
<title>메인 페이지</title>
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
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	height: 100vh;
	box-sizing: border-box;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 0;
	position: relative;
}

.logo img {
	width: 130px; /* 로고 이미지 크기 조정 */
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
	top: 50px;
	right: 0;
	background-color: #ffffff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 5px;
	overflow: hidden;
	z-index: 1000;
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
.board-title {
	text-align: center;
	font-size: 1.5em;
	font-weight: bold;
	margin-bottom: 20px;
}

.search-bar {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-bottom: 20px;
}

.search-bar input {
	padding: 10px;
	width: 70%;
	border: 1px solid #ddd;
	border-radius: 20px;
	margin-right: 10px;
	margin-bottom: 20px;
	margin-top: -80px;
}

.search-bar button {
	padding: 10px 20px;
	background-color: #66DAE4;
	border: none;
	border-radius: 20px;
	cursor: pointer;
	color: #fff;
	font-weight: bold;
	margin-bottom: 20px;
	margin-top: -80px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	margin-bottom: 20px;
	margin-top: -80px;
}

table th, table td {
	padding: 10px;
	border-bottom: 1px solid #ddd;
	text-align: center;
}

.write-btn {
	display: block;
	width: 100%;
	max-width: 150px;
	padding: 15px;
	margin: 0 auto;
	background-color: #B0E9EE;
	color: #000;
	text-align: center;
	text-decoration: none;
	border-radius: 8px;
	font-weight: bold;
	cursor: pointer;
	margin-bottom: 20px;
	margin-top: -50px;
}

.pagination {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

.pagination a {
	margin: 0 5px;
	padding: 10px 15px;
	text-decoration: none;
	color: #000;
	border: 1px solid #ddd;
	border-radius: 5px;
}

.pagination a.active {
	background-color: #66DAE4;
	color: white;
}

.form-group {
	margin-bottom: 10px; /* 간격을 줄임 */
	margin-top:50px;
}

.form-group label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

.form-group input, .form-group textarea {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	box-sizing: border-box;
}

.form-group input[type="file"] {
	padding: 3px;
}

#title {
	margin-bottom: -40px; /* 제목과 내용 간의 간격을 줄임 */
	margin-top: -5px; /* 제목을 살짝 위로 이동 */
}

#content {
	height: 300px; /* 내용을 300px 높이로 조정 */
}

.upload-btn {
	background-color: #66DAE4;
	color: white;
	padding: 10px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-weight: bold;
	width: 100%;
	box-sizing: border-box;
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
			<div class="menu-icon" onclick="toggleDropdown()">
				<div></div>
				<div></div>
				<div></div>
			</div>
			<div class="dropdown-menu" id="dropdownMenu">
				<a href="GoMyPage">마이페이지</a> <a href="GoBoard">게시판</a><a href="LogoutController">로그아웃</a>
			</div>
		</div>
		<h2 class="board-title">글쓰기📝</h2>
		<form id="uploadForm" action="<%= request.getContextPath() %>/BoardWrite" method="post"
			enctype="multipart/form-data">
			<div class="form-group">
				<label for="title">제목</label> 
				<input type="text" id="title" name="title" placeholder="제목을 입력하세요">
			</div>
			<div class="form-group">
				<label for="content">내용</label>
				<textarea id="content" name="content" placeholder="내용을 입력하세요"></textarea>
			</div>
			<div class="form-group">
				<label for="imageUpload">사진첨부</label> 
				<input type="file" id="imageUpload" name="file" accept="image/*">
			</div>
			<button type="submit" class="upload-btn">업로드</button>
		</form>
	</div>
	<script>function toggleDropdown() {
		const dropdownMenu = document.getElementById('dropdownMenu');
		dropdownMenu.style.display = dropdownMenu.style.display === 'block' ? 'none'
				: 'block';
	}</script>
</body>
</html>
