package com.sound.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 세션 무효화
		HttpSession session = request.getSession(false); // false: 세션이 없으면 null 리턴
		if (session != null) {
			session.invalidate(); // 세션 무효화
		}

		// 로그인 페이지로 리다이렉트
		response.sendRedirect("GoMain");

	}

}
