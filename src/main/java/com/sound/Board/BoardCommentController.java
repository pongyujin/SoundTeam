package com.sound.Board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sound.DAO.BoardDAO;
import com.sound.entity.Comment;

@WebServlet("/BoardComment")
public class BoardCommentController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("postId"));
        String usrId = request.getParameter("usrId");
        String content = request.getParameter("content");

        Comment comment = new Comment();
        comment.setPostId(postId);
        comment.setUsrId(usrId);
        comment.setContent(content);

        BoardDAO dao = new BoardDAO();
        int result = dao.addComment(comment);

        if (result > 0) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
