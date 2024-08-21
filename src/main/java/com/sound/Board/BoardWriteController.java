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

        // 세션에서 사용자 ID 가져오기 (세션 유효성 확인 추가)
        HttpSession session = request.getSession(false); // 이미 존재하는 세션을 가져옴 (없으면 null 반환)
        if (session == null) {
            System.out.println("세션이 존재하지 않습니다.");
            response.sendRedirect("login.jsp"); // 로그인 페이지로 리다이렉트
            return;
        }

        Users user = (Users) session.getAttribute("user");
        if (user == null) {
            System.out.println("세션에 사용자 정보가 없습니다.");
            response.sendRedirect("login.jsp"); // 로그인 페이지로 리다이렉트
            return;
        }

        String usrId = user.getUsrId();

        // 파일 업로드 처리
        String savePath = request.getServletContext().getRealPath("save");
        File saveDir = new File(savePath);
        if (!saveDir.exists()) {
            saveDir.mkdirs(); // 저장 경로가 존재하지 않으면 디렉토리를 생성
        }

        int maxSize = 10 * 1024 * 1024; // 10MB
        String encoding = "UTF-8";

        // MultipartRequest를 통해 파일 업로드와 폼 데이터를 처리
        MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, encoding, new DefaultFileRenamePolicy());

        // 폼 데이터 가져오기
        String title = multi.getParameter("title");
        String content = multi.getParameter("content");
        String img = multi.getFilesystemName("file");

        // 디버깅: 파라미터 값 출력
        System.out.println("Title: " + title);
        System.out.println("Content: " + content);
        System.out.println("Image: " + img);
        System.out.println("User ID: " + usrId);

        // Board 객체 생성 및 데이터 설정
        Board board = new Board();
        board.setPostTitle(title);
        board.setPostContent(content);
        board.setPostFile(img != null ? "save/" + img : null); // 이미지 경로 설정
        board.setUsrId(usrId);

        // DAO를 사용해 데이터베이스에 저장
        BoardDAO dao = new BoardDAO();
        int cnt = dao.writer(board);

        // 결과에 따라 리다이렉트 또는 에러 메시지 처리
        if (cnt > 0) {
            response.sendRedirect("GoBoard");
            System.out.println("성공");
        } else {
            request.setAttribute("error", "게시글 작성에 실패했습니다.");
            System.out.println("실패");
            request.getRequestDispatcher("Board.jsp").forward(request, response);
        }
    }
}
