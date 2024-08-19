<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>추천된 영양제</title>
<link rel="stylesheet" href="assets/css/style.css">
<style>
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
}

.container {
	background-color: #ffffff;
	width: 450px; /* 너비를 맞춤 */
	max-width: 800px;
	padding: 10px 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	height: 100vh; /* 높이를 맞춤 */
	display: flex;
	flex-direction: column;
	justify-content: flex-start; /* 상단에 배치 */
	box-sizing: border-box;
	overflow-y: auto; /* 스크롤 가능하도록 설정 */
	margin-top: -50px; /* 전체 컨테이너를 위로 올림 */
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 0;
}

.logo img {
	width: 100px; /* 로고 이미지 크기 조정 */
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

.text-container {
	text-align: center; /* 가로 중앙 정렬 */
	margin-top: 50px; /* 상단 여백 조정 */
}

.text-container h2 {
	font-size: 1.5em; /* 제목 크기 조정 */
	margin: 0; /* 여백 제거 */
	padding-bottom: 10px; /* 아래쪽 패딩 추가 */
}

.text-container p {
	font-size: 1em; /* 문단 크기 조정 */
	margin: 0; /* 여백 제거 */
	margin-top: 15px; /* 위쪽 여백 추가 */
}

.product-item {
	border: 2px solid #C2BBBB; /* 검은색 테두리 */
	border-radius: 15px; /* 모서리를 둥글게 */
	height: 300px; /* 박스의 크기를 크게 설정 */
	margin-bottom: 40px;
	margin-top: 50px;
	position: relative;
	display: flex; /* flexbox를 사용해 중앙 정렬 */
	align-items: center; /* 수직 중앙 정렬 */
	justify-content: center; /* 수평 중앙 정렬 */
	font-size: 1.5em; /* 글씨 크기 증가 */
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 약간의 그림자 추가 */
}

.product-item::before {
	content: attr(data-title); /* 제목을 content 속성으로 추가 */
	position: absolute;
	top: -20px; /* 제목 위치를 위로 조정 */
	left: 50%; /* 왼쪽에서 50% 위치 */
	transform: translateX(-50%); /* 제목을 중앙 정렬 */
	background-color: #ffffff; /* 배경색 흰색으로 설정 */
	padding: 0 10px;
	font-size: 1.2em;
	font-weight: bold;
	text-align: center; /* 제목 텍스트를 중앙 정렬 */
}
</style>
</head>
<body>

	<div class="container">
		<div class="header">
			<div class="logo">
				<img src="img/로고.png" alt="로고">
			</div>
			<div class="menu-icon">
				<div></div>
				<div></div>
				<div></div>
			</div>
		</div>

		<div class="main-content">
			<h2><%=request.getAttribute("userId")%>님께 추천된 영양제 입니다.
			</h2>
			<p>제품을 눌러 영양정보 확인하기</p>

			<%
				List<String> links = (List<String>) request.getAttribute("links");
				List<String> images = (List<String>) request.getAttribute("images");
				List<String> titles = (List<String>) request.getAttribute("titles");
				String suggReason = (String) request.getAttribute("suggReason");
				String aiResult = (String) request.getAttribute("aiResult");
				String interActions = (String) request.getAttribute("interActions");

				if (links != null && !links.isEmpty() && images != null && !images.isEmpty() && titles != null && !titles.isEmpty()) {
			%>

			<!-- 영양제 -->
			<div class="product-item" data-title="영양제">
				<a href="<%= links.get(0) %>">
					<img src="<%= images.get(0) %>" alt="영양제 이미지">
					<p><%= titles.get(0) %></p>
				</a>
				<p>
					<strong>추천 이유:</strong>
					<%= suggReason %>
				</p>
			</div>

			<% } else { %>
			<!-- 기본 콘텐츠 -->
			<div class="product-item" data-title="영양제">
				<a href="#">
					<img src="/path/to/default/image.jpg" alt="기본 이미지">
					<p>추천된 영양제가 없습니다.</p>
				</a>
				<p><strong>추천 이유:</strong> 추천된 이유가 없습니다.</p>
			</div>
			<% } %>

			<!-- 영양식품 -->
			<div class="product-item" data-title="영양식품">
				<p>
					<strong>AI 결과:</strong>
					<%= aiResult != null ? aiResult : "AI 결과가 없습니다." %>
				</p>
			</div>

			<!-- 상호작용 -->
			<div class="product-item" data-title="상호작용">
				<p>
					<strong>상호작용:</strong>
					<%= interActions != null ? interActions : "상호작용 정보가 없습니다." %>
				</p>
			</div>
		</div>
	</div>

</body>
</html>
