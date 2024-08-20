package com.sound.controller;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class ApiTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// OkHttpClient 인스턴스 생성
		OkHttpClient client = new OkHttpClient.Builder().connectTimeout(30, TimeUnit.SECONDS)
				.writeTimeout(30, TimeUnit.SECONDS).readTimeout(30, TimeUnit.SECONDS).build();

		// 서비스 키와 URL 설정
		String serviceKey = "18693a2055a94d359d60"; // 여기에 실제 서비스 키를 입력하세요
		String serviceId = "C003";
		String format = "xml";
		String startIdx = "1";
		String endIdx = "5";

		// API 요청을 보낼 URL 설정
		String url = "http://openapi.foodsafetykorea.go.kr/api/" + serviceKey + "/" + serviceId + "/" + format + "/"
				+ startIdx + "/" + endIdx;

		// Request 객체 생성
		Request apiRequest = new Request.Builder().url(url).build();

		// 요청을 보내고 응답을 받기
		try (Response apiResponse = client.newCall(apiRequest).execute()) {
			if (apiResponse.isSuccessful()) {
				// 응답 본문을 브라우저에 출력
				response.setContentType("text/plain");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(apiResponse.body().string());
			} else {
				// 응답 실패 시 메시지 출력
				response.getWriter().write("Request failed: " + apiResponse.code());
			}
		} catch (IOException e) {
			e.printStackTrace();
			response.getWriter().write("Error occurred: " + e.getMessage());
		}
	}

}
