package com.sound.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.JsonNodeFactory;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.sound.DAO.Ai_AnalysisDAO;
import com.sound.entity.Ai_Analysis;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

@WebServlet("/AiController")
public class AiController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			request.setCharacterEncoding("UTF-8");
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");

			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode requestData = objectMapper.readTree(request.getReader());

			// Json 불러오기 검사
			JsonNode promptNode = requestData.get("prompt");
			if (promptNode == null) {
				throw new RuntimeException("prompt 필드가 요청 데이터에 존재하지 않습니다.");
			}

			String prompt = promptNode.asText();

			// ai 메서드 실행
			String[] aiData = ai_access(prompt);

			// user값 가져오기
			String userId = requestData.get("userId").asText();
			if (userId == null) {
				throw new RuntimeException("userId가 전송되지 않았습니다.");
			}

			Ai_Analysis ai_analysis = new Ai_Analysis();
			ai_analysis.setAiResult(aiData[0]);
			ai_analysis.setUserId(userId);
			ai_analysis.setInteraction(aiData[2]);

			// Ai_AnalysisDAO DB 저장하기
			Ai_AnalysisDAO dao = new Ai_AnalysisDAO();
			int cnt = dao.insert(ai_analysis);

			if (cnt > 0) {
				System.out.println("ai DB테이블 저장완료!!");
			} else {
				System.out.println("ai DB테이블 저장실패!!");
			}

			ObjectNode resultNode = objectMapper.createObjectNode();
			resultNode.put("ai_result", aiData[0]);
			resultNode.put("sugg_reason", aiData[1]);
			resultNode.put("inter_actions", aiData[2]);
			
			resultNode.put("user_id", userId);
			

			// ai 결과 파싱한 것
			String[] nutrition = new String[3];
			nutrition[0] = StringUtils.substringBetween(aiData[0], "1.", ",");
			nutrition[1] = StringUtils.substringBetween(aiData[0], "2.", ",");
			nutrition[2] = StringUtils.substringBetween(aiData[0], "3.", "식품");

			// 식품: 이후부터 1. 2. 3. 추출
			String foodData = StringUtils.substringAfter(aiData[0], "식품:");
			String[] food = new String[3];

			food[0] = StringUtils.substringBetween(foodData, "1.", ",");
			food[1] = StringUtils.substringBetween(foodData, "2.", ",");
			food[2] = StringUtils.substringAfter(foodData, "3.");

			// food 배열을 ArrayNode로 변환
			ArrayNode foodArray = JsonNodeFactory.instance.arrayNode();
			for (String foodItem : food) {
			    foodArray.add(foodItem);
			}

			// 영양제
			System.out.println(nutrition[0]);
			System.out.println(nutrition[1]);
			System.out.println(nutrition[2]);

			// 음식
			System.out.println(food[0]);
			System.out.println(food[1]);
			System.out.println(food[2]);

			String naverApiUrl = "http://localhost:8081/ST/NaverApiController?query=";

			// 네이버 결과 담을 배열
			JSONArray itemsArray = new JSONArray();
			JSONArray linksArray = new JSONArray();
			JSONArray imagesArray = new JSONArray();

			for (String nutritionItem : nutrition) {
				// 네이버 api 실행
				String naverResponse = callNaverApi(naverApiUrl + nutritionItem);
				JSONObject naverJson = new JSONObject(naverResponse);

				itemsArray.put(nutritionItem);
				linksArray.put(naverJson.getJSONArray("items").getJSONObject(0).getString("link"));
				imagesArray.put(naverJson.getJSONArray("items").getJSONObject(0).getString("image"));

			}

			// JSON 객체인 resultNode에 넣고
			resultNode.put("items", itemsArray.toString());
			resultNode.put("links", linksArray.toString());
			resultNode.put("images", imagesArray.toString());

			// JSON 객체인 resultNode에 foodArray를 추가
			resultNode.set("food", foodArray);  // set 메서드 사용

			// 클라이언트에 반환함
			response.getWriter().write(resultNode.toString());

		} catch (Exception e) {
			e.printStackTrace();
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
		}
	}

	// ai 실행 메서드
	public String[] ai_access(String prompt) {

		String API_KEY = "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";
		String API_URL = "https://api.anthropic.com/v1/messages";

		OkHttpClient client = new OkHttpClient();

		prompt = prompt + "\r\n" + " 그럴때 추천 영양성분 3가지와 식품 3가지를 ai_result: \r\n"
				+ "영양성분: 1., 2., 3. 식품: 1., 2., 3.  sugg_reason: 추천이유 \r\n"
				+ "으로 영양성분과 식품이 서로 상호작용으로 어떤 영향이 없는지를  inter_actions: \r\n"
				+ "으로 하고, 답변할때 JSON형식 앞에 영어든 한국어든 어떤 언급도 하지 말고 바로 다음의 JSON 형식으로 답변  {\"ai_result\": \" \", \"sugg_reason\": \" \", \"inter_actions\": \" \"}";

		JSONObject jsonBody = new JSONObject();
		jsonBody.put("model", "claude-3-5-sonnet-20240620");
		jsonBody.put("max_tokens", 1000);
		jsonBody.put("messages", new JSONObject[] { new JSONObject().put("role", "user").put("content", prompt) });
		jsonBody.put("temperature", 0.6);

		RequestBody body = RequestBody.create(jsonBody.toString(), MediaType.parse("application/json"));

		Request request = new Request.Builder().url(API_URL).addHeader("x-api-key", API_KEY)
				.addHeader("Content-Type", "application/json").addHeader("anthropic-version", "2023-06-01").post(body)
				.build();

		// ai 결과값 담을 배열
		String[] ai_data = new String[3];

		try (Response response = client.newCall(request).execute()) { // AutoCloseable 자원은 try-with-resources로 처리
			String responseBody = response.body().string();
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode root = objectMapper.readTree(responseBody);
			JsonNode contentNode = root.get("content");

			if (contentNode != null && contentNode.isArray() && contentNode.size() > 0) {
				String text = contentNode.get(0).get("text").asText();

				// 결과값 변수에 담기
				JsonNode rootText = objectMapper.readTree(text);

				ai_data[0] = rootText.get("ai_result").asText();
				ai_data[1] = rootText.get("sugg_reason").asText();
				ai_data[2] = rootText.get("inter_actions").asText();

				System.out.println("ai_result: " + ai_data[0]);
				System.out.println("sugg_reason: " + ai_data[1]);
				System.out.println("inter_actions: " + ai_data[2]);

			} else {
				System.out.println("content 필드가 존재하지 않거나 배열 형식이 아니거나 null 입니다.");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return ai_data;

	}

	// naverAPi 불러오기 메서드
	private String callNaverApi(String apiUrl) throws IOException {
		OkHttpClient client = new OkHttpClient();
		Request request = new Request.Builder().url(apiUrl).build();

		try (Response response = client.newCall(request).execute()) {

			if (!response.isSuccessful()) {
				throw new IOException("Unexpected code " + response);
			}
			return response.body().string();
		}
	}

}
