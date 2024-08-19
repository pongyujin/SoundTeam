package com.sound.Board;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
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
            response.getWriter().write("검색어가 입력되지 않았습니다.");
            return;
        }

        BoardDAO dao = new BoardDAO();
        List<Board> list = dao.search(search.trim());
        
        Gson gson = new Gson();
        String json = gson.toJson(list);
        
        response.setContentType("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print(json);
    }
}
