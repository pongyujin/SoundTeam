package com.sound.Board;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sound.DAO.BoardDAO;
import com.sound.entity.Board;

@WebServlet("/BoardList")
public class BoardListController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int page = 1; // 기본 페이지 번호
        int limit = 10; // 페이지당 게시글 수
        
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        
        int offset = (page - 1) * limit;
        
        BoardDAO dao = new BoardDAO();
        List<Board> list = dao.list(offset, limit);
        
        request.setAttribute("list", list);
        
        String url = "WEB-INF/views/board.jsp";
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }
}
