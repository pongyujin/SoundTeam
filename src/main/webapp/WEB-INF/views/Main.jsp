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
	position: relative;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 0;
	position: relative;
}

.logo img {
	width: 110px; /* 로고 이미지 크기 조정 */
}

.menu a {
	margin-left : 5px;
	color: #000000; /* 링크 색상 변경 */
	text-decoration: none; /* 밑줄 제거 */
}

a:hover {
	color: #007BFF; /* 마우스를 올렸을 때 색상 변경 */

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

.main-section img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	position: absolute;
	opacity: 0;
	transition: opacity 1s ease-in-out;
}

.main-section img.active {
	opacity: 1;
}

.buttons-section {
	display: flex;
	justify-content: space-between;
	margin-bottom: 40px;
	gap: 20px; /* 버튼 사이의 간격 추가 */
}

.button1, .button2 {
	background-color: #A3ECF2; /* 버튼 배경색 */
	color: #000000; /* 텍스트 색상 */
	padding: 15px;
	border: none;
	border-radius: 8px;
	text-align: center;
	cursor: pointer;
	font-size: 1em;
	flex: 1; /* 버튼이 부모 컨테이너의 너비를 동일하게 차지 */
	height: 100px; /* 버튼의 높이 설정 */
	display: flex;
	justify-content: center;
	align-items: center;
	transition: transform 0.3s ease;
}

.button2 {
	background-color: #66d4e4; /* 다른 버튼의 배경색 */
}

/* 마우스 오버 시 줌인 효과 */
.button1:hover, .button2:hover {
	transform: scale(1.05); /* 버튼을 약간 확대 */
}

.recommendation-section {
	margin-bottom: 20px;
}

.recommendation-title {
	font-size: 1.2em;
	font-weight: bold;
	margin-bottom: 10px;
}

.category-buttons {
	display: flex;
	justify-content: space-around;
	flex-wrap: wrap;
}

.category-button {
	background-color: C3F7FC;
	padding: 10px 15px;
	margin: 5px;
	border-radius: 20px;
	font-size: 0.9em;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	cursor: pointer;
}

.content-section {
	height: 200px;
	background-color: #CFF4F8; /* 임시 배경 색 */
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	padding: 10px;
	overflow: hidden;
	border-radius: 20px;
	opacity: 0; /* 처음에는 투명하게 설정 */
	max-height: 0; /* 처음에는 높이를 0으로 설정 */
	transition: opacity 0.5s ease, max-height 0.5s ease; /* 부드러운 전환 효과 */
}

.content-section.show {
	opacity: 1;
	max-height: 500px; /* 충분히 큰 값을 설정하여 모든 내용이 보이도록 함 */
}

.vitamin-list-container {
	transition: opacity 0.5s ease; /* 텍스트 전환을 위한 트랜지션 */
	opacity: 1;
}

