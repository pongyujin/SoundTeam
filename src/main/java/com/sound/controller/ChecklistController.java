package com.sound.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.exc.MismatchedInputException;
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
		BufferedReader reader = request.getReader();
		StringBuilder requestBody = new StringBuilder();
		String line;
		while ((line = reader.readLine()) != null) {
			requestBody.append(line);
		}

		// 요청 본문을 출력해 디버그

		System.out.println("Request Body: " + requestBody.toString());

		// JSON 데이터 파싱
		ObjectMapper objectMapper = new ObjectMapper();
		JsonNode surveyData = null;

		try {
			if (requestBody.toString().trim().isEmpty()) {
				System.out.println("Request Body Before Parsing: " + requestBody.toString());

				throw new IOException("Request body is empty");
			}
			surveyData = objectMapper.readTree(requestBody.toString());
		} catch (JsonParseException | JsonMappingException e) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			response.getWriter().write("{\"error\":\"Invalid JSON format\"}");
			return;
		} catch (IOException e) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
			return;
		}

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
				promptBuilder.append("id").append(responseText);
			} else {
				promptBuilder.append("문항 번호: ").append(id).append(", 응답: ").append(responseText).append("\n");
			}
		}

		// AiController로 데이터 전달
		String prompt = promptBuilder.toString();
		String aiResponse = sendToAiController(prompt, userId);

		// aiResponse가 null이거나 비어있는지 확인
		if (aiResponse == null || aiResponse.isEmpty()) {
			System.out.println("aiResponse가 null이거나 비어있음");
			throw new RuntimeException("AI Controller에서 유효한 응답을 받지 못했습니다.");
		}

		try {
			JsonNode aiResponseData = objectMapper.readTree(aiResponse);
			System.out.println("aiResponseData : " + aiResponseData.toString());

			// Naver API 결과들을 설정합니다.
			List<String> items = new ArrayList<>();
			List<String> links = new ArrayList<>();
			List<String> images = new ArrayList<>();

			// JSON 데이터에서 필요한 필드 추출
			List<String> nutritionNames = new ArrayList<>();
			List<String> nutritionReasons = new ArrayList<>();
			List<String> foodReasons = new ArrayList<>();
			List<String> foodList = new ArrayList<>();

			// JSON 데이터 중 문제가 있을 수 있는 부분을 검증하고 처리
			if (aiResponseData.has("items")) {
				JsonNode itemsNode = aiResponseData.get("items");
				for (JsonNode item : itemsNode) {
					String cleanItem = item.asText().replace("\n", " ").trim();
					items.add(cleanItem);
					System.out.println("Processed item: " + cleanItem);
				}
			}

			if (aiResponseData.has("links")) {
				JsonNode linksNode = aiResponseData.get("links");
				for (JsonNode link : linksNode) {
					String cleanLink = link.asText().replace("\n", " ").trim();
					links.add(cleanLink);
					System.out.println("Processed link: " + cleanLink);
				}
			}

			if (aiResponseData.has("images")) {
				JsonNode imagesNode = aiResponseData.get("images");
				for (JsonNode image : imagesNode) {
					String cleanImage = image.asText().replace("\n", " ").trim();
					images.add(cleanImage);
					System.out.println("Processed image: " + cleanImage);
				}
			}

			if (aiResponseData.has("nutritionNames")) {
				JsonNode nutritionNamesNode = aiResponseData.get("nutritionNames");
				for (JsonNode nutritionName : nutritionNamesNode) {
					String cleanNutritionName = nutritionName.asText().replace("\n", " ").trim();
					nutritionNames.add(cleanNutritionName);
					System.out.println("Processed nutrition name: " + cleanNutritionName);
				}
			}

			if (aiResponseData.has("nutritionReasons")) {
				JsonNode nutritionReasonsNode = aiResponseData.get("nutritionReasons");
				for (JsonNode nutritionReason : nutritionReasonsNode) {
					String cleanNutritionReason = nutritionReason.asText().replace("\n", " ").trim();
					nutritionReasons.add(cleanNutritionReason);
					System.out.println("Processed nutrition reason: " + cleanNutritionReason);
				}
			}

			if (aiResponseData.has("foodReasons")) {
				JsonNode foodReasonsNode = aiResponseData.get("foodReasons");
				for (JsonNode foodReason : foodReasonsNode) {
					String cleanFoodReason = foodReason.asText().replace("\n", " ").trim();
					foodReasons.add(cleanFoodReason);
					System.out.println("Processed food reason: " + cleanFoodReason);
				}
			}

			if (aiResponseData.has("foodNames")) {
				JsonNode foodNamesNode = aiResponseData.get("foodNames");
				for (JsonNode foodName : foodNamesNode) {
					String cleanFoodName = foodName.asText().replace("\n", " ").trim();
					foodList.add(cleanFoodName);
					System.out.println("Processed food name: " + cleanFoodName);
				}
			}

			String interactionParsed = aiResponseData.get("interaction_parsed").asText();
			// 세션에 데이터 저장
			session = request.getSession();
			session.setAttribute("resultNode", aiResponseData.toString());

			session.setAttribute("items", items);
			session.setAttribute("links", links);
			session.setAttribute("images", images);
			session.setAttribute("interaction_parsed", interactionParsed);

			session.setAttribute("nutritionNames", nutritionNames); // 영양제 이름
			session.setAttribute("nutritionReasons", nutritionReasons); // 영양제 추천 ㅣㅇ유
			session.setAttribute("foodReasons", foodReasons); // 음식 추천 이유
			session.setAttribute("food", foodList); // 음식 이름

			// user.id 가져가기
			session.setAttribute("user_id", userId);

			// 이후 클라이언트에서 페이지 리디렉션 처리
			response.getWriter().write("{\"status\":\"success\"}");

		} catch (MismatchedInputException e) {
			System.out.println("JSON 파싱 오류: 입력 데이터가 비어있습니다.");
			e.printStackTrace();
		} catch (IOException e) {
			System.out.println("JSON 파싱 중 IOException 발생");
			e.printStackTrace();
		}
	}

	private String sendToAiController(String prompt, String userId) throws IOException {
		String aiControllerUrl = "http://localhost:8081/ST/AiController"; // AiController의 URL
		OkHttpClient client = new OkHttpClient.Builder().connectTimeout(30, TimeUnit.SECONDS) // 연결 타임아웃 설정
				.writeTimeout(30, TimeUnit.SECONDS) // 쓰기 타임아웃 설정
				.readTimeout(30, TimeUnit.SECONDS) // 읽기 타임아웃 설정
				.build();

		// JSON 생성
		ObjectMapper objectMapper = new ObjectMapper();
		JsonNode jsonBody = objectMapper.createObjectNode().put("prompt", prompt).put("userId", userId);

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