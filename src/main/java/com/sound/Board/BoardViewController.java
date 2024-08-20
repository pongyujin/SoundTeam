package com.sound.Board;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sound.DAO.BoardDAO;
import com.sound.entity.Board;

@WebServlet("/BoardView")
public class BoardViewController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int postId = Integer.parseInt(request.getParameter("postId"));

        BoardDAO dao = new BoardDAO();
        
        // 조회수 증가
        dao.increaseViewCount(postId);
        
        // 게시글 조회
        Board board = dao.view(postId);
        request.setAttribute("board", board);

        String url = "/WEB-INF/views/ViewPost.jsp"; 
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }
}
