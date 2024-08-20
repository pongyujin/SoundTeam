package com.sound.Board;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sound.DAO.BoardDAO;
import com.sound.entity.Board;

@WebServlet("/BoardUpdate")
public class BoardUpdateController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int postId = Integer.parseInt(request.getParameter("postId"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String img = request.getParameter("img");

        HttpSession session = request.getSession();
        Board user = (Board) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("WEB-INF/views/Board.jsp"); // 로그인 페이지로 리다이렉트
            return;
        }

        Board board = new Board();
        board.setPostId(postId);
        board.setPostTitle(title);
        board.setPostContent(content);
        board.setPostFile(img);

        BoardDAO dao = new BoardDAO();
        int cnt = dao.update(board);

        String url = "";

        if (cnt > 0) {
            url = "Board.jsp"; // 업데이트 성공 시 이동할 URL 설정
            request.setAttribute("update", board);
        } else {
            url = "Board.jsp"; // 업데이트 실패 시 이동할 URL 설정
            request.setAttribute("error", "Update failed");
        }

        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }
}