.vitamin-list-container.hidden {
	opacity: 0;
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

			<%
			// 세션값 가져오기
			Users user = (Users) session.getAttribute("user");
			%>

			<%
			if (user == null) {
			%>
			<div class="menu">
				<a href="Gologin">로그인</a> 
				<a href="GoJoinPage">회원가입</a>
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
				<a href="GoMyPage1">마이페이지</a> <a href="GoBoard">게시판</a>
			</div>
			<%
			}
			%>
		</div>

		<div class="main-section">
			<!-- 슬라이드쇼 이미지 -->
			<img src="img/영양제main3.jpg" alt="영양제 이미지1" class="slide active">
			<img src="img/영양제main2.jpg" alt="영양제 이미지2" class="slide"> <img
				src="img/영양제main4.jpg" alt="영양제 이미지3" class="slide">
		</div>

		<div class="buttons-section">
			<!-- 버튼 1 -->
			<button class="button1" onclick="location.href='GoStartSurvetPage'">
				설문 조사 후<br> 영양제 추천
			</button>
			<!-- 버튼 2 -->
			<button class="button2" onclick="location.href='GoSearchPage'">
				영양제 검색 후<br>직접 선택
			</button>
		</div>

		<div class="recommendation-section">
			<div class="recommendation-title">건강 고민별 추천 영양제</div>
			<div class="category-buttons">
				<div class="category-button" onclick="showVitaminList('stress')">스트레스</div>
				<div class="category-button" onclick="showVitaminList('skin')">피부</div>
				<div class="category-button" onclick="showVitaminList('diet')">다이어트</div>
				<div class="category-button" onclick="showVitaminList('eye')">눈건강</div>
				<div class="category-button" onclick="showVitaminList('gut')">장건강</div>
				<div class="category-button" onclick="showVitaminList('joint')">관절</div>
				<div class="category-button" onclick="showVitaminList('fatigue')">피로</div>
				<div class="category-button" onclick="showVitaminList('liver')">간건강</div>
				<div class="category-button" onclick="showVitaminList('stomach')">위건강</div>
				<div class="category-button" onclick="showVitaminList('women')">여성건강</div>
				<div class="category-button" onclick="showVitaminList('men')">남성건강</div>
			</div>
		</div>

		<div id="content-section" class="content-section">
			<div id="vitamin-list-container" class="vitamin-list-container"></div>
		</div>
	</div>

	<script>
    const slides = document.querySelectorAll('.main-section .slide');
    let currentSlide = 0;

    function showNextSlide() {
      slides[currentSlide].classList.remove('active');
      currentSlide = (currentSlide + 1) % slides.length;
      slides[currentSlide].classList.add('active');
    }

    setInterval(showNextSlide, 3000); // 3초마다 이미지 전환

 	// 전역 변수로 선언
    let isFirstClick = true;  // 처음 클릭 여부를 확인하기 위한 변수

    // 건강 고민별 추천 영양제 
    function showVitaminList(category) {
      const vitaminListContainer = document.getElementById('vitamin-list-container');
      const contentSection = document.getElementById('content-section');
      let vitamins = [];

      switch (category) {
        case 'stress':
          vitamins = [
            '비타민 B 컴플렉스 - 스트레스 완화에 도움.',
            '마그네슘 - 신경계 안정 및 스트레스 감소에 도움.',
            'L-테아닌 - 긴장 완화 및 스트레스 감소.'
          ];
          break;
        case 'skin':
          vitamins = [
            '비타민 C - 피부 건강을 촉진.',
            '비오틴 - 피부, 머리카락, 손톱 건강에 도움.',
            '콜라겐 - 피부 탄력 유지에 기여.'
          ];
          break;
        case 'diet':
          vitamins = [
            '가르시니아 - 체중 관리에 도움.',
            'CLA - 지방 대사 촉진.',
            '녹차 추출물 - 체지방 감소에 기여.'
          ];
          break;
        case 'eye':
          vitamins = [
            '루테인 - 눈 건강 유지에 도움.',
            '비타민 A - 시력 유지에 중요.',
            '오메가-3 - 눈의 건조함을 줄이는 데 도움.'
          ];
          break;
        case 'gut':
          vitamins = [
            '프로바이오틱스 - 장 건강 증진.',
            '식이섬유 - 소화기 건강 유지.',
            '글루타민 - 장벽 보호에 도움.'
          ];
          break;
        case 'joint':
          vitamins = [
            '글루코사민 - 관절 건강에 도움.',
            'MSM - 관절 및 연골 보호.',
            '칼슘 - 뼈와 관절 건강에 기여.'
          ];
          break;
        case 'fatigue':
          vitamins = [
            '비타민 B12 - 피로 회복에 도움.',
            '철분 - 피로 개선에 도움.',
            '코엔자임 Q10 - 에너지 생성 촉진.'
          ];
          break;
        case 'liver':
          vitamins = [
            '밀크씨슬 - 간 보호 및 해독.',
            '글루타치온 - 간 해독 촉진.',
            '알파 리포산 - 간 건강 증진.'
          ];
          break;
        case 'stomach':
          vitamins = [
            '프리바이오틱스 - 장내 유익균 증식에 도움.',
            '알로에 베라 - 위장 보호에 도움.',
            '징계초 - 소화기 건강에 기여.'
          ];
          break;
        case 'women':
          vitamins = [
            '철분 - 여성의 건강을 위한 필수 요소.',
            '칼슘 - 뼈 건강 유지에 도움.',
            '엽산 - 임산부 및 여성 건강에 중요.'
          ];
          break;
        case 'men':
          vitamins = [
            '아연 - 남성 건강에 중요.',
            '마카 - 남성의 활력 증진.',
            '비타민 D - 전반적인 남성 건강에 기여.'
          ];
          break;
        default:
          vitamins = ['추천 영양제를 선택해 주세요.'];
      }

      // 비타민 목록을 동적으로 생성
      let vitaminListHtml = '<ul class="vitamin-list">';
      vitamins.forEach(vitamin => {
          vitaminListHtml += `<li>${vitamin}</li>`;
      });
      vitaminListHtml += '</ul>';

  	 // 첫 클릭 시: 박스가 부드럽게 나타남
      if (isFirstClick) {
          contentSection.classList.add('show');  // 박스를 부드럽게 나타냄
          isFirstClick = false; // 첫 클릭 이후로는 박스가 계속 보여지도록 설정
      }

      // 텍스트 페이드 아웃 후 텍스트 변경, 페이드 인
      vitaminListContainer.classList.add('hidden');  // 텍스트를 부드럽게 숨김
      setTimeout(() => {
          vitaminListContainer.innerHTML = vitaminListHtml;  // 텍스트 변경
          vitaminListContainer.classList.remove('hidden');  // 텍스트를 다시 보이게 함
      }, 300);  // 0.5초 후에 텍스트가 바뀜
    }

    function toggleDropdown() {
      const dropdownMenu = document.getElementById('dropdownMenu');
      const isDisplayed = window.getComputedStyle(dropdownMenu).display === 'block';
      dropdownMenu.style.display = isDisplayed ? 'none' : 'block';
    }

 	// 클릭 외부에서 닫기
    document.addEventListener('click', function(event) {
        const target = event.target;
        const dropdownMenu = document.getElementById('dropdownMenu');
        const menuIcon = document.querySelector('.menu-icon');

        // dropdownMenu와 menuIcon이 존재하는지 확인
        if (dropdownMenu && menuIcon) {
            if (!menuIcon.contains(target) && !dropdownMenu.contains(target)) {
                dropdownMenu.style.display = 'none';
            }
        }
    });

  </script>
</body>
</html>
