package com.sound.Board;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

import com.sound.DAO.BoardDAO;
import com.sound.entity.Comment;

@WebServlet("/BoardComment")
public class BoardCommentController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // 요청과 응답의 인코딩을 UTF-8로 설정
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");

            BufferedReader reader = request.getReader();
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            reader.close();

            JSONObject json = new JSONObject(sb.toString());
            int postId = json.getInt("postId");
            String usrId = json.getString("usrId");
            String content = json.getString("content");

            System.out.println("Received data: postId=" + postId + ", usrId=" + usrId + ", content=" + content);

            Comment comment = new Comment();
            comment.setPostId(postId);
            comment.setUsrId(usrId);
            comment.setContent(content);

            BoardDAO dao = new BoardDAO();
            int result = dao.addComment(comment);

            System.out.println("Insert result: " + result);

            if (result > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
