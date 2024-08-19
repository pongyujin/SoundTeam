package com.sound.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.sound.DAO.User_checkDAO;
import com.sound.entity.User_check;
import com.sound.entity.Users;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@WebServlet("/ChecklistController")
public class ChecklistController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// POST 요청으로 전달된 JSON 데이터를 받아오기
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		// JSON 데이터 파싱
		ObjectMapper objectMapper = new ObjectMapper();
		JsonNode surveyData = objectMapper.readTree(request.getReader());

		for (JsonNode node : surveyData) {
			System.out.println("Processing JSON Node: " + node.toString());
		}

		// 현재 사용자 아이디를 세션에서 가져오기
		HttpSession session = request.getSession();
		Users user = (Users) session.getAttribute("user");
		String userId = user.getUsrId();

		User_checkDAO user_checkDAO = new User_checkDAO();

		int checkId = user_checkDAO.getNextCheckId();

		for (JsonNode node : surveyData) {
			int listIdent = node.get("id").asInt();
			String responseText = node.get("response").asText();

			User_check userCheck = new User_check();
			userCheck.setCheckId(checkId);
			userCheck.setListIdent(listIdent);
			userCheck.setItemResponse(responseText);
			userCheck.setUsrId(userId);

			int cnt = user_checkDAO.insertUserCheck(userCheck);

			if (cnt > 0) {
				System.out.println(userCheck.getListIdent() + "저장완료");
			} else {
				System.out.println(userCheck.getListIdent() + "저장실패");

			}
		}

		// surveyData에서 필요한 데이터를 추출하고 로직을 수행
		StringBuilder promptBuilder = new StringBuilder();
		for (JsonNode node : surveyData) {
			int id = node.get("id").asInt();
			String responseText = node.get("response").asText();

			if (id == 0) {
				// 아무런 추가 조치를 하지 않고 responseText를 그대로 사용하거나, 다른 형식으로 추가
				promptBuilder.append("id").append(responseText);
			} else {
				// 기본 처리
				promptBuilder.append("문항 번호: ").append(id).append(", 응답: ").append(responseText).append("\n");
			}

		}

		// AiController로 데이터 전달
		String prompt = promptBuilder.toString();
		String aiResponse = sendToAiController(prompt, userId);

		// JSON 응답을 ObjectMapper로 다시 파싱해서 필요한 데이터 추출
		JsonNode aiResponseData = objectMapper.readTree(aiResponse);
		// Naver API 결과들을 설정합니다.
		JsonNode itemsNode = aiResponseData.get("items");
		JsonNode linksNode = aiResponseData.get("links");
		JsonNode imagesNode = aiResponseData.get("images");
		
		// JSON 배열을 Java List로 변환하여 JSP로 전달할 수 있습니다.
		List<String> items = new ArrayList<>();
		List<String> links = new ArrayList<>();
		List<String> images = new ArrayList<>();

		for (int i = 0; i < itemsNode.size(); i++) {
			items.add(itemsNode.get(i).asText());
			links.add(linksNode.get(i).asText());
			images.add(imagesNode.get(i).asText());
		}

		
		// 필요한 데이터들을 JSP로 전달하기 위해 Request 객체에 속성으로 설정
		request.setAttribute("ai_result", aiResponseData.get("ai_result").asText());
		request.setAttribute("sugg_reason", aiResponseData.get("sugg_reason").asText());
		request.setAttribute("inter_actions", aiResponseData.get("inter_actions").asText());
		
		request.setAttribute("items", items);
		request.setAttribute("links", links);
		request.setAttribute("images", images);
		
		// JSP 페이지로 포워딩
		RequestDispatcher dispatcher = request.getRequestDispatcher("GoRecommendPage");
		dispatcher.forward(request, response);
	}

	private String sendToAiController(String prompt, String userId) throws IOException {

		String aiControllerUrl = "http://localhost:8081/ST/AiController"; // AiController의 URL
		OkHttpClient client = new OkHttpClient();

		// JSON 생성
		ObjectMapper objectMapper = new ObjectMapper();
		ObjectNode jsonBody = objectMapper.createObjectNode();
		jsonBody.put("prompt", prompt); // JSON 객체에 "prompt" 필드를 추가
		jsonBody.put("userId", userId); // userId도 함께 전송

		System.out.println("Sending JSON to AI Controller: " + jsonBody.toString()); // 로그로 출력

		RequestBody body = RequestBody.create(jsonBody.toString(), MediaType.parse("application/json"));

		Request request = new Request.Builder().url(aiControllerUrl).post(body)
				.addHeader("Content-Type", "application/json").build();

		try (Response response = client.newCall(request).execute()) {
			if (!response.isSuccessful()) {
				throw new IOException("Unexpected code " + response);
			}
			return response.body().string();
		}
	}
}
