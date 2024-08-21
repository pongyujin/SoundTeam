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
        Users user = (Users)session.getAttribute("user");
        
        // 기존 세션의 사용자 정보 업데이트
        user.setUsrName(usr_name);
        user.setUsrPw(usr_pw);
        user.setUsrEmail(usr_email);
        
        // 2. 기능 실행
        UsersDAO dao = new UsersDAO();
        int cnt = dao.update(user);
		System.out.println("디버깅 테스트용");
        
		if(cnt > 0) {
			System.out.println("회원정보 수정 성공");
			session.setAttribute("user", user); 
		} else {
			System.out.println("회원정보 수정 실패");
		}
		
        // 수정 완료 후 Mypage.jsp로 리다이렉트
		response.sendRedirect(request.getContextPath() + "/Mypage.jsp");
	}
}
