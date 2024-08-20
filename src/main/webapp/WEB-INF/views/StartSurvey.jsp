<%@page import="com.sound.entity.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>메인 페이지</title>
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
	justify-content: space-between;
	box-sizing: border-box;
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
			</div>
			<div class="menu-icon">
				<div></div>
				<div></div>
				<div></div>
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
