<%@page import="com.sound.entity.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메인 페이지</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&family=Jua&family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<style>
*  {
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
	justify-content: space-between;
	box-sizing: border-box;
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
    position: relative; /* 추가 */
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
    left: 325px; /* 또는 right: auto; */
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


.image-container {
    width: 100%;
    height: 400px;
    background-color: white;
    border-radius: 8px;
    margin-bottom: 25px;
    display: flex;  /* flexbox를 사용하여 자식 요소를 정렬 */
    justify-content: center;  /* 가로 중앙 정렬 */
    align-items: center;  /* 세로 중앙 정렬 */
}

.image-container img {
 
    width: 500px;  /* 더 큰 너비로 설정 */
    height: 500px;  /* 더 큰 높이로 설정 */
    border-radius: 8px;
    object-fit: cover;

  /* 이미지의 최대 높이를 부모 요소의 80%로 설정 */
    border-radius: 8px;
}

.button {
	background-color: #B0E9EE;
	padding: 18px 35px;
	margin: -15px 0;
	font-size: 1.2em;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	text-align: center;
	width: 100%;
	color: #000;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	margin-bottom: 200px;
}

.button.alt {
	background-color: #66DAE4;
	margin-bottom: 200px;
}

.button.disabled {
	background-color: #ccc; /* 비활성화된 버튼 색상 */
	cursor: not-allowed; /* 커서 모양 변경 */
}
</style>
</head>
<body>
	<div class="container">
		<div class="header">
			<div class="logo">
				<img src="img/로고.png" id="logo_img" alt="로고">

wn-menu" id="dropdownMenu">
				<a href="GoMyPage1">마이페이지</a> <a href="GoBoard">게시판</a> <a hred="LogoutController">로그아웃</a>
			</div>
			</div>
		

		<div class="image-container">
		    <img src="img/건강설문.png" alt="이미지 설명">
		</div>

		<!-- 건강설문시 로그인 했는지 확인 문구 필요함 -->
		<%
		Users user = (Users) session.getAttribute("user");
		System.out.print("세션 값있냐?" + user);
		System.out.println("세션 ID: " + session.getId());
		%>

		<button class="button" id="checklist_btn" <%=(user == null) ? "class='disabled'" : ""%>>
		    건강설문 시작하기
		</button>

	</div>

	<script>
	document.querySelector('.menu-icon').addEventListener('click', function() {
	    var dropdownMenu = document.getElementById('dropdownMenu');
	    if (dropdownMenu.style.display === 'block') {
	        dropdownMenu.style.display = 'none';
	    } else {
	        dropdownMenu.style.display = 'block';
	    }
	});

        document.getElementById("logo_img").addEventListener("click", function() {
            window.location.href = "<%=request.getContextPath()%>/GoMain";
        });
        
    	document.getElementById("checklist_btn").addEventListener("click", function() {
        <%if (user == null) {%>
            alert("로그인이 필요합니다.");
        <%} else {%>
            window.location.href = "<%=request.getContextPath()%>/GoCheckListPage";
	<%}%>
		});
	</script>
</body>
</html>
