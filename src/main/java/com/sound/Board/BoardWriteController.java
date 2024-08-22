package com.sound.Board;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.sound.DAO.BoardDAO;
import com.sound.entity.Board;
import com.sound.entity.Users;

@WebServlet("/BoardWrite")
public class BoardWriteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Users user = (Users) session.getAttribute("user");
        String usrId = user.getUsrId();

        // 파일 업로드 처리
        String savePath = request.getServletContext().getRealPath("/save");
        File saveDir = new File(savePath);
        if (!saveDir.exists()) {
            saveDir.mkdirs(); 
        }

        int maxSize = 10 * 1024 * 1024; 
        String encoding = "UTF-8";

        MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, encoding, new DefaultFileRenamePolicy());

        String title = multi.getParameter("title");
        String content = multi.getParameter("content");
        String img = multi.getFilesystemName("file");

        // Board 객체 생성 및 데이터 설정
        Board board = new Board();
        board.setPostTitle(title);
        board.setPostContent(content);
        board.setPostFile(img != null ? "save/" + img : null); 
        board.setUsrId(usrId);

        BoardDAO dao = new BoardDAO();
        int cnt = dao.writer(board);

        if (cnt > 0) {
            response.sendRedirect("GoBoard?success=true");
        } else {
            request.setAttribute("error", "게시글 작성에 실패했습니다.");
            request.getRequestDispatcher("Board.jsp").forward(request, response);
        }
    }
}
