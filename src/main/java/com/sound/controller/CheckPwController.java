package com.sound.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CheckPw")
public class CheckPwController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");

		response.setContentType("text/plain"); // 텍스트 형식으로 응답

		if (password != null && password.equals(confirmPassword)) {
			response.getWriter().write("match");
		} else {
			response.getWriter().write("no match");
		}
	}

}
