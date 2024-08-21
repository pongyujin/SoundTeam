<%@page import="com.sound.entity.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sound.entity.Board" %>
<%@ page import="com.sound.entity.Comment" %>
<%@ page import="java.util.List" %>

<%
// 세션에서 user 객체를 가져옴
Users sessionUser = (Users) session.getAttribute("user");
if (sessionUser == null) {
    // 로그인이 되어 있지 않으면 로그인 페이지로 리다이렉트
    response.sendRedirect("login.jsp");
    return;
}
String sessionUserId = sessionUser.getUsrId();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 보기</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&family=Jua&family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
    <style>
        /* 전체 CSS */
        body {
            font-family: 'Noto Sans KR', sans-serif;
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

        .view-count {
            text-align: right;
            font-size: 0.9em;
            color: #555;
            margin-top: -15px;
            margin-bottom: 20px;
        }

        .like-container {
            display: flex;
            justify-content: flex-start;
            margin-bottom: 100px;
            margin-top: 100px;
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

        .delete-btn {
            margin-left: 180px;
            color: #ff6b6b;
            font-size: 0.9em;
            text-decoration: none;
            cursor: pointer;
        }

        .delete-btn:hover {
            text-decoration: none;
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
            object-fit: contain;
        }

        .post-meta {
            margin-top: -20px;
            margin-bottom: 10px;
            text-align: right;
            font-size: 1em;
            color: black;
        }
   
        .comments-section {
            margin-top: 20px;
            flex-grow: 1;
        }

        .comments-section h3 {
            margin-top: -80px;
            font-size: 1.2em;
            margin-bottom: 0px;
            margin-left: 10px;
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
            position: fixed;
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
            max-width: 430px;
            margin: 0 auto;
        }

        .comment-input {
            flex: 1;
            margin-right: 10px;
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
                    <a href="GoMain">
                        <img src="img/로고.png" alt="로고">
                    </a>
                </div>
                <div class="menu-icon">
                    <div></div>
                    <div></div>
                    <div></div>
                </div>
            </div>
            <h2 class="post-title"><%= ((Board)request.getAttribute("board")).getPostTitle() %></h2>
            <div class="view-count">
                조회수: <%= ((Board)request.getAttribute("board")).getViewCount() %>
            </div>
            <div class="post-content">
                <%= ((Board)request.getAttribute("board")).getPostContent() %>
            </div>
            
            <% 
                String postFilePath = ((Board)request.getAttribute("board")).getPostFile();
                System.out.println("Image Path: " + postFilePath); // 경로 확인 로그
                if (postFilePath != null && !postFilePath.isEmpty()) {
            %>
                <img src="<%= request.getContextPath() + "/save/" + postFilePath %>" 
                     alt="게시글 이미지" class="post-image"
                     onerror="this.style.display='none'">
            <% 
                }
            %>

            <div class="like-container">
                <button class="like-btn" id="likeBtn"><span class="icon">❤️</span> 좋아요 <%= request.getAttribute("likes") %></button>
                
                <% if (sessionUserId.equals(((Board)request.getAttribute("board")).getUsrId())) { %>
                    <a href="javascript:void(0);" class="delete-btn" id="deleteBtn" onclick="deletePost(event)">게시글 삭제</a>
                <% } %>
            </div>
        </div>

        <div class="comments-section">
            <h3>댓글😁</h3>
            <div id="commentsList">
                <% 
                List<Comment> comments = (List<Comment>) request.getAttribute("comments");
                if (comments != null) {
                    for (Comment comment : comments) { 
                %>
                        <div class="comment">
                            <p><strong><%= comment.getUsrId() %>:</strong> <%= comment.getContent() %></p>
                        </div>
                <% 
                    } 
                } else { 
                %>
                    <p>댓글이 없습니다.</p>
                <% 
                } 
                %>
            </div>
        </div>
    </div>
    
    <div class="fixed-footer">
        <div class="comment-input">
            <textarea id="commentInput" placeholder="댓글을 입력하세요"></textarea>
        </div>
        <button class="submit-btn" onclick="addComment()">댓글 달기</button>
    </div>

    <script>
        let likeCount = <%= request.getAttribute("likes") %>;
        const postId = <%= ((Board)request.getAttribute("board")).getPostId() %>;
        const sessionUserId = '<%= sessionUserId %>';
        const boardUserId = '<%= ((Board)request.getAttribute("board")).getUsrId() %>';

        // 디버깅을 위한 로그 출력
        console.log("Session User ID:", sessionUserId);
        console.log("Board User ID:", boardUserId);

        function renderLikes() {
            document.getElementById('likeBtn').innerHTML = `<span class="icon">❤️</span> 좋아요 ${likeCount}`;
        }

        document.getElementById('likeBtn').addEventListener('click', function() {
            if (likeCount < 3) {
                likeCount++;
                renderLikes();
                updateLikes(postId, likeCount);
            } else {
                alert('좋아요는 1아이디당 3번까지 가능합니다.');
            }
        });

        function addComment() {
            const commentInput = document.getElementById('commentInput');
            const commentText = commentInput.value.trim();
            const usrId = sessionUserId;
            
            if (commentText) {
                saveComment(postId, usrId, commentText);
                commentInput.value = '';
                location.reload(); // 댓글 추가 후 페이지를 새로 고침
            } else {
                alert('댓글을 입력하세요.');
            }
        }

        function saveComment(postId, usrId, content) {
            fetch('<%= request.getContextPath() %>/BoardComment', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8'
                },
                body: JSON.stringify({ postId, usrId, content })
            }).then(response => {
                if (response.ok) {
                    location.reload(); // 성공 시 페이지를 새로고침
                } else {
                    alert('댓글 저장에 실패했습니다.');
                }
            });
        }

        function updateLikes(postId, likes) {
            fetch('/updateLikes', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8'
                },
                body: JSON.stringify({ postId, likes })
            });
        }

        function deletePost(event) {
            event.preventDefault(); // 기본 동작 방지

            console.log("Delete button clicked");
            console.log("Session User ID:", sessionUserId);
            console.log("Board User ID:", boardUserId);

            if (sessionUserId !== boardUserId) {
                alert("삭제 권한이 없습니다.");
                return;
            }
            
            if (confirm("정말로 이 게시글을 삭제하시겠습니까?")) {
                fetch('<%= request.getContextPath() %>/BoardDelete', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: `postId=${postId}`
                }).then(response => {
                    if (response.ok) {
                        alert('게시글이 성공적으로 삭제되었습니다.');
                        window.location.href = 'BoardList';
                    } else {
                        alert('게시글 삭제에 실패했습니다.');
                    }
                });
            }
        }
    </script>
</body>
</html>
