<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 - 추천 영양제</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
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
        }

        .logo img {
            width: 110px;
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
        .h1{text-align: center;} 
        .name {
    font-size: 1.5em; /* rgb(167, 228, 239)기 조정 */
    margin:rgb(0, 0, 0), 0, 0); /* 여백 제거 */ 
    padding-bottom: 10px;  /* 아래쪽 패딩 추가 */
    margin-top:50px;  
    }
        .edit-profile-btn {    
    background-color: #66DAE4; 
    color: black ; 
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
     margin-left: 0; /* 오른쪽 정렬을 위해 왼쪽 마진을 자동으로 설정 */
    margin-right: auto;
     margin-top: 50px ;  
}

.edit-profile-btn:hover {
    background-color: #5bc0de;
}
        .h{font-size:1.2em;
           margin-left:10px;
           font-weight:700;
           margin-top : 40px; 
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
                <a href="GoMain">
                    <img src="img/로고.png" alt="로고">
                </a>
            </div>
            <div class="menu-icon" onclick="toggleDropdown()">
                <div></div>
                <div></div>
                <div></div>
            </div>
            <div class="dropdown-menu" id="dropdownMenu">
                <a href="GoMyPage1">마이페이지</a>
                <a href="GoBoard">게시판</a>
            </div>
            
        </div>
        <h1 class ="h1">마이페이지</h1>
        <h1 class ="name" >님😊</h1>
        <button class="edit-profile-btn" onclick="location.href='editProfile.jsp'">회원정보 수정</button>
        <h class ="h">추천받은 정보 확인하기 </h>
        <ul class="supplement-list" id="supplementList">
            <!-- 영양제 목록이 동적으로 추가됩니다 -->
        </ul>
        <div class="pagination">
            <!-- 페이지네이션 버튼이 동적으로 추가됩니다 -->
        </div>
    </div>

    <script>
        let supplements = [
            { date: "2023-08-01", time: "10:00", name: "비타민 C" },
            { date: "2023-08-02", time: "11:00", name: "오메가 3" },
            // 더 많은 영양제 데이터
        ];
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
                    alert('상세 페이지로 이동: ' + item.name); // 상세 페이지로의 이동 로직 필요
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