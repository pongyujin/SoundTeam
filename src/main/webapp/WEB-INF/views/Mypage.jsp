<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.sound.entity.Ai_recommendation"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.sound.entity.Users"%>


<%
// 세션에서 'recommendations' 리스트를 가져옵니다.
List<Ai_recommendation> recommendations = (List<Ai_recommendation>) session.getAttribute("recommendations");

// recommendations가 null인지 확인
if (recommendations == null) {
	recommendations = new ArrayList<>(); // null 방지를 위해 빈 리스트로 초기화
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지 - 추천 영양제</title>
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
	text-rendering: optimizeLegibility;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
}

body {
	font-family: Arial, sans-serif;
	background-color:  #ffffff;
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
	position: relative;
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
    position: relative; /* 드롭다운 메뉴 위치를 아이콘 기준으로 설정하기 위해 추가 */
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

.h1 {
	text-align: center;
}

.name {
	font-size: 1.5em;
	margin: 0;
	padding-bottom: 10px;
	margin-top: 50px;
	text-align: center;
}

.edit-profile-btn {
	background-color: #B0E9EE;
	color: black;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	margin-bottom: 50px;
	font-weight: bold;
	text-align: center;
	display: block;
	width: 100%;
	max-width: 150px;
	margin: 10px auto;
	margin-left: 0;
	margin-right: auto;
	margin-top: 50px;
}

.edit-profile-btn:hover {
	background-color: #5bc0de;
}

.h {
	font-size: 1.2em;
	margin-left: 10px;
	font-weight: 700;
	margin-top: 40px;
}

.supplement-list {
	list-style: none;
	padding: 0;
	margin: 20px 0;
}

.supplement-item {
	background-color: #f9f9f9;
	padding: 15px;
	margin-bottom: 10px;
	border-radius: 8px;
	cursor: pointer;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.pagination {
	display: flex;
	justify-content: center;
	margin-top: 20px;
}

.page-number {
	padding: 5px 10px;
	border: 1px solid #ccc;
	margin: 0 5px;
	cursor: pointer;
}

.page-number.active {
	background-color: #66DAE4;
	color: white;
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
				<a href="GoMyPage1">마이페이지</a> <a href="GoBoard">게시판</a><a href="LogoutController">로그아웃</a>
			</div>
		</div>
		<h1 class="h1">마이페이지</h1>

		<!-- 사용자 이름 표시 -->
		<h1 class="name">
			<%
			Users user = (Users) session.getAttribute("user");
			%>
			<%=user.getUsrName()%>님😊
		</h1>

		<!-- 회원정보 수정 버튼 -->
		<button class="edit-profile-btn"
			onclick="location.href='GoInformation1'">회원정보 수정</button>

		<h6 class="h">추천받은 정보 확인하기</h6>
		<ul class="supplement-list" id="supplementList">
			<!-- 여기에 자바스크립트로 리스트를 추가할 것입니다 -->
		</ul>
		<div class="pagination">
			<!-- 페이지네이션 버튼이 동적으로 추가됩니다 -->
		</div>
	</div>
	<script>
		// 자바스크립트에 추천 정보를 전달하기 위해 JSP에서 데이터를 자바스크립트 배열로 변환
		let supplements = [];
		let userId = "<%=user.getUsrId()%>"; // 현재 세션에서 userId 가져오기
		
		
		<%if (recommendations != null && !recommendations.isEmpty()) {
	for (Ai_recommendation rec : recommendations) {%>
		supplements.push({
			suggId: "<%=rec.getSuggId()%>", // suggId를 포함
			date: "<%=rec.getSuggestedAt().toString().substring(0, 10)%>", 
			time: "<%=rec.getSuggestedAt().toString().substring(11, 16)%>",
			name: "<%=rec.getNutrId()%>"
		});
		<%}
}%>

        let currentPage = 1;
        const perPage = 5; 

        function renderSupplements() { 
            const list = document.getElementById('supplementList');
            list.innerHTML = ''; // 목록 초기화

            const start = (currentPage - 1) * perPage;
            const end = start + perPage;
            const currentItems = supplements.slice(start, end);

            currentItems.forEach(item => {
                const li = document.createElement('li');
                li.className = 'supplement-item';
                li.innerText = `${item.date} ${item.time} - ${item.name}`;
                li.onclick = function() {
                	// MyPagerecommendPage 서블릿으로 이동하면서 suggId와 userId를 전달
                    window.location.href = `MyPageController?suggId=${item.suggId}&userId=${userId}`;

             };
                list.appendChild(li);
            });
        }

        function renderPagination() {
            const pagination = document.querySelector('.pagination');
            pagination.innerHTML = ''; // 페이지네이션 초기화

            const pageCount = Math.ceil(supplements.length / perPage);
            for (let i = 1; i <= pageCount; i++) {
                const span = document.createElement('span');
                span.className = 'page-number' + (i === currentPage ? ' active' : '');
                span.innerText = i;
                span.onclick = () => {
                    currentPage = i;
                    renderSupplements();
                    renderPagination();
                };
                pagination.appendChild(span);
            }
        }

        window.onload = function() {
            renderSupplements();
            renderPagination();
        };

        function toggleDropdown() {
            const dropdown = document.getElementById('dropdownMenu');
            dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
        }
    </script>
</body>
</html>
