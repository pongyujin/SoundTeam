<%@page import="com.sound.entity.Products"%>
<%@page import="com.sound.entity.Ai_recommendation"%>
<%@page import="com.sound.entity.Users"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.fasterxml.jackson.databind.node.ArrayNode"%>
<%@page import="com.fasterxml.jackson.databind.JsonNode"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&family=Jua&family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
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
	padding: 20px; /* 패딩 추가 */
	margin-bottom: 20px;
	width: 100%; /* 너비를 부모 요소에 맞춤 */
	box-sizing: border-box; /* 패딩과 테두리 크기를 포함하여 너비 조정 */
	font-size: 1.2em; /* 글씨 크기 조정 */
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 약간의 그림자 추가 */
	position: relative; /* 포지션 상대 */
	padding-top: 40px;
}

h4 {
	margin-bottom: 0px;
}

.product-item a {
	text-decoration: none; /* 링크 밑줄 제거 */
	color: #000; /* 링크 색상 */
	display: block; /* 링크 전체를 클릭할 수 있도록 블록으로 설정 */
}

.product-item img {
	max-width: 100%; /* 이미지 크기 조정 */
	height: auto; /* 비율 유지 */
	border-radius: 10px; /* 이미지의 모서리를 둥글게 */
}

.product-item p {
	margin: 0px 0 0; /* 상단 여백 추가, 하단 여백 제거 */
	font-size: 0.8em; /* 텍스트 크기 */
	line-height: 1.5em; /* 줄 간격 설정 */
	opacity: 1; /* 처음에는 투명하게 */
}

.product-item:hover p {
	opacity: 1; /* 투명도 1로 설정 */
	max-height: 500px; /* 충분히 큰 값으로 설정하여 내용이 모두 보이도록 */
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

.product-item.show p {
	opacity: 1;
	max-height: 500px;
}

.fixed-title {
	font-size: 2em;
	font-weight: bold;
	margin-bottom: 10px;
}

#product-detail {
	border: 1px solid #C2BBBB; /* 검은색 테두리 */
}

.zoomable-item {
	transition: transform 0.3s ease; /* 마우스를 올렸을 때 부드러운 줌인 효과 추가 */
}

.zoomable-item:hover {
	transform: scale(1.05); /* 5% 확대 */
}

.product-item .click-message {
	display: none; /* 처음에는 숨김 */
	font-size: 0.7em; /* 작은 글씨 크기 */
	color: #555; /* 연한 색상 */
	margin-top: 5px; /* 이미지와 약간의 여백 추가 */
}

.zoomable-item:hover .click-message {
	display: block; /* 마우스를 올렸을 때만 보이도록 설정 */
}
.footer {
    display: flex;
    justify-content: center;
    margin-top: 20px; /* 필요한 경우 조정하세요 */
    margin-bottom: 10px; /* 페이지 하단과의 여백 */
}

.confirm-btn {
    background-color: #66DAE4;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-weight: bold;
    font-size: 1em;
}

.confirm-btn:hover {
    background-color: #5bc0de;
}

