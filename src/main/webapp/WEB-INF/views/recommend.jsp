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
	padding: 20px; /* 패딩 추가 */
	margin-bottom: 20px;
	width: 100%; /* 너비를 부모 요소에 맞춤 */
	box-sizing: border-box; /* 패딩과 테두리 크기를 포함하여 너비 조정 */
	font-size: 1.2em; /* 글씨 크기 조정 */
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 약간의 그림자 추가 */
	position: relative; /* 포지션 상대 */
	padding-top: 40px;
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
	margin: 10px 0 0; /* 상단 여백 추가, 하단 여백 제거 */
	font-size: 0.8em; /* 텍스트 크기 */
	line-height: 1.5em; /* 줄 간격 설정 */
	opacity: 0; /* 처음에는 투명하게 */
	max-height: 0; /* 높이를 0으로 설정하여 숨김 효과 */
	overflow: hidden; /* 높이가 줄어들면서 내용이 숨겨지도록 설정 */
	transition: opacity 2s ease, max-height 2s ease; /* 부드러운 전환 효과 */
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

		<%
		// 네이버 api 결과
		List<String> links = (List<String>) session.getAttribute("links");
		List<String> images = (List<String>) session.getAttribute("images");
		List<String> items = (List<String>) session.getAttribute("items");

		// ai결과 
		String suggReason = (String) session.getAttribute("sugg_reason");
		String interActions = (String) session.getAttribute("inter_actions");

		// 세션에서 food 데이터 가져오기
		List<String> foodList = (List<String>) session.getAttribute("food");
		%>

		<div class="main-content">
			<h2><%=session.getAttribute("user_id")%>님께<br> 추천된 영양제 입니다.
			</h2>
			<p>제품을 눌러 영양정보 확인하기</p>
			<br> <br>

			<!-- 영양제 리스트 -->
			<div class="product-item" data-title="추천된 영양제">
				<%
				// 네이버 API 결과 가져오기
				if (links != null && !links.isEmpty() && images != null && !images.isEmpty() && items != null && !items.isEmpty()) {
					for (int i = 0; i < links.size(); i++) {
				%>
				<div class="product-item zoomable-item" id="product-detail">
					<a href="<%=links.get(i)%>"> <img src="<%=images.get(i)%>"
						alt="영양제 이미지">
						<h4><%=items.get(i)%></h4>
					</a>
					<p class="click-message">제품을 클릭해 사이트 이동하기</p>

				</div>
				<%
				}
				} else {
				%>
				<div class="product-item" data-title="영양제">
					<p>추천된 영양제가 없습니다.</p>
				</div>
				<%
				}
				%>
			</div>

			<!-- 추천 이유 -->
			<div class="product-item" data-title="추천 이유">
				<p><%=suggReason%><br>
				</p>
			</div>
			<!-- 상호작용 -->
			<div class="product-item" data-title="상호작용">
				<p>
					<%=interActions != null ? interActions : "상호작용 정보가 없습니다."%>
				</p>
			</div>

			<!-- 추천 식품 -->
			<div class="product-item" data-title="추천 식품">

				<%
				if (foodList != null && !foodList.isEmpty()) {
					for (String foodItem : foodList) {
				%>
				<p><%=foodItem%></p>
				<%
				}
				} else {
				%>
				<p>추천된 식품이 없습니다.</p>
				<%
				}
				%>
			</div>

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
	</script>
</body>
</html>
