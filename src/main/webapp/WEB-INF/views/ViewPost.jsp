<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 보기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #ffffff;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
        }

        .container {
            background-color: #ffffff;
            width: 100%;
            max-width: 430px;
            height: 100%;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            box-sizing: border-box;
            position: relative;
            display: flex;
            flex-direction: column;
            overflow-y: auto;
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

        .post-title {
            text-align: center;
            font-size: 1.5em;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .like-container {
            display: flex;
               justify-content: flex-start; /* 왼쪽 정렬 */
            margin-bottom: 100px;
            margin-top: 100px; /* 위쪽에 여백 추가 */
            
        }
        
        .like-btn {
            background-color: #ff6b6b;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            font-size: 1em;
            display: flex;
            align-items: center;
        }

        .like-btn .icon {
            margin-right: 5px;
            font-size: 1.2em;
          
           
        }

        .post-content {
            margin-bottom: 20px;
            line-height: 1.6;
        }

        .post-image {
            width: 100%;
            max-width: 100%;
            height: auto;
            margin-bottom: 20px;
        }

        .comments-section {
            margin-top: 20px;
            flex-grow: 1;
        }
.comments-section h3 {
    margin-top: -80px; /* 음수 값을 사용해 위로 올림 */
    font-size: 1.2em;
    margin-bottom: 0px; /* 필요 시 아래쪽 여백도 제거 */
    margin-left:10px;
}

        .comment {
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
            margin-bottom: 10px;
        }

        .comment p {
            margin: 5px 0;
        }

        .fixed-footer {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background-color: #ffffff;
            padding: 10px 20px;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-sizing: border-box;
        }

        .comment-input {
            flex: 1;
            margin: 0 10px;
        }

        .comment-input textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            resize: none;
        }

        .submit-btn {
            background-color: #66DAE4;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }
    </style>
</head>
<body>
   <div class="container">
    <div>
        <div class="header">
            <div class="logo">
                <a href="index.html">
                    <img src="img/로고.png" alt="로고">
                </a>
            </div>
            <div class="menu-icon">
                <div></div>
                <div></div>
                <div></div>
            </div>
        </div>
        <h2 class="post-title" id="postTitle">게시글 제목</h2>
        <div class="post-content" id="postContent">
            게시글 내용이 여기에 표시됩니다.
        </div>
        <img src="" alt="첨부 이미지" class="post-image" id="postImage">
        
        <!-- comments-section 위로 like-container 이동 -->
        <div class="like-container">
            <button class="like-btn" id="likeBtn"><span class="icon">❤️</span> 좋아요 0</button>
        </div>

        <div class="comments-section">
            <h3 >댓글😁</h3>
            <div id="commentsList">
                <!-- 댓글 목록이 여기에 표시됩니다 -->
            </div>
        </div>
    </div>
    
    <!-- 고정된 푸터 -->
    <div class="fixed-footer">
        <div class="comment-input">
            <textarea id="commentInput" placeholder="댓글을 입력하세요"></textarea>
        </div>
        <button class="submit-btn" onclick="addComment()">댓글 달기</button>
    </div>
</div>

    <script>
        const post = {
            title: '게시글 제목이 들어갑니다.',
            content: '게시글 내용이 들어갑니다',
            image: 'img/sample-image.png', // 실제 이미지 경로를 설정하세요
            likes: 0,
            comments: []
        };

        function renderPost() {
            document.getElementById('postTitle').innerText = post.title;
            document.getElementById('postContent').innerText = post.content;

            const postImage = document.getElementById('postImage');
            if (post.image) {
                postImage.src = post.image;
                postImage.style.display = 'block';
            } else {
                postImage.style.display = 'none';
            }
        }

        function renderLikes() {
            document.getElementById('likeBtn').innerHTML = `<span class="icon">❤️</span> 좋아요 ${post.likes}`;
        }

        function renderComments() {
            const commentsList = document.getElementById('commentsList');
            commentsList.innerHTML = '';

            post.comments.forEach(comment => {
                const commentDiv = document.createElement('div');
                commentDiv.className = 'comment';
                commentDiv.innerHTML = `<p>${comment}</p>`;
                commentsList.appendChild(commentDiv);
            });
        }

        function addComment() {
            const commentInput = document.getElementById('commentInput');
            const comment = commentInput.value.trim();
            if (comment) {
                post.comments.push(comment);
                commentInput.value = '';
                renderComments();
            } else {
                alert('댓글을 입력하세요.');
            }
        }

        document.getElementById('likeBtn').addEventListener('click', function() {
            post.likes++;
            renderLikes();
        });

        window.onload = function() {
            renderPost();
            renderLikes();
            renderComments();
        };
    </script>
</body>
</html>
