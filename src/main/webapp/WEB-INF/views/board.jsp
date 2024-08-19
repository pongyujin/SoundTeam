<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유게시판</title>
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
        .board-title {
            text-align: center;
            font-size: 1.5em;
            font-weight: bold;
            margin-bottom: 20px;
        }
            }

        .search-bar {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
        }

        .search-bar input {
            padding: 10px;
            width: 70%;
            border: 1px solid #ddd;
            border-radius: 20px;
            margin-right: 10px;
             margin-bottom: 20px;
    margin-top: -80px; /
}
        

        .search-bar button {
            padding: 10px 20px;
            background-color: #66DAE4;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            color: #fff;
            font-weight: bold;
            margin-bottom: 20px;
            margin-top: -80px; /
        }

table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 250px;
}

table th, table td {
    padding: 10px;
    border-bottom: 1px solid #ddd;
    text-align: center;
}

table th {
    position: sticky;
    top: 0;
    background-color: #f9f9f9;
}
        .write-btn {
            display: block;
            width: 100%;
            max-width: 150px;
            padding: 15px;
            margin: 0 auto;
            background-color: #B0E9EE;
            color: #000;
            text-align: center;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
        }
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .pagination a {
            margin: 0 5px;
            padding: 10px 15px;
            text-decoration: none;
            color: #000;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .pagination a.active {
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

        <h2 class="board-title">자유게시판</h2>

        <div class="search-bar">
            <form action="board.jsp" method="get">
                <input type="text" name="search" placeholder="보고싶은 게시글을 검색해보세요 !">
                <button type="submit">검색</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th>No</th>
                    <th>제목</th>
                    <th>글쓴이</th>
                    <th>작성일</th>
                </tr>
            </thead>
           
        </table>


        <a href="GoBoardPost" class="write-btn">글쓰기</a>
    </div>

    <script>
        function toggleDropdown() {
            const dropdownMenu = document.getElementById('dropdownMenu');
            dropdownMenu.style.display = dropdownMenu.style.display === 'block' ? 'none' : 'block';
        }
    </script>
</body>
</html>
