<%@page import="com.sound.entity.Users"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Results</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&family=Jua&family=Noto+Sans+KR:wght@500&display=swap"
	rel="stylesheet">
<style>
* {
	font-family: "Jua", sans-serif;
	font-weight: 400;
	font-style: normal;
}

body {
	font-family: Arial, sans-serif;
	background-color: #ffffff;
	margin: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	padding-left: 20px;
	padding-right: 20px;
}

.menu a {
	margin-left: 5px;
	color: #000000; /* 링크 색상 변경 */
	text-decoration: none; /* 밑줄 제거 */
}

a:hover {
	color: #007BFF; /* 마우스를 올렸을 때 색상 변경 */
}

.container {
	background-color: #ffffff;
	width: 430px;
	max-width: 800px;
	padding: 10px 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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

.main-section {
	margin: 20px 0;
	padding: 20px;
	background-color: #fcfcfc;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	margin-bottom: 80px;
}

.result-container {
	margin-top: 20px;
}

.product-item {
	border: 1px solid #ddd;
	padding: 10px; /* 패딩을 줄여서 높이를 맞춤 */
	margin-bottom: 10px;
	display: flex;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
	background-color: #ffffff;
}

.product-item img {
	max-width: 100px; /* 이미지 크기 조정 */
	border-radius: 8px;
	margin-right: 10px;
}

.product-item-content {
	flex-grow: 1;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	width: 100%;
}

.product-item h3 {
	margin: 0;
	font-size: 1em;
}

.product-item a {
	color: #333;
	text-decoration: none;
}

.product-item a:hover {
	text-decoration: underline;
}

.product-item .product-title {
	flex-grow: 1;
}

.product-item .product-price {
	margin: 0;
	font-size: 0.9em;
	color: #555;
	text-align: right;
	align-self: flex-end;
}

.pagination {
	margin-top: 20px;
	display: flex;
	justify-content: center;
}

.pagination button {
	padding: 10px;
	margin: 0 5px;
	border: none;
	background-color: #ddd;
	border-radius: 4px;
	cursor: pointer;
}

.pagination button.active {
	background-color: #333;
	color: #fff;
}

.back-btn {
	display: block;
	margin: 20px auto 0 auto;
	background-color: #66DAE4;
	color: #ffffff;
	padding: 10px 20px;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	text-align: center;
	font-weight: bold;
	font-size: 1em;
	width: 100%;
	max-width: 150px;
}

.back-btn:hover {
	background-color: #5bc0de;
}
</style>
</head>
<body>
	<div class="container">
		<div class="header">
			<div class="logo">
				<a href="GoMain"><img src="img/로고.png" alt="로고"></a>
			</div>
			<%
			// 세션값 가져오기
			Users user = (Users) session.getAttribute("user");
			%>
			<%
			if (user == null) {
			%>
			<div class="menu">
				<a href="Gologin">로그인</a> <a href="GoJoinPage">회원가입</a>
			</div>
			<%
			} else {
			%>
			<div class="menu-icon" onclick="toggleDropdown()">
				<div></div>
				<div></div>
				<div></div>
			</div>
			<div class="dropdown-menu" id="dropdownMenu">
				<a href="mypage.jsp">마이페이지</a> <a href="GoBoard">게시판</a><a
					href="LogoutController">로그아웃</a>
			</div>
			<%
			}
			%>
		</div>


		<div class="main-section">
			<%
			// URL 파라미터에서 비타민 이름 가져오기
			String vitaminName = request.getParameter("vitamin");
			if (vitaminName != null) {
				vitaminName = URLDecoder.decode(vitaminName, "UTF-8");

				// NaverApiController 서블릿 호출
				String apiUrl = "http://localhost:8081/ST/SearchNaverApiController?query="
				+ URLEncoder.encode(vitaminName, "UTF-8");

				try {
					// API 요청 및 응답 받기
					URL url = new URL(apiUrl);
					HttpURLConnection conn = (HttpURLConnection) url.openConnection();
					conn.setRequestMethod("GET");

					int responseCode = conn.getResponseCode();

					if (responseCode == 200) { // 정상 응답
				BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
				String inputLine;
				StringBuffer newResponse = new StringBuffer();
				while ((inputLine = in.readLine()) != null) {
					newResponse.append(inputLine);
				}
				in.close();

				// JSON 파싱
				JSONObject jsonResponse = new JSONObject(newResponse.toString());
				JSONArray items = jsonResponse.getJSONArray("items");

				// 검색 결과를 페이지에 표시
			%>

			<div class="result-container">
				<h2><%=vitaminName%>
					검색 결과
				</h2>
				<%
				for (int i = 0; i < items.length(); i++) {
					JSONObject item = items.getJSONObject(i);
					String title = item.getString("title").replaceAll("<.*?>", ""); // HTML 태그 제거
					String image = item.getString("image");
					String link = item.getString("link");
					String price = item.getString("lprice");
				%>
				<div class="product-item">
					<img src="<%=image%>" alt="<%=title%>">
					<div class="product-item-content">
						<div class="product-title">
							<h3>
								<a href="<%=link%>" target="_blank"><%=title%></a>
							</h3>
						</div>
						<div class="product-price">
							<p><%=price%>
								원
							</p>
						</div>
					</div>
				</div>
				<%
				}
				%>
			</div>

			<%
			} else {
			out.println("<p>API 요청이 실패했습니다. 응답 코드: " + responseCode + "</p>");
			}
			} catch (Exception e) {
			out.println("<p>API 요청 중 오류가 발생했습니다: " + e.getMessage() + "</p>");
			}
			} else {
			out.println("<p>비타민 이름이 제공되지 않았습니다.</p>");
			}
			%>
			<button class="back-btn" onclick="goBack()">확인</button>
		</div>
	</div>

	<script>
		document.querySelector('.menu-icon').addEventListener('click',
				function() {
					var dropdownMenu = document.getElementById('dropdownMenu');
					if (dropdownMenu.style.display === 'block') {
						dropdownMenu.style.display = 'none';
					} else {
						dropdownMenu.style.display = 'block';
					}
				});

		function goBack() {
			window.history.back();
		}
	</script>


</body>
</html>
