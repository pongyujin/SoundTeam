package com.sound.Board;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sound.DAO.BoardDAO;
import com.sound.entity.Board;

@WebServlet("/BoardSearch")
public class BoardSearchController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String search = request.getParameter("search");

        if (search == null || search.trim().isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.setAttribute("error", "검색어가 입력되지 않았습니다.");
            request.getRequestDispatcher("board.jsp").forward(request, response);
            return;
        }

        BoardDAO dao = new BoardDAO();
        List<Board> list = dao.search(search.trim());
        
        // 검색 결과를 JSP로 전달
        request.setAttribute("list", list);
        request.getRequestDispatcher("/WEB-INF/views/board.jsp").forward(request, response);
        System.out.println("디버깅용 테스트");
    }
}
