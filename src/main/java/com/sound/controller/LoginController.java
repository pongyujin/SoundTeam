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

@WebServlet("/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String usr_id = request.getParameter("usr_id");
		String usr_pw = request.getParameter("usr_pw");

		Users user = new Users();

		user.setUsrId(usr_id);
		user.setUsrPw(usr_pw);

		UsersDAO dao = new UsersDAO();

		Users result = dao.Login(user);

		if (result != null) {
			System.out.println("로그인 성공");
			
			// 세션에 값 저장 후
			HttpSession session = request.getSession();
			session.setAttribute("user", result);
			System.out.println("세션값 있냐?" + result);
			System.out.println("세션 ID: " + session.getId());

			// 성공시 main 창으로 가기
			response.sendRedirect("GoMain");

		} else {
			System.out.println("로그인 실패");
			// main 창으로 가기
			response.sendRedirect("GoMain");
		}

	}

}
