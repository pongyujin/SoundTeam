<%@page import="com.sound.entity.Board"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자유게시판</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&family=Jua&family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<style>
*  {
  font-family: "Jua", sans-serif;
  font-weight: 400;
  font-style: normal;
    text-rendering: optimizeLegibility;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;

  
  }
/* 기존 스타일은 그대로 유지 */
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

.search-bar {
    display: flex;  /* 수평 정렬을 위해 flexbox 사용 */
    align-items: center;  /* 수직 중앙 정렬 */
    margin-left: 50px;  /* 원하는 만큼 오른쪽으로 이동 */
    width: 100%;  /* 전체 폭을 사용할 수 있도록 설정 */
    max-width: 800px; 
    /* 최대 너비를 설정하여 전체 레이아웃에 맞춤 */
}

.search-bar input {
    flex-grow: 3;  /* input이 더 많은 공간을 차지하도록 설정 */
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 15px;
    margin-right: 10px;  /* 버튼과의 간격 */
    box-sizing: border-box;  /* 패딩과 테두리를 포함한 전체 크기 설정 */
}

.search-bar button {
    padding: 10px 20px;
    background-color: #66DAE4;
    border: none;
    border-radius: 15px;
    cursor: pointer;
    color: #fff;
    font-weight: bold;
    flex-shrink: 0;  /* 버튼이 줄어들지 않도록 설정 */
    white-space: nowrap;  /* 버튼의 텍스트가 줄바꿈되지 않도록 */
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
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
.a{
 text-decoration: none;
 color:black; /* 링크 밑줄 제거 */}


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
	margin-bottom: 20px; /* 글쓰기 버튼 아래에 여백 추가 */
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
    background-color: #f9f9f9; /* 기본 배경색 */
}

.pagination a.active {
    background-color: #66DAE4;
    color: white;
}
.pagination a:hover {
    background-color: #ddd;
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
			<div class="menu-icon" onclick="toggleDropdown()">
				<div></div>
				<div></div>
				<div></div>
			</div>
			<div class="dropdown-menu" id="dropdownMenu">
				<a href="GoMyPage">마이페이지</a> <a href="GoBoard">게시판</a><a href="">로그아웃</a>
			</div>
		</div>

		<h2 class="board-title">자유게시판💕</h2>

		<div class="search-bar">
			<form action="BoardSearch" method="get">
				<input type="text" name="search" placeholder="게시글을 검색해보세요 !">
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
			<tbody>
				<%-- 게시글 목록을 출력 --%>
				<% 
				List<Board> list = (List<Board>)request.getAttribute("list");
				int no = 1; // 순차적으로 번호를 매기기 위해 초기화
				if (list != null && !list.isEmpty()) {
					for(Board board : list) { 
				%>
				<tr>
					<td><%= no++ %></td>
					<td><a class="a" href="BoardView?postId=<%= board.getPostId() %>"><%= board.getPostTitle() %></a></td>
					<td><%= board.getUsrId() %></td>
					<td><%= board.getCreatedAt() %></td>
				</tr>
				<% 
					}
				} else {
				%>
				<tr>
					<td colspan="4">게시글이 없습니다.</td>
				</tr>
				<%
				} 
				%>
			</tbody>
		</table>

        <a href="GoBoardPost" class="write-btn">글쓰기</a>

 <!-- 페이지네이션 -->
<div class="pagination">
    <%
    int totalPages = (int) request.getAttribute("totalPages");
    int currentPage = (int) request.getAttribute("currentPage");

    int maxPageNumbers = 5; // 한 번에 표시할 페이지 번호의 개수
    int startPage = ((currentPage - 1) / maxPageNumbers) * maxPageNumbers + 1;
    int endPage = Math.min(startPage + maxPageNumbers - 1, totalPages);

    // "이전" 버튼
    if (startPage > 1) {
    %>
        <a href="BoardList?page=<%= startPage - 1 %>">이전</a>
    <%
    }

    // 페이지 번호들
    for (int i = startPage; i <= endPage; i++) {
        if (i == currentPage) {
    %>
            <a href="BoardList?page=<%= i %>" class="active"><%= i %></a>
    <%
        } else {
    %>
            <a href="BoardList?page=<%= i %>"><%= i %></a>
    <%
        }
    }

    // "다음" 버튼
    if (endPage < totalPages) {
    %>
        <a href="BoardList?page=<%= endPage + 1 %>">다음</a>
    <%
    }
    %>
</div>

       


    

	<script>
        function toggleDropdown() {
            const dropdownMenu = document.getElementById('dropdownMenu');
            dropdownMenu.style.display = dropdownMenu.style.display === 'block' ? 'none' : 'block';
        }
    </script>
</body>
</html>
