package com.sound.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import okhttp3.HttpUrl;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

@WebServlet("/NaverApiController")
public class NaverApiController extends HttpServlet {
   private static final long serialVersionUID = 1L;

   protected void service(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {

      String query = request.getParameter("query");
      if (query == null || query.isEmpty()) {
         response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
         response.getWriter().write("{\"error\":\"Query parameter is missing\"}");
         return;
      }

      String CLIENT_ID = "g5siLwJYkgE_dazRmlS5";
      String CLIENT_SECRET = "ik50JL1LnT";
      String API_URL = "https://openapi.naver.com/v1/search/shop.json";

      OkHttpClient client = new OkHttpClient();

      // HTTP 요청 생성
      HttpUrl.Builder urlBuilder = HttpUrl.parse(API_URL).newBuilder();
      urlBuilder.addQueryParameter("query", query);
      urlBuilder.addQueryParameter("display", "5"); // 검색 결과 개수
      urlBuilder.addQueryParameter("start", "1"); // 시작 위치

      Request naverRequest = new Request.Builder().url(urlBuilder.build())
            .addHeader("X-Naver-Client-Id", CLIENT_ID)
            .addHeader("X-Naver-Client-Secret", CLIENT_SECRET).build();

      try (Response naverResponse = client.newCall(naverRequest).execute()) {
         if (!naverResponse.isSuccessful()) {
            throw new IOException("Unexpected code " + naverResponse);
         }

         // JSON 응답 파싱 및 클라이언트에 전송
         String json = naverResponse.body().string();
         response.setContentType("application/json");
         response.getWriter().write(json);
      } catch (IOException e) {
         e.printStackTrace();
         response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
         response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
      }
   }
}
