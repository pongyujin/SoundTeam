<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>글쓰기</title>
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

.board-title {
	text-align: center;
	font-size: 1.5em;
	font-weight: bold;
	margin-bottom: 20px;
}

.form-group {
	margin-bottom: 10px;
}

.form-group label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

.form-group input, .form-group textarea {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	box-sizing: border-box;
}

.form-group input[type="file"] {
	padding: 3px;
}

#title {
	margin-bottom: -40px;
	margin-top: -5px;
}

#content {
	height: 300px;
}

.upload-btn {
	background-color: #66DAE4;
	color: white;
	padding: 10px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-weight: bold;
	width: 100%;
	box-sizing: border-box;
}
</style>
</head>
<body>
	<form action="BoardWrite" method="post" enctype="multipart/form-data">
		<div class="form-group">
			<label for="title">제목</label> <input type="text" id="title"
				name="title" placeholder="제목을 입력하세요">
		</div>
		<div class="form-group">
			<label for="content">내용</label>
			<textarea id="content" name="content" placeholder="내용을 입력하세요"></textarea>
		</div>
		<div class="form-group">
			<label for="imageUpload">사진첨부</label> <input type="file"
				id="imageUpload" name="file" accept="image/*">
		</div>
		<button class="upload-btn" type="submit">업로드</button>
	</form>

	<div class="container">
		<div class="header">
			<div class="logo">
				<a href="GoMain"> <img src="img/로고.png" alt="로고">
				</a>
			</div>
			<div class="menu-icon">
				<div></div>
				<div></div>
				<div></div>
			</div>
		</div>
		<h2 class="board-title">글쓰기</h2>
		<div class="form-group">
			<label for="title">제목</label> <input type="text" id="title"
				placeholder="제목을 입력하세요">
		</div>
		<div class="form-group">
			<label for="content">내용</label>
			<textarea id="content" placeholder="내용을 입력하세요"></textarea>
		</div>
		<div class="form-group">
			<label for="imageUpload">사진첨부</label> <input type="file"
				id="imageUpload" accept="image/*">
		</div>
		<button class="upload-btn" onclick="uploadPost()">업로드</button>
	</div>

	<script>
        function uploadPost() {
            const title = document.getElementById('title').value;
            const content = document.getElementById('content').value;
            const imageInput = document.getElementById('imageUpload');
            const image = imageInput.files[0];

            if (title === '' || content === '') {
                alert('제목과 내용을 모두 입력해주세요.');
                return;
            }

            const reader = new FileReader();
            reader.onloadend = function() {
                const posts = JSON.parse(localStorage.getItem('posts')) || [];
                const newPost = {
                    no: posts.length + 1,
                    title: title,
                    writer: '사용자', // 실제 사용자 이름을 넣을 수 있음
                    date: new Date().toISOString().split('T')[0],
                    content: content,
                    image: reader.result // 이미지 데이터 URL을 저장
                };

                posts.push(newPost);
                localStorage.setItem('posts', JSON.stringify(posts));
                alert('게시물이 성공적으로 업로드되었습니다!');
                window.location.href = 'index.html'; // 목록 페이지로 이동
            };

            if (image) {
                reader.readAsDataURL(image); // 이미지 파일 읽기
            } else {
                alert('이미지를 선택하지 않았습니다. 게시물은 이미지 없이 업로드됩니다.');
                reader.onloadend(); // 이미지가 없을 때도 게시물 업로드 처리
            }
        }
    </script>
</body>
</html>

