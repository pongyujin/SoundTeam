<<<<<<< HEAD
=======
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
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
            box-sizing: border-box;
        }
        .container {
            background-color: #ffffff;
            width: 100%;
            max-width: 360px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            height: 100vh;
            justify-content: space-between;
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
        .menu a {
            margin-left: 1em;
            text-decoration: none;
            color: #000;
            font-size: 1.2em;
        }
        .content {
            margin-top: 20px;
            width: 100%;
            padding: 1em 0;
            box-sizing: border-box;
            text-align: center;
            flex-grow: 1;
             font-size: 0.8em; 
        } 
        .search-bar {
            margin-bottom: 20px;
            
        }
        .search-bar input {
            width: 90%;
            padding: 10px;
            font-size: 0.8em; 
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
                <a href="index.html"><img src="img/로고.png" alt="로고"></a>
            </div>
            <div class="menu">
                <a href="#">로그인</a>
                <a href="#">회원가입</a>
            </div>
        </div>

        <div class="content">
            <h1>어떤 영양제를 찾으세요?</h1>
            <div class="search-bar">
                <input type="text" placeholder="제품명, 영양성분, 건강 고민을 검색해보세요!">
            </div>

            <div class="category-slider-container">
                <div class="category-slider-wrapper">
                    <div class="category-slider">
                        <div class="category-item" onclick="navigateToCategory('all')">
                            <img src="img/images.png" alt="전체">
                            <span>전체</span>
                        </div>
                        <div class="category-item" onclick="navigateToCategory('immune')">
                            <img src="img/면역력.jpg" alt="면역">
                            <span>면역</span>
                        </div>
                        <div class="category-item" onclick="navigateToCategory('diet')">
                            <img src="img/다이어트.jpg" alt="다이어트">
                            <span>다이어트</span>
                        </div>
                        <div class="category-item" onclick="navigateToCategory('stress')">
                            <img src="img/스트레스.jpg" alt="스트레스">
                            <span>스트레스</span>
                        </div>
                        <div class="category-item" onclick="navigateToCategory('digestive')">
                            <img src="img/위.jpg" alt="위건강">
                            <span>위건강</span>
                        </div>
                        <div class="category-item" onclick="navigateToCategory('digestive')">
                            <img src="img/피로함.png" alt="피로">
                            <span>피로</span>
                        </div>
                        <div class="category-item" onclick="navigateToCategory('digestive')">
                            <img src="img/눈건강.jpg" alt="눈건강">
                            <span>눈건강</span>
                        </div>
                        <div class="category-item" onclick="navigateToCategory('digestive')">
                            <img src="img/간건강.jpg" alt="간건강">
                            <span>간건강</span>
                        </div>
                        <div class="category-item" onclick="navigateToCategory('digestive')">
                            <img src="img/관절.jpg" alt="관절">
                            <span>관절</span>
                      </div>
                       <div class="category-item" onclick="navigateToCategory('digestive')">
                            <img src="img/여성건강.jpg" alt="여성건강">
                            <span>여성건강</span>
                      </div>
                       <div class="category-item" onclick="navigateToCategory('digestive')">
                            <img src="img/남성건강.jpg" alt="남성건강">
                            <span>남성건강</span>
                      </div>
                        <!-- 추가 카테고리는 여기에 계속 추가 -->
                    </div>
                </div>
            </div>

            <div class="slider-container">
                <div class="slider" id="slider">
                    <!-- 비타민 목록 1 -->
                    <div class="vitamin-list">
                        <div class="vitamin-item" onclick="navigateToProduct('vitaminC')">
                            <img src="img/vitamin1.jpg" alt="비타민 C">
                            <span>비타민 C</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('magnesium')">
                            <img src="img/vitamin2.jpg" alt="마그네슘">
                            <span>마그네슘</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('milkThistle')">
                            <img src="img/vitamin3.jpg" alt="밀크씨슬">
                            <span>밀크씨슬</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('vitaminA')">
                            <img src="img/vitamin4.jpg" alt="비타민 A">
                            <span>비타민 A</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('multivitamin')">
                            <img src="img/vitamin5.jpg" alt="멀티비타민&미네랄">
                            <span>멀티비타민&미네랄</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('zinc')">
                            <img src="img/vitamin6.jpg" alt="아연">
                            <span>아연</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('lutein')">
                            <img src="img/vitamin7.jpg" alt="루테인">
                            <span>루테인</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('theanine')">
                            <img src="img/vitamin8.jpg" alt="테아닌">
                            <span>테아닌</span>
                        </div>
                    </div>

                    <!-- 비타민 목록 2 -->
                    <div class="vitamin-list">
                        <div class="vitamin-item" onclick="navigateToProduct('omega3')">
                            <img src="img/vitamin9.jpg" alt="오메가3">
                            <span>오메가3</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('vitaminD')">
                            <img src="img/vitamin10.jpg" alt="비타민 D">
                            <span>비타민 D</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('coenzymeQ10')">
                            <img src="img/vitamin11.jpg" alt="코엔자임Q10">
                            <span>코엔자임Q10</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('probiotics')">
                            <img src="img/vitamin12.jpg" alt="유산균">
                            <span>유산균</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('vitaminE')">
                            <img src="img/vitamin13.jpg" alt="비타민 E">
                            <span>비타민 E</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('calcium')">
                            <img src="img/vitamin14.jpg" alt="칼슘">
                            <span>칼슘</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('iron')">
                            <img src="img/vitamin15.jpg" alt="철분">
                            <span>철분</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('vitaminB')">
                            <img src="img/vitamin16.jpg" alt="비타민 B">
                            <span>비타민 B</span>
                        </div>
                    </div>

                    <!-- 비타민 목록 3 -->
                    <div class="vitamin-list">
                        <div class="vitamin-item" onclick="navigateToProduct('biotin')">
                            <img src="img/vitamin17.jpg" alt="비오틴">
                            <span>비오틴</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('folicAcid')">
                            <img src="img/vitamin18.jpg" alt="엽산">
                            <span>엽산</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('selenium')">
                            <img src="img/vitamin19.jpg" alt="셀레늄">
                            <span>셀레늄</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('collagen')">
                            <img src="img/vitamin20.jpg" alt="콜라겐">
                            <span>콜라겐</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('ginseng')">
                            <img src="img/vitamin21.jpg" alt="인삼">
                            <span>인삼</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('vitaminK')">
                            <img src="img/vitamin22.jpg" alt="비타민 K">
                            <span>비타민 K</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('curcumin')">
                            <img src="img/vitamin23.jpg" alt="커큐민">
                            <span>커큐민</span>
                        </div>
                        <div class="vitamin-item" onclick="navigateToProduct('melatonin')">
                            <img src="img/vitamin24.jpg" alt="멜라토닌">
                            <span>멜라토닌</span>
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

        function navigateToCategory(category) {
            // 카테고리별 제품을 보여주는 페이지로 이동 (예시)
            // location.href = `/category/${category}`;
        }

        function navigateToProduct(productId) {
            // 제품 상세 페이지로 이동 (예시)
            // location.href = `/product/${productId}`;
        }
    </script>
</body>
</html>
>>>>>>> branch 'master' of https://github.com/2024-SMHRD-KDT-BigData-24/SoundTeam.git
