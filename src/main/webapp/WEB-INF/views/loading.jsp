<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loading Page</title>
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
            justify-content: center; /* 수직 중앙 정렬 */
            align-items: center; /* 수평 중앙 정렬 */
            box-sizing: border-box;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
        }

        .loading-container {
            text-align: center;
        }

        .loading-container img {
            width: 300px; /* 로딩 GIF의 크기를 조정 */
            height: auto;
        }

        .loading-text {
            font-size: 1.5em;
            margin-top: 20px;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="loading-container">
            <img src="img/loading2.gif" alt="Loading...">
            <div class="loading-text">잠시만 기다려 주세요...</div>
        </div>
    </div>
</body>
</html>y>

</body>
</html>