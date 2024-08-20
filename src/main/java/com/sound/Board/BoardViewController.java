package com.sound.Board;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sound.DAO.BoardDAO;
import com.sound.entity.Board;
import com.sound.entity.Comment;

@WebServlet("/BoardView")
public class BoardViewController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int postId = Integer.parseInt(request.getParameter("postId"));
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        BoardDAO dao = new BoardDAO();
        
        // 조회수 증가
        dao.increaseViewCount(postId);
        
        // 게시글 조회
        Board board = dao.view(postId);
        request.setAttribute("board", board);
        request.setAttribute("userId", userId); // userId를 JSP에 전달
        
        // 댓글과 좋아요 정보를 추가로 불러와서 JSP에 전달해야 합니다.
        List<Comment> comments = dao.getCommentsByPostId(postId);
        int likes = dao.getLikesByPostId(postId);
        
        request.setAttribute("comments", comments);
        request.setAttribute("likes", likes);

        String url = "/WEB-INF/views/ViewPost.jsp"; 
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }
}
