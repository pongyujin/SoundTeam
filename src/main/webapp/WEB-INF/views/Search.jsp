<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.sound.entity.Users"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영양제 검색 페이지</title>
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

.dropdown-menu {
	display: none; /* 기본적으로 숨김 */
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
	height: 200px;
	background-color: #e0e0e0; /* 임시 배경 색 */
	display: flex;
	justify-content: center;
	align-items: center;
	position: relative;
	overflow: hidden;
}

.content {
	margin-top: 20px;
	width: 100%;
	padding: 1em 0;
	box-sizing: border-box;
	text-align: center;
	flex-grow: 1;
	font-size: 10px;
}

.search-bar {
	margin-bottom: 20px;
    height: 11px;
    width: 400px;
	
	
	height: 11px;
	width: 400px;
}

.search-bar input {
	width: 100%;
	padding: 10px;
	font-size: 1em;
	border: 1px solid #ddd;
	border-radius: 8px;
}

.category-slider-container {
	overflow-x: auto;
	white-space: nowrap;
	padding: 10px 0;
	margin-bottom: 20px;
	text-align: center;
}

.category-slider-container::-webkit-scrollbar {
	height: 8px;
}

.category-slider-container::-webkit-scrollbar-thumb {
	background-color: #ccc;
	border-radius: 10px;
}

.category-slider-container::-webkit-scrollbar-track {
	background-color: #f4f4f4;
}

.category-slider-wrapper {
	display: inline-block;
	overflow-x: auto;
	max-width: 320px;
	margin: 0 auto;
	text-align: center;
}

.category-slider {
	display: inline-flex;
	padding-bottom: 10px;
}

.category-item {
	display: inline-block;
	margin-right: 10px;
	text-align: center;
	cursor: pointer;
	width: 70px;
	box-sizing: border-box;
}

.category-item img {
	width: 70px;
	height: 70px;
	object-fit: cover;
	border-radius: 50%;
}

.category-item span {
	display: block;
	margin-top: 5px;
	font-size: 0.8em;
	color: #333;
	white-space: nowrap;
}

.slider-container {
	width: 100%;
	overflow: hidden;
	position: relative;
	flex-grow: 1;
}

.slider {
	display: flex;
	transition: transform 0.5s ease;
}

.vitamin-list {
	min-width: 100%;
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 10px;
	padding: 10px;
	box-sizing: border-box;
}

.vitamin-item {
	position: relative;
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	text-align: left;
	cursor: pointer;
	display: flex;
	align-items: center;
	padding: 10px;
	overflow: hidden;
	height: 80px;
}

.vitamin-item img {
	width: 50px;
	height: 50px;
	object-fit: cover;
	border-radius: 8px;
	display: block;
	margin-right: 10px;
}

