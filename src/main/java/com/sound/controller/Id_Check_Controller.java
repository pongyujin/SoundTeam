package com.sound.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sound.DAO.UsersDAO;
import com.sound.entity.Users;


@WebServlet("/CheckId")
public class Id_Check_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		
		
		String usr_id = request.getParameter("userid");
		System.out.println(usr_id);
		
		
		// 기능 실행
		UsersDAO userdao = new UsersDAO();
		
		Users result = userdao.id_check(usr_id);
		
		System.out.println(result);
		
		response.setContentType("text/plain; charset=UTF-8");
		
		if(result == null) {
			response.getWriter().write("ok");
			System.out.println("ok");
		}else {
			System.out.println("no");
			response.getWriter().write("no");
		}
		
		
		
		
	}

}
