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
    font-size: 16px; }
    /* 전체 글씨 크기를 기본적으로 크게 설정 */

.container {
    background-color: #ffffff;
    width: 430px;
    max-width: 800px;
    padding: 10px 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    font-size: 1.1em; /* 컨테이너 내부의 글씨 크기 확대 */
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
    position: relative; /* 드롭다운 메뉴가 이 요소를 기준으로 위치하도록 설정 */
}

.logo img {
   width: 130px; /* 로고 이미지 크기 조정 */
   margin-top:10px;
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
    position: relative; /* 부모 요소의 위치를 기준으로 드롭다운 위치를 설정 */

}

.menu-icon div {
	width: 100%;
	height: 4px;
	background-color: #000;
}

.dropdown-menu {
    display: none;
    position: absolute;
    top: 40%; /* top 값을 100%로 조정하여 버튼 바로 아래에 나오도록 설정 */
    right: 0;
    background-color: #ffffff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 5px;
    overflow: hidden;
    z-index: 1000;
    margin-top: 0; /* margin-top 값을 제거하거나 0으로 설정 */
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

.h1{
font-size: 25px;
}

.search-bar {
   display: flex;
   align-items: center;
   justify-content: center;
   margin-bottom: 20px;
}

.search-bar input {
   width: 70%; /* 입력 ㅌ필드의 너비를 적절히 설정 */
   padding: 10px;
   font-size: 1.3em;
   border: 1px solid #ddd;
   border-radius: 8px; /* 전체적으로 둥글게 설정 */
   box-sizing: border-box;
   height: 40px; /* 버튼과 동일한 높이로 설정 */
   margin-right: 10px; /* 검색 버튼과의 간격 추가 */
}


.button {
   padding: 10px 20px;
   background-color: #66DAE4;
   border: none;
   border-radius: 8px; /* 둥글게 설정 */
   cursor: pointer;
   color: #fff;
   font-weight: bold;
   margin: 0; /* 버튼의 외부 여백을 없앰 */
   height: 40px; /* 입력 필드와 동일한 높이로 설정 */
   box-sizing: border-box;
   line-height: normal; /* 버튼의 텍스트 정렬을 중앙으로 설정 */
}

.category-slider-container {
    overflow-x: auto;
    white-space: nowrap;
    padding: 10px 50px; /* 양옆에 20px 패딩 추가 */
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
   margin: 0 20px; /* 슬라이더 내부의 양옆에 20px 마진 추가 */
}

.category-item {
   display: inline-block;
   margin-right: 10px;
   text-align: center;
   cursor: pointer;
   width: 50px; /* 이미지 크기를 줄임 */
   box-sizing: border-box;
}

.category-item img {
    width: 60px; /* 이미지 크기를 확대 */
    height: 60px; /* 이미지 크기를 확대 */
    object-fit: cover;
    border-radius: 50%;
}

.category-item span {
    display: block;
    margin-top: 10px; /* 이미지와 텍스트 사이의 간격을 확대 */
    font-size: 1em; /* 텍스트 크기 */
    color: #333;
    white-space: nowrap;
    text-align: center; /* 텍스트를 중앙 정렬 */
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

/* 이미지가 들어가는 부모 요소에 대해 설정 */
.vitamin-item {
    position: relative;
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    text-align: center; /* 텍스트를 가운데 정렬 */
    cursor: pointer;
    display: flex; /* Flexbox 사용 */
    justify-content: center; /* 수평 중앙 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    padding: 10px;
    overflow: hidden;
    height: 70px; /* 이미지 크기를 줄임 */
}

.vitamin-item img {
    width: 50px; /* 이미지 크기를 조정 */
    height: 50px; /* 이미지 크기를 조정 */
    object-fit: cover;
    border-radius: 8px;
    display: block;           
}

.vitamin-item span {
    font-size: 1.2em; /* 비타민 항목 텍스트 크기 확대 */
    color: #333;
    position: absolute;
    bottom: 10px;
    left: 10px;
    white-space: nowrap;
    
    
    .vitamin-item {
    position: relative; 
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    text-align: center;
    cursor: pointer;
    display: flex;
    justify-content: center; /* 수평 중앙 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    padding: 10px;
    overflow: hidden;
    height: 120px; /* 요소의 높이를 조금 늘려 텍스트와 이미지를 잘 배치 */
}

.vitamin-item img {
    width: 80px;
    height: 80px;
    object-fit: cover;
    border-radius: 8px;
    display: block;
    margin-bottom: 5px; /* 이미지와 텍스트 사이에 약간의 여백 추가 */
}
 
.vitamin-item span {
    font-size: 0.9em; /* 텍스트 크기를 조금 키움 */
    color: #333;
    position: absolute; /* 절대 위치를 사용 */
    bottom: 10px; /* 부모 컨테이너의 아래쪽에 위치 */
    left: 200px; /* 수평 중앙 정렬 */
    transform: translateX(-50%); /* 텍스트의 중심을 정확히 맞춤 */
}
    
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
   border-radius: 4px;
   cursor: pointer;
   background-color: #B0E9EE;
}


.button, .pagination button {
   pointer-events: auto; /* 이 속성이 설정되어야 클릭이 가능 */
}

.pagination button.active {
    background-color: #66DAE4;
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
            <a href="GoMypage">마이페이지</a>
            <a href="GoBoard">게시판</a>
             <a hred="LogoutController">로그아웃</a>
         </div>
         <%
         }
         %>
      </div>

      <div class="content">
         <h1 class ="h1">어떤 영양제를 찾으세요?</h1>

         <div class="search-bar">
            <input type="text" id="searchInput"
               placeholder="제품명, 영양성분, 건강 고민을 검색해보세요!">
            <button class="button" onclick="redirectToSearchResult()">검색</button>
         </div>

         <div class="category-slider-container">
    <div class="category-slider-wrapper">
        <div class="category-slider">
            
            <div class="category-item" onclick="redirectToShoppingApi('면역')">
                <img src="img/면역력.jpg" alt="면역"> <span>면역</span>
            </div>
            <div class="category-item" onclick="redirectToShoppingApi('다이어트')">
                <img src="img/다이어트.jpg" alt="다이어트"> <span>다이어트</span>
            </div>
            <div class="category-item" onclick="redirectToShoppingApi('스트레스')">
                <img src="img/스트레스.jpg" alt="스트레스"> <span>스트레스</span>
            </div>
            <div class="category-item" onclick="redirectToShoppingApi('위건강')">
                <img src="img/위.jpg" alt="위건강"> <span>위건강</span>
            </div>
            <div class="category-item" onclick="redirectToShoppingApi('피로')">
                <img src="img/피로함.png" alt="피로"> <span>피로</span>
            </div>
            <div class="category-item" onclick="redirectToShoppingApi('눈건강')">
                <img src="img/눈건강.jpg" alt="눈건강"> <span>눈건강</span>
            </div>
            <div class="category-item" onclick="redirectToShoppingApi('간건강')">
                <img src="img/간건강.jpg" alt="간건강"> <span>간건강</span>
            </div>
            <div class="category-item" onclick="redirectToShoppingApi('관절')">
                <img src="img/관절.jpg" alt="관절"> <span>관절</span>
            </div>
            <div class="category-item" onclick="redirectToShoppingApi('여성건강')">
                <img src="img/여성건강.jpg" alt="여성건강"> <span>여성건강</span>
            </div>
            <div class="category-item" onclick="redirectToShoppingApi('남성건강')">
                <img src="img/남성건강.jpg" alt="남성건강"> <span>남성건강</span>
            </div>
        </div>
    </div>
</div>


            <div class="slider-container">
               <div class="slider" id="slider">
                  <!-- 비타민 목록 1 -->
                  <div class="vitamin-list">
                     <div class="vitamin-item"
                        onclick="redirectToShoppingApi('비타민C')">
                        <img src="img/비타민C.jpg" alt="비타민 C"> <span>비타민 C</span>
                     </div>
                     <div class="vitamin-item"
                        onclick="redirectToShoppingApi('마그네슘')">
                        <img src="img/마그네슘.jpg" alt="마그네슘"> <span>마그네슘</span>
                     </div>
                     <div class="vitamin-item"
                        onclick="redirectToShoppingApi('밀크씨슬')">
                        <img src="img/밀크씨슬.jpg" alt="밀크씨슬"> <span>밀크씨슬</span>
                     </div>
                     <div class="vitamin-item"
                        onclick="redirectToShoppingApi('비타민A')">
                        <img src="img/비타민A.jpg" alt="비타민 A"> <span>비타민 A</span>
                     </div>
                     <div class="vitamin-item"
                        onclick="redirectToShoppingApi('멀티비타민&미네랄')">
                        <img src="img/멀티비타민&미네랄.jpg" alt="멀티비타민&미네랄"> <span>멀티비타민&미네랄</span>
                     </div>
                     <div class="vitamin-item" onclick="redirectToShoppingApi('아연')">
                        <img src="img/아연.jpg" alt="아연"> <span>아연</span>
                     </div>
                     <div class="vitamin-item" onclick="redirectToShoppingApi('루테인')">
                        <img src="img/루테인.jpg" alt="루테인"> <span>루테인</span>
                     </div>
                     <div class="vitamin-item" onclick="redirectToShoppingApi('테아닌')">
                        <img src="img/테아닌.jpg" alt="테아닌"> <span>테아닌</span>
                     </div>
                  </div>

                  <!-- 비타민 목록 2 -->
                  <div class="vitamin-list">
                     <div class="vitamin-item"
                        onclick="redirectToShoppingApi('오메가3')">
                        <img src="img/오메가3.jpg" alt="오메가3"> <span>오메가3</span>
                     </div>
                     <div class="vitamin-item"
                        onclick="redirectToShoppingApi('비타민D')">
                        <img src="img/비타민 D.jpg" alt="비타민 D"> <span>비타민 D</span>
                     </div>
                     <div class="vitamin-item"
                        onclick="redirectToShoppingApi('코엔자임Q10')">
                        <img src="img/코엔자임Q10.jpg" alt="코엔자임Q10"> <span>코엔자임Q10</span>
                     </div>
                     <div class="vitamin-item" onclick="redirectToShoppingApi('유산균')">
                        <img src="img/유산균.jpg" alt="유산균"> <span>유산균</span>
                     </div>
                     <div class="vitamin-item"
                        onclick="redirectToShoppingApi('비타민E')">
                        <img src="img/비타민 E.jpg" alt="비타민 E"> <span>비타민 E</span>
                     </div>
                     <div class="vitamin-item" onclick="redirectToShoppingApi('칼슘')">
                        <img src="img/칼슘.jpg" alt="칼슘"> <span>칼슘</span>
                     </div>
                     <div class="vitamin-item" onclick="redirectToShoppingApi('철분')">
                        <img src="img/철분.jpg" alt="철분"> <span>철분</span>
                     </div>
                     <div class="vitamin-item"
                        onclick="redirectToShoppingApi('비타민B')">
                        <img src="img/비타민 B.jpg" alt="비타민 B"> <span>비타민 B</span>
                     </div>
                  </div>

                  <!-- 비타민 목록 3 -->
                  <div class="vitamin-list">
                     <div class="vitamin-item" onclick="redirectToShoppingApi('비오틴')">
                        <img src="img/비오틴.jpg" alt="비오틴"> <span>비오틴</span>
                     </div>
                     <div class="vitamin-item" onclick="redirectToShoppingApi('엽산')">
                        <img src="img/엽산.jpg" alt="엽산"> <span>엽산</span>
                     </div>
                     <div class="vitamin-item" onclick="redirectToShoppingApi('셀레늄')">
                        <img src="img/셀레늄.jpg" alt="셀레늄"> <span>셀레늄</span>
                     </div>
                     <div class="vitamin-item" onclick="redirectToShoppingApi('콜라겐')">
                        <img src="img/콜라겐.jpg" alt="콜라겐"> <span>콜라겐</span>
                     </div>
                     <div class="vitamin-item" onclick="redirectToShoppingApi('인삼')">
                        <img src="img/인삼.jpeg" alt="인삼"> <span>인삼</span>
                     </div>
                     <div class="vitamin-item"
                        onclick="redirectToShoppingApi('비타민K')">
                        <img src="img/비타민 K.jpg" alt="비타민 K"> <span>비타민 K</span>
                     </div>
                     <div class="vitamin-item" onclick="redirectToShoppingApi('커큐민')">
                        <img src="img/커큐민.jpg" alt="커큐민"> <span>커큐민</span>
                     </div>
                     <div class="vitamin-item"
                        onclick="redirectToShoppingApi('멜라토닌')">
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

         function redirectToSearchResult() {
             var vitaminName = document.getElementById('searchInput').value || '';
             const encodedVitaminName = encodeURIComponent(vitaminName);
             window.location.href = `/ST/GoSearchResultPage?vitamin=${encodedVitaminName}`;
         }

         function navigateToCategory(category) {
             window.location.href = `/ST/GoSearchResultPage?category=${encodeURIComponent(category)}`;
         }

         function redirectToShoppingApi(vitaminName) {
             const encodedVitaminName = encodeURIComponent(vitaminName || '');
             window.location.href = `/ST/GoSearchResultPage?vitamin=${encodedVitaminName}`;
         
         }
     
         function toggleDropdown() {
             const dropdownMenu = document.getElementById('dropdownMenu');
             // 현재 드롭다운이 열려 있는지 여부에 따라 열기/닫기 처리
             if (dropdownMenu.style.display === 'block') {
                 dropdownMenu.style.display = 'none';
             } else {
                 dropdownMenu.style.display = 'block';
             }
         }
     </script>

   
   </body>
</html>
