<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>네이버 쇼핑 검색</title>
</head>
<body>
	<h1>네이버 쇼핑 검색</h1>
	<form action="searchShopping" method="get">
		<label for="query">검색어:</label> <input type="text" id="query"
			name="query" required>
		<button type="submit">검색</button>
	</form>
</body>
</html>