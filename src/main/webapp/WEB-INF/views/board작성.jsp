<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

.board-title {
	text-align: center;
	font-size: 1.5em;
	font-weight: bold;
	margin-bottom: 20px;
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
	margin-top: -80px;
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
	margin-top: -80px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	margin-bottom: 20px;
	margin-top: -80px;
}

table th, table td {
	padding: 10px;
	border-bottom: 1px solid #ddd;
	text-align: center;
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
	margin-bottom: 20px;
	margin-top: -50px;
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

.form-group {
	margin-bottom: 10px; /* 간격을 줄임 */
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
	margin-bottom: -40px; /* 제목과 내용 간의 간격을 줄임 */
	margin-top: -5px; /* 제목을 살짝 위로 이동 */
}

#content {
	height: 300px; /* 내용을 300px 높이로 조정 */
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
		<form id="uploadForm" action="BoardWrite" method="post"
			enctype="multipart/form-data">
			<div class="form-group">
				<label for="title">제목</label> <input type="text" id="title"
					name="title" placeholder="제목을 입력하세요">
			</div>
			<div class="form-group">
				<label for="content">내용</label>
				<textarea id="content" name="content" placeholder="내용을 입력하세요"></textarea>
			</div>
			<div class="form-group">
				<label for="imageUpload">사진첨부</label> 
				<input type="file" id="imageUpload" accept="image/*"> 
				<button class="upload-btn" onclick="uploadPost()">업로드</button>
		</form>

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
                const newPost = {
                    no: posts.length + 1,
                    title: title,
                    writer: '사용자', // 실제 사용자 이름을 넣을 수 있음
                    date: new Date().toISOString().split('T')[0],
                    content: content,
                    image: reader.result // 이미지 데이터 URL을 저장
                };

                posts.push(newPost);
                alert('게시물이 성공적으로 업로드되었습니다!');
                renderPosts(currentPage);
                renderPagination();
            };

            if (image) {
                reader.readAsDataURL(image); // 이미지 파일 읽기
            } else {
                alert('이미지를 선택하지 않았습니다. 게시물은 이미지 없이 업로드됩니다.');
                reader.onloadend(); // 이미지가 없을 때도 게시물 업로드 처리
            }
        }

        function renderPosts(page) {
            const start = (page - 1) * postsPerPage;
            const end = start + postsPerPage;
            const slicedPosts = posts.slice(start, end);

            const boardList = document.getElementById('boardList');
            boardList.innerHTML = '';

            slicedPosts.forEach(post => {
                const row = `<tr>
                    <td>${post.no}</td>
                    <td>${post.title}</td>
                    <td>${post.writer}</td>
                    <td>${post.date}</td>
                </tr>`;
                boardList.innerHTML += row;

                if (post.image || post.content) {
                    boardList.innerHTML += `<tr>
                        <td colspan="4">
                            ${post.content ? `<p>${post.content}</p>` : ''}
                            ${post.image ? `<img src="${post.image}" alt="첨부 이미지" style="max-width: 100%;">` : ''}
                        </td>
                    </tr>`;
                }
            });
        }

        window.onload = function() {
            renderPosts(currentPage);
            renderPagination();
        };
    </script>
</body>
</html>