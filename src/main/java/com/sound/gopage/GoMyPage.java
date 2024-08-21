package com.sound.gopage;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sound.controller.MyPageController;

@WebServlet("/GoMyPage1")
public class GoMyPage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		 // MyPageController 실행
        MyPageController myPageController = new MyPageController();
        myPageController.doGet(request, response);

        // MyPageController가 데이터를 세션에 저장했으므로, 이제 JSP로 포워드합니다.
        String url = "WEB-INF/views/Mypage.jsp";
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
	}

}