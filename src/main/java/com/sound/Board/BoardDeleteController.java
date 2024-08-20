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
import com.sound.entity.Users;

@WebServlet("/BoardDelete")
public class BoardDeleteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int postId = Integer.parseInt(request.getParameter("postId"));

        HttpSession session = request.getSession();
        Users sessionUser = (Users) session.getAttribute("user");
        String sessionUserId = sessionUser.getUsrId();

        BoardDAO dao = new BoardDAO();
        Board board = dao.view(postId);
        String boardUserId = board.getUsrId();

        String url = "";

        if (sessionUserId.equals(boardUserId)) {
            // 작성자와 현재 사용자 ID가 일치하면 삭제 허용
            int cnt = dao.delete(postId);

            if (cnt > 0) {
                url = "BoardList"; // 삭제 성공 시 게시글 목록 페이지로 이동
            } else {
                url = "Board.jsp"; // 삭제 실패 시 게시글 목록 페이지로 이동
                request.setAttribute("error", "삭제에 실패했습니다.");
            }
        } else {
            // 작성자와 현재 사용자 ID가 일치하지 않으면 삭제 불가
            url = "Board.jsp"; // 게시글 상세보기 페이지로 돌아가기
            request.setAttribute("error", "삭제 권한이 없습니다.");
        }

        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }
}
