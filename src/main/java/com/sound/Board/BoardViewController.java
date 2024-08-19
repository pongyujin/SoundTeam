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
        
        int idx = Integer.parseInt(request.getParameter("idx"));

        BoardDAO dao = new BoardDAO();
        Board board = dao.view(idx);

        request.setAttribute("board", board);

        String url = ""; 
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }
}
