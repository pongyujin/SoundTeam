package com.sound.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sound.DAO.UsersDAO;
import com.sound.entity.Users;

@WebServlet("/update")
public class UpdateController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 1. 데이터 수집
        request.setCharacterEncoding("UTF-8");

        String usr_pw = request.getParameter("password");
        String usr_name = request.getParameter("name");
        String usr_email = request.getParameter("email");

        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");

        // 기존 세션의 사용자 정보 업데이트
        user.setUsrName(usr_name);
        user.setUsrPw(usr_pw);
        user.setUsrEmail(usr_email);

        // 2. 기능 실행
        UsersDAO dao = new UsersDAO();
        int cnt = dao.update(user);

        if(cnt > 0) {
            System.out.println("회원정보 수정 성공");
            session.setAttribute("user", user); 
            request.setAttribute("updateStatus", "success");
        } else {
            System.out.println("회원정보 수정 실패");
            request.setAttribute("updateStatus", "fail");
        }

        // JSP로 포워딩하여 알람 표시
        request.getRequestDispatcher("WEB-INF/views/Main.jsp").forward(request, response);
    }
}
