package com.sound.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sound.DAO.Ai_recommendationDAO;
import com.sound.DAO.ProductsDAO;
import com.sound.entity.Ai_recommendation;
import com.sound.entity.Products;
import com.sound.entity.Users;

public class MyPageController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) {

		// userId 세션 값 가져오기
		HttpSession session = request.getSession();
		Users user = (Users) session.getAttribute("user");

		String userId = null;
		if (user != null) {
			userId = user.getUsrId(); // Users 객체에서 이름 가져오기
			System.out.println("User Name: " + userId);
		} else {
			System.out.println("User not found in session.");
		}
		Ai_recommendationDAO dao = new Ai_recommendationDAO();

		// dao select문 실행
		List<Ai_recommendation> recommendations = dao.getAi(userId);
		System.out.println("controllor 값  :" + recommendations);

		// 응답을 보내지 않고 세션에 데이터만 저장
		request.getSession().setAttribute("recommendations", recommendations);

		request.getSession().setAttribute("user", user);

	}

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// mypage에서 선택한
		// URL 파라미터로 전달된 suggId와 userId를 가져옵니다.
		int suggId = Integer.parseInt(request.getParameter("suggId"));
		String userId = request.getParameter("userId");

		System.out.println("서비스 메서드"+ suggId);
		System.out.println("서비스 메서드"+ userId);
		
		Ai_recommendation ai = new Ai_recommendation();
		ai.setSuggId(suggId);
		ai.setUsrId(userId);
		
		Ai_recommendationDAO aiDAO = new Ai_recommendationDAO();
		List<Ai_recommendation> ai_result = aiDAO.getAiRecommendation(ai);
		
		System.out.println("ai 서비스 select");
		for(Ai_recommendation a : ai_result) {
			System.out.println(a);
		}
		
		ProductsDAO productsDAO = new ProductsDAO();
		List<Products> products_result = productsDAO.getProducts(ai);
		
		System.out.println();
		System.out.println("상품 DB서비스 select");
		for(Products a : products_result) {
			System.out.println(a);
		}
		
		// User ID를 세션에 저장
	    HttpSession session = request.getSession();
	    session.setAttribute("userId", userId);
	    
		// 결과를 request에 추가
	    request.setAttribute("aiResult", ai_result);
	    request.setAttribute("productsResult", products_result);
	    
		String url = "WEB-INF/views/MyPagerecommend.jsp";
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
		
	}

}
