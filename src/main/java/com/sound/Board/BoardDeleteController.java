package com.sound.Board;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sound.DAO.BoardDAO;

@WebServlet("/BoardDelete")
public class BoardDeleteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int postId = Integer.parseInt(request.getParameter("postId"));

        BoardDAO dao = new BoardDAO();
        int cnt = dao.delete(postId);

        String url = "";

        if (cnt > 0) {
            url = "Board.jsp";  // 삭제 성공 시 게시글 목록 페이지로 이동
        } else {
            url = "Board.jsp";  // 삭제 실패 시 오류 페이지로 이동
            request.setAttribute("error", "삭제에 실패했습니다.");
        }

        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }
}
