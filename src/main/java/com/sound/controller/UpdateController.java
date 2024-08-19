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
        String id = user.getUsrId();
        
        Users member = new Users();
        
        user.setUsrName(usr_name);
        user.setUsrPw(usr_pw);
        user.setUsrEmail(usr_email);
        
      
		// 2. 기능 실행
        UsersDAO dao = new UsersDAO();
        dao.update(user);
		int cnt = dao.update(member);
		
		if(cnt>0) {
			System.out.println("회원정보 수정 성공");
			session.setAttribute("user", member); 
		}else {
			System.out.println("회원정보 수정 실패");
		}

	}

}