.vitamin-item span {
	font-size: 0.9em;
	color: #333;
	position: absolute;
	bottom: 10px;
	left: 10px;
	white-space: nowrap;
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
				<a href="mypage.jsp">마이페이지</a> <a href="GoBoard">게시판</a>
			</div>
			<%
			}
			%>
		</div>

		<div class="content">
			<h1>어떤 영양제를 찾으세요?</h1>
			
			<div class="search-bar">
				<input type="text" id="searchInput" placeholder="제품명, 영양성분, 건강 고민을 검색해보세요!">
				<button onclick="redirectToSearchResult()">검색</button>
			</div>

			<div class="category-slider-container">
				<div class="category-slider-wrapper">
					<div class="category-slider">
						<div class="category-item" onclick="navigateToCategory('all')">
							<img src="img/images.png" alt="전체"> <span>전체</span>
						</div>
						<div class="category-item" onclick="navigateToCategory('immune')">
							<img src="img/면역력.jpg" alt="면역"> <span>면역</span>
						</div>
						<div class="category-item" onclick="navigateToCategory('diet')">
							<img src="img/다이어트.jpg" alt="다이어트"> <span>다이어트</span>
						</div>
						<div class="category-item" onclick="navigateToCategory('stress')">
							<img src="img/스트레스.jpg" alt="스트레스"> <span>스트레스</span>
						</div>
						<div class="category-item"
							onclick="navigateToCategory('digestive')">
							<img src="img/위.jpg" alt="위건강"> <span>위건강</span>
						</div>
						<div class="category-item"
							onclick="navigateToCategory('digestive')">
							<img src="img/피로함.png" alt="피로"> <span>피로</span>
						</div>
						<div class="category-item"
							onclick="navigateToCategory('digestive')">
							<img src="img/눈건강.jpg" alt="눈건강"> <span>눈건강</span>
						</div>
						<div class="category-item"
							onclick="navigateToCategory('digestive')">
							<img src="img/간건강.jpg" alt="간건강"> <span>간건강</span>
						</div>
						<div class="category-item"
							onclick="navigateToCategory('digestive')">
							<img src="img/관절.jpg" alt="관절"> <span>관절</span>
						</div>
						<div class="category-item"
							onclick="navigateToCategory('digestive')">
							<img src="img/여성건강.jpg" alt="여성건강"> <span>여성건강</span>
						</div>
						<div class="category-item"
							onclick="navigateToCategory('digestive')">
							<img src="img/남성건강.jpg" alt="남성건강"> <span>남성건강</span>
						</div>
						<!-- 추가 카테고리는 여기에 계속 추가 -->
					</div>
				</div>
			<div class="search-bar">
				<input type="text" id="searchInput"
					placeholder="제품명, 영양성분, 건강 고민을 검색해보세요!">
				<button onclick="redirectToSearchResult()">검색</button>
			</div>


			<div class="category-slider-container">
				<div class="category-slider-wrapper">
					<div class="category-slider">
						<div class="category-item" onclick="navigateToCategory('all')">
							<img src="img/images.png" alt="전체"> <span>전체</span>
						</div>
						<div class="category-item" onclick="navigateToCategory('immune')">
							<img src="img/면역력.jpg" alt="면역"> <span>면역</span>
						</div>
						<div class="category-item" onclick="navigateToCategory('diet')">
							<img src="img/다이어트.jpg" alt="다이어트"> <span>다이어트</span>
						</div>
						<div class="category-item" onclick="navigateToCategory('stress')">
							<img src="img/스트레스.jpg" alt="스트레스"> <span>스트레스</span>
						</div>
						<div class="category-item"
							onclick="navigateToCategory('digestive')">
							<img src="img/위.jpg" alt="위건강"> <span>위건강</span>
						</div>
						<div class="category-item"
							onclick="navigateToCategory('digestive')">
							<img src="img/피로함.png" alt="피로"> <span>피로</span>
						</div>
						<div class="category-item"
							onclick="navigateToCategory('digestive')">
							<img src="img/눈건강.jpg" alt="눈건강"> <span>눈건강</span>
						</div>
						<div class="category-item"
							onclick="navigateToCategory('digestive')">
							<img src="img/간건강.jpg" alt="간건강"> <span>간건강</span>
						</div>
						<div class="category-item"
							onclick="navigateToCategory('digestive')">
							<img src="img/관절.jpg" alt="관절"> <span>관절</span>
						</div>
						<div class="category-item"
							onclick="navigateToCategory('digestive')">
							<img src="img/여성건강.jpg" alt="여성건강"> <span>여성건강</span>
						</div>
						<div class="category-item"
							onclick="navigateToCategory('digestive')">
							<img src="img/남성건강.jpg" alt="남성건강"> <span>남성건강</span>
						</div>
						<!-- 추가 카테고리는 여기에 계속 추가 -->
					</div>
				</div>
			</div>

			<div class="slider-container">
				<div class="slider" id="slider">
					<!-- 비타민 목록 1 -->
					<div class="vitamin-list">
						<div class="vitamin-item"
							onclick="redirectToSearchResult('비타민C')">
							<img src="img/비타민C.jpg" alt="비타민 C"> <span>비타민 C</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('마그네슘')">
							<img src="img/마그네슘.jpg" alt="마그네슘"> <span>마그네슘</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('밀크씨슬')">
							<img src="img/밀크씨슬.jpg" alt="밀크씨슬"> <span>밀크씨슬</span>
						</div>
						<div class="vitamin-item"
							onclick="redirectToSearchResult('비타민A')">
							<img src="img/비타민A.jpg" alt="비타민 A"> <span>비타민 A</span>
						</div>
						<div class="vitamin-item"
							onclick="redirectToSearchResult('멀티비타민&미네랄')">
							<img src="img/멀티비타민&미네랄.jpg" alt="멀티비타민&미네랄"> <span>멀티비타민&미네랄</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('아연')">
							<img src="img/아연.jpg" alt="아연"> <span>아연</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('루테인')">
							<img src="img/루테인.jpg" alt="루테인"> <span>루테인</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('테아닌')">
							<img src="img/테아닌.jpg" alt="테아닌"> <span>테아닌</span>
						</div>
					</div>

					<!-- 비타민 목록 2 -->
					<div class="vitamin-list">
						<div class="vitamin-item" onclick="redirectToSearchResult('오메가3')">
							<img src="img/오메가3.jpg" alt="오메가3"> <span>오메가3</span>
						</div>
						<div class="vitamin-item"
							onclick="redirectToSearchResult('비타민D')">
							<img src="img/비타민D.jpg" alt="비타민 D"> <span>비타민 D</span>
						</div>
						<div class="vitamin-item"
							onclick="redirectToSearchResult('코엔자임Q10')">
							<img src="img/코엔자임Q10.jpg" alt="코엔자임Q10"> <span>코엔자임Q10</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('유산균')">
							<img src="img/유산균.jpg" alt="유산균"> <span>유산균</span>
						</div>
						<div class="vitamin-item"
							onclick="redirectToSearchResult('비타민E')">
							<img src="img/비타민E.jpg" alt="비타민 E"> <span>비타민 E</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('칼슘')">
							<img src="img/칼슘.jpg" alt="칼슘"> <span>칼슘</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('철분')">
							<img src="img/철분.jpg" alt="철분"> <span>철분</span>
						</div>
						<div class="vitamin-item"
							onclick="redirectToSearchResult('비타민B')">
							<img src="img/비타민B.jpg" alt="비타민 B"> <span>비타민 B</span>
			<div class="slider-container">
				<div class="slider" id="slider">
					<!-- 비타민 목록 1 -->
					<div class="vitamin-list">
						<div class="vitamin-item" onclick="redirectToSearchResult('비타민C')">
							<img src="img/비타민C.jpg" alt="비타민 C"> <span>비타민 C</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('마그네슘')">
							<img src="img/마그네슘.jpg" alt="마그네슘"> <span>마그네슘</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('밀크씨슬')">
							<img src="img/밀크씨슬.jpg" alt="밀크씨슬"> <span>밀크씨슬</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('비타민A')">
							<img src="img/비타민A.jpg" alt="비타민 A"> <span>비타민 A</span>
						</div>
						<div class="vitamin-item"
							onclick="redirectToSearchResult('멀티비타민&미네랄')">
							<img src="img/멀티비타민&미네랄.jpg" alt="멀티비타민&미네랄"> <span>멀티비타민&미네랄</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('아연')">
							<img src="img/아연.jpg" alt="아연"> <span>아연</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('루테인')">
							<img src="img/루테인.jpg" alt="루테인"> <span>루테인</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('테아닌')">
							<img src="img/테아닌.jpg" alt="테아닌"> <span>테아닌</span>
						</div>
					</div>

					<!-- 비타민 목록 3 -->
					<div class="vitamin-list">
						<div class="vitamin-item" onclick="redirectToSearchResult('비오틴')">
							<img src="img/비오틴.jpg" alt="비오틴"> <span>비오틴</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('엽산')">
							<img src="img/엽산.jpg" alt="엽산"> <span>엽산</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('셀레늄')">
							<img src="img/셀레늄.jpg" alt="셀레늄"> <span>셀레늄</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('콜라겐')">
							<img src="img/콜라겐.jpg" alt="콜라겐"> <span>콜라겐</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('인삼')">
							<img src="img/인삼.jpeg" alt="인삼"> <span>인삼</span>
						</div>
						<div class="vitamin-item"
							onclick="redirectToSearchResult('비타민K')">
							<img src="img/비타민K.jpg" alt="비타민 K"> <span>비타민 K</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('커큐민')">
							<img src="img/커큐민.jpg" alt="커큐민"> <span>커큐민</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('멜라토닌')">
							<img src="img/멜라토닌.jpg" alt="멜라토닌"> <span>멜라토닌</span>
						</div>
					</div>
				</div>
			</div>
					<!-- 비타민 목록 2 -->
					<div class="vitamin-list">
						<div class="vitamin-item" onclick="redirectToSearchResult('오메가3')">
							<img src="img/오메가3.jpg" alt="오메가3"> <span>오메가3</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('비타민D')">
							<img src="img/비타민D.jpg" alt="비타민 D"> <span>비타민 D</span>
						</div>
						<div class="vitamin-item"
							onclick="redirectToSearchResult('코엔자임Q10')">
							<img src="img/코엔자임Q10.jpg" alt="코엔자임Q10"> <span>코엔자임Q10</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('유산균')">
							<img src="img/유산균.jpg" alt="유산균"> <span>유산균</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('비타민E')">
							<img src="img/비타민E.jpg" alt="비타민 E"> <span>비타민 E</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('칼슘')">
							<img src="img/칼슘.jpg" alt="칼슘"> <span>칼슘</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('철분')">
							<img src="img/철분.jpg" alt="철분"> <span>철분</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('비타민B')">
							<img src="img/비타민B.jpg" alt="비타민 B"> <span>비타민 B</span>
						</div>
					</div>
		<!-- 비타민 목록 3 -->
					<div class="vitamin-list">
						<div class="vitamin-item" onclick="redirectToSearchResult('비오틴')">
							<img src="img/비오틴.jpg" alt="비오틴"> <span>비오틴</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('엽산')">
							<img src="img/엽산.jpg" alt="엽산"> <span>엽산</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('셀레늄')">
							<img src="img/셀레늄.jpg" alt="셀레늄"> <span>셀레늄</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('콜라겐')">
							<img src="img/콜라겐.jpg" alt="콜라겐"> <span>콜라겐</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('인삼')">
							<img src="img/인삼.jpeg" alt="인삼"> <span>인삼</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('비타민K')">
							<img src="img/비타민K.jpg" alt="비타민 K"> <span>비타민 K</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('커큐민')">
							<img src="img/커큐민.jpg" alt="커큐민"> <span>커큐민</span>
						</div>
						<div class="vitamin-item" onclick="redirectToSearchResult('멜라토닌')">
							<img src="img/멜라토닌.jpg" alt="멜라토닌"> <span>멜라토닌</span>
						</div>
					</div>
				</div>
			</div>

			<!-- 페이지네이션 -->
			<div class="pagination">
				<button onclick="showPage(1)" class="active">1</button>
				<button onclick="showPage(2)">2</button>
				<button onclick="showPage(3)">3</button>
			</div>
		</div>
	</div>

	<script>
        function showPage(pageNumber) {
            const slider = document.getElementById('slider');
            slider.style.transform = `translateX(-${(pageNumber - 1) * 100}%)`;

            // 페이지네이션 버튼 활성화
            const paginationButtons = document.querySelectorAll('.pagination button');
            paginationButtons.forEach(button => {
                button.classList.remove('active');
            });
            paginationButtons[pageNumber - 1].classList.add('active');
        }
        
        function redirectToSearchResult(vitaminName) {
            // URL 인코딩을 해서 안전하게 전달합니다.
            const encodedVitaminName = encodeURIComponent(vitaminName);
            window.location.href = `GoSearchResultPage?vitamin=${encodedVitaminName}`;
        }
        
        function redirectToSearchResult() {
        	
            var vitaminName = document.getElementById('searchInput').value;
            if (vitaminName) {
            	
                var encodedVitaminName = encodeURIComponent(vitaminName);
                window.location.href = `GoSearchResultPage?vitamin=${encodedVitaminName}`;
            } else {
                alert("검색어를 입력하세요.");
            }
        }

        
    </script>
</body>
</html>