</style>
</head>
<body>

	<div class="container">
		<div class="header">
			<div class="logo">
				<a href="GoMain"> <img src="img/로고.png" alt="로고"></a>
			</div>
			<div class="menu-icon" onclick="toggleDropdown()">
            <div></div>
            <div></div>
            <div></div>
        </div>
        <div class="dropdown-menu" id="dropdownMenu">
            <a href="GoMyPage">마이페이지</a>
            <a href="GoBoard">게시판</a>
             <a href="LogoutController">로그아웃</a>
         </div>
		</div>

		<%
		// 세션에서 userId 가져오기
		String userId = (String) session.getAttribute("userId");

		// 만약 userId가 null이면 예외 처리
		if (userId == null) {
			userId = "Unknown User"; // 기본 값 설정
		}
		%>
		<div class="main-content">
			<h2><%=userId%>님께<br> 추천된 영양제 입니다.
			</h2>
			<p>제품에 마우스를 올려주세요!</p>
			<br> <br>
		</div>

		<!-- 영양제 리스트 -->
		<div class="product-item" data-title="추천된 영양제">
			<%
			List<Products> productsResult = (List<Products>) request.getAttribute("productsResult");
			List<Ai_recommendation> aiResult = (List<Ai_recommendation>) request.getAttribute("aiResult");

			// aiResult에서 첫 번째 영양소 이름만 추출
			String nutrId = aiResult.get(0).getNutrId();
			String[] nutrientArray = nutrId.split(","); // 영양소들을 배열로 분리

			// foodReasons에서 개별 문장만 추출
			String foodReasonsFull = aiResult.get(0).getSuggReason();

			// "식품: " 이후의 부분을 잘라내서 처리
			String[] foodReasonParts = foodReasonsFull.split("영양성분: ")[1].split("\\d+\\. "); // 숫자와 점으로 문장을 나누기

			// 영양소 관련 문장들만 추출
			String firstReason = foodReasonParts.length > 1 ? foodReasonParts[1].trim() : "정보가 없습니다.";
			String secondReason = foodReasonParts.length > 2 ? foodReasonParts[2].trim() : "정보가 없습니다.";
			String thirdReason = foodReasonParts.length > 3 ? foodReasonParts[3].trim() : "정보가 없습니다.";

			if (productsResult != null && aiResult != null && !productsResult.isEmpty() && !aiResult.isEmpty()) {
				for (int i = 0; i < productsResult.size(); i++) {
			%>
			<div class="product-item zoomable-item" id="product-detail">
				<a href="<%=productsResult.get(i).getProductUrl()%>"> <img
					src="<%=productsResult.get(i).getProductImage()%>" alt="영양제 이미지">
					<h4><%=nutrientArray[i].trim()%></h4> <!-- 개별 영양제 이름 -->
				</a>
				<p class="nutrition-reason">
					<%
					if (i == 0) {
					%>
					<%=firstReason%>
					<%
					} else if (i == 1) {
					%>
					<%=secondReason%>
					<%
					} else if (i == 2) {
					%>
					<%=thirdReason%>
					<%
					}
					%>
					<!-- 영양제 설명 -->
				</p>
				<p class="click-message">제품을 클릭해 사이트 이동하기</p>
			</div>
			<%
			}
			%>
			<%
			} else {
			%>
			<div class="product-item" data-title="영양제">
				<p>추천된 영양제가 없습니다.</p>
			</div>
			<%
			}
			%>
		</div>

		<div class="product-item" data-title="추천 식품">
			<%
			if (aiResult != null && !aiResult.isEmpty()) {
				// foodId를 쉼표로 분리하여 그룹별 식품 목록을 추출
				String foodId = aiResult.get(0).getFoodId();
				String[] foodGroups = foodId.split(",\\s*(?=\\d+\\.\\s*)");

				// 각 그룹을 순회하면서 출력
				for (int i = 0; i < foodGroups.length; i++) {
					String[] foodItems = foodGroups[i].split(",\\s*"); // 각 그룹 내의 식품들을 분리
					StringBuilder foodList = new StringBuilder();

					// 그룹 내 식품을 콤마로 연결하여 문자열로 생성
					for (int j = 0; j < foodItems.length; j++) {
				if (j > 0) {
					foodList.append(", ");
				}
				foodList.append(foodItems[j].trim().replaceAll("\\d+\\.\\s*", "")); // 번호 제거
					}
			%>
			<p>
				<strong><%=(i + 1) + ". " + foodList.toString()%></strong>
			</p>
			<%
			}
			} else {
			%>
			<p>추천된 식품이 없습니다.</p>
			<%
			}
			%>
		</div>





		<!-- 상호작용 -->
		<div class="product-item" data-title="상호작용">
			<p><%=aiResult.get(0).getInteraction()%></p>
		</div>
		<div class="footer">
    <button class="confirm-btn" onclick="goToMain()">확인</button>
</div>
		

	</div>

	<script>
		document.addEventListener("DOMContentLoaded", function() {
			var productItems = document.querySelectorAll('.product-item');

			productItems.forEach(function(item) {
				item.addEventListener('mouseover', function() {
					this.classList.add('show'); // 'show' 클래스를 추가하여 고정
				});
			});
		});
		document.querySelector('.menu-icon').addEventListener('click', function() {
		    var dropdownMenu = document.getElementById('dropdownMenu');
		    if (dropdownMenu.style.display === 'block') {
		        dropdownMenu.style.display = 'none';
		    } else {
		        dropdownMenu.style.display = 'block';
		    }
		});
		
		 function goToMain() {
		        window.location.href = "GoMyPage"; // 메인 페이지로 이동
		    }
	

	</script>

</body>
</html>
