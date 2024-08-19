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

@WebServlet("/join")
public class JoinController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		// 1. 데이터 수집
		String usr_id = request.getParameter("userid");
		String usr_pw = request.getParameter("password");
		String usr_name = request.getParameter("name");
		String usr_email = request.getParameter("email");

		String usr_birthday = request.getParameter("birthdate");

		String usr_gender = request.getParameter("gender");

		System.out.println(usr_id);
		System.out.println(usr_pw);

		Users users = new Users();

		users.setUsrId(usr_id);
		users.setUsrName(usr_name);
		users.setUsrPw(usr_pw);
		users.setUsrEmail(usr_email);
		users.setUsrBirthday(usr_birthday);
		users.setUsrGender(usr_gender);

		// insert 기능 실행

		UsersDAO usersDAO = new UsersDAO();

		int cnt = usersDAO.Join(users);

		if (cnt > 0) {
			System.out.println("회원가입 성공");
			
			// 성공시 login 창으로 가기
			response.sendRedirect("Gologin");
		} else {
			System.out.println("회원가입 실패");
			
			// 실패시 main 창가기
			response.sendRedirect("GoMain");
		}

	}

}
