package com.sound.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class SearchNaverApiController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String NAVER_API_URL = "https://openapi.naver.com/v1/search/shop.json";
	private static final String CLIENT_ID = "g5siLwJYkgE_dazRmlS5";
	private static final String CLIENT_SECRET = "ik50JL1LnT";

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String query = request.getParameter("query");
		if (query != null && !query.isEmpty()) {
			OkHttpClient client = new OkHttpClient();

			Request apiRequest = new Request.Builder().url(NAVER_API_URL + "?query=" + query)
					.addHeader("X-Naver-Client-Id", CLIENT_ID).addHeader("X-Naver-Client-Secret", CLIENT_SECRET)
					.build();

			try (Response apiResponse = client.newCall(apiRequest).execute()) {
				String jsonData = apiResponse.body().string();
				response.setContentType("application/json");
				response.getWriter().write(jsonData);
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Query parameter is missing");
		}
	}
}