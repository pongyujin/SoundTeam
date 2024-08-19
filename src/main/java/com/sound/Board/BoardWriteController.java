package com.sound.Board;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.sound.DAO.BoardDAO;
import com.sound.entity.Board;

@WebServlet("/BoardWrite")
public class BoardWriteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String savePath = request.getServletContext().getRealPath("save");
        File saveDir = new File(savePath);
        if (!saveDir.exists()) {
            saveDir.mkdirs(); // 디렉토리가 존재하지 않으면 생성
        }
        int maxSize = 10 * 1024 * 1024; // 10MB
        String encoding = "UTF-8";

        MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, encoding, new DefaultFileRenamePolicy());

        String title = multi.getParameter("title");
        String writer = multi.getParameter("writer");
        String content = multi.getParameter("content");
        String img = multi.getFilesystemName("file");

        Board board = new Board();
        board.setTitle(title);
        board.setWriter(writer);
        board.setContent(content);
        board.setImg(img);

        BoardDAO dao = new BoardDAO();
        int cnt = dao.writer(board);

        if (cnt > 0) {
            response.sendRedirect("board.jsp"); // 게시글 목록 페이지로 리다이렉트
        } else {
            request.setAttribute("error", "게시글 작성에 실패했습니다.");
            request.getRequestDispatcher("board.jsp").forward(request, response);
        }
    }
}
