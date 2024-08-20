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
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.sound.DAO.Ai_recommendationDAO;
import com.sound.DAO.ProductsDAO;
import com.sound.entity.Ai_recommendation;
import com.sound.entity.Products;

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

			// ai 실행
			String[] aiData = ai_access(prompt);

			// user값 가져오기
			String userId = requestData.get("userId").asText();
			if (userId == null) {
				throw new RuntimeException("userId가 전송되지 않았습니다.");
			}

			// 파싱 과정 시작
			// 영양 성분 파싱
			String[] nutrition = new String[3];
			nutrition[0] = StringUtils.defaultString(StringUtils.substringBetween(aiData[0], "1.", ","), "").trim();
			nutrition[1] = StringUtils.defaultString(StringUtils.substringBetween(aiData[0], "2.", ","), "").trim();
			nutrition[2] = StringUtils.defaultString(StringUtils.substringBetween(aiData[0], "3.", "식품"), "").trim();

			// 식품 파싱 - 총 6개의 항목으로 나누기
			String[] foods = new String[6];
			String foodData = StringUtils.defaultString(StringUtils.substringAfter(aiData[0], "식품:"), "");

			foods[0] = StringUtils.defaultString(StringUtils.substringBetween(foodData, "1. ", ","), "").trim();
			foods[1] = StringUtils.defaultString(StringUtils.substringBetween(foodData, ",", "2."), "").trim();
			foods[2] = StringUtils.defaultString(StringUtils.substringBetween(foodData, "2. ", ","), "").trim();
			foods[3] = StringUtils.defaultString(StringUtils.substringBetween(foodData, ",", "3."), "").trim();
			foods[4] = StringUtils.defaultString(StringUtils.substringBetween(foodData, "3. ", ","), "").trim();
			foods[5] = StringUtils.defaultString(StringUtils.substringAfterLast(foodData, ","), "").trim();

			// 추천 이유 파싱
			String[] reasons = new String[3];
			reasons[0] = StringUtils.defaultString(StringUtils.substringBetween(aiData[1], "1. ", " 2."), "").trim();
			reasons[1] = StringUtils.defaultString(StringUtils.substringBetween(aiData[1], "2. ", " 3."), "").trim();
			reasons[2] = StringUtils.defaultString(StringUtils.substringAfter(aiData[1], "3."), "").trim();

			// 상호작용 파싱
			String interaction = aiData[2];

			// 파싱값 없을경우
			if (nutrition[0].isEmpty() || nutrition[1].isEmpty() || nutrition[2].isEmpty()) {
				System.out.println("영양 성분 파싱에 실패했습니다: " + aiData[0]);
				// 예외를 던지거나 다른 처리를 할 수 있습니다.
			}

			if (foods[0].isEmpty() || foods[1].isEmpty() || foods[2].isEmpty() || foods[3].isEmpty()
					|| foods[4].isEmpty() || foods[5].isEmpty()) {
				System.out.println("식품 파싱에 실패했습니다: " + aiData[0]);
				// 예외를 던지거나 다른 처리를 할 수 있습니다.
			}

			// 네이버 API 시작
			// 네이버 API 연동을 위한 검색어 조합
			String naverApiUrl = "http://localhost:8081/ST/NaverApiController?query=";

			// 네이버 결과 담을 배열
			JSONArray itemsArray = new JSONArray();
			JSONArray linksArray = new JSONArray();
			JSONArray imagesArray = new JSONArray();

			for (String nutritionItem : nutrition) {
				// 네이버 API 실행
				String naverResponse = callNaverApi(naverApiUrl + nutritionItem);
				JSONObject naverJson = new JSONObject(naverResponse);

				itemsArray.put(nutritionItem);
				linksArray.put(naverJson.getJSONArray("items").getJSONObject(0).getString("link"));
				imagesArray.put(naverJson.getJSONArray("items").getJSONObject(0).getString("image"));
			}

			// JSON 객체인 resultNode에 데이터 저장
			ObjectNode resultNode = objectMapper.createObjectNode();
			resultNode.put("ai_result", aiData[0]);
			resultNode.put("sugg_reason", aiData[1]);
			resultNode.put("inter_actions", aiData[2]);
			resultNode.put("user_id", userId);
			resultNode.put("items", itemsArray.toString());
			resultNode.put("links", linksArray.toString());
			resultNode.put("images", imagesArray.toString());

			// 파싱된 데이터 저장
			// 영양 성분 저장
			ArrayNode nutritionArray = resultNode.putArray("nutrition");
			for (String nutr : nutrition) {
				nutritionArray.add(nutr);
			}

			// 식품 데이터 저장
			ArrayNode foodArray = resultNode.putArray("foods");
			for (String food : foods) {
				foodArray.add(food);
			}

			// 추천 이유 저장
			ArrayNode reasonArray = resultNode.putArray("reasons");
			for (String reason : reasons) {
				reasonArray.add(reason);
			}

			// 상호작용 저장
			resultNode.put("interaction_parsed", interaction);

			// ai DB 저장하기
			Ai_recommendation aiDB = new Ai_recommendation();
			Ai_recommendationDAO aidao = new Ai_recommendationDAO();

			aiDB.setSuggReason(aiData[1]);
			aiDB.setNutrId(String.join(", ", nutrition)); // 영양 성분을 콤마로 연결하여 저장
			aiDB.setFoodId(String.join(", ", foods)); // 식품을 콤마로 연결하여 저장
			aiDB.setInteraction(interaction);
			aiDB.setUsrId(userId);

			int suggId = aidao.insertAi(aiDB);

			if (suggId > 0) {
				System.out.println("aiDB 저장 성공했슴다!!!!");
				System.out.println("suggId :" + suggId);
			} else {
				System.out.println("aiDB 저장 실패..");
				System.out.println("suggId :" + suggId);
			}

			// 상품 DB 저장하기
			Products products = new Products();
			ProductsDAO productsdao = new ProductsDAO();

			for (int i = 0; i < nutrition.length; i++) {
				Products product = new Products();
				product.setProductUrl(linksArray.getString(i)); // 링크를 가져와 설정
				product.setProductImage(imagesArray.getString(i)); // 이미지를 가져와 설정
				product.setSuggId(suggId); // 추천 식별자를 설정
				int cnt = productsdao.insertProducts(products); // 데이터베이스에 삽입

				if (cnt > 0) {
					System.out.println("Product DB 저장성공");
				} else {
					System.out.println("Product DB 실패....");
				}
			}

			// 클라이언트에 반환
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
				+ "영양성분: 1. 2. 3. 식품: 1. 2. 3. 으로 하되 식품 각 번호에 3개씩, 추천이유를 sugg_reason: 영양성분: 1. 2. 3. 식품: 1. 2. 3. \r\n"
				+ "으로 하되 , 영양성분과 식품이 서로 상호작용으로 어떤 영향이 없는지를  inter_actions: \r\n"
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
			
			System.out.println("AI 응답: " + responseBody);  // 원본 응답 출력
			
			ObjectMapper objectMapper = new ObjectMapper();
			JsonNode root = objectMapper.readTree(responseBody);
			JsonNode contentNode = root.get("content");

			if (contentNode != null && contentNode.isArray() && contentNode.size() > 0) {
				String text = contentNode.get(0).get("text").asText();

				// 결과값 변수에 담기
				JsonNode rootText = objectMapper.readTree(text);

				ai_data[0] = rootText.has("ai_result") ? rootText.get("ai_result").asText() : null;
				ai_data[1] = rootText.has("sugg_reason") ? rootText.get("sugg_reason").asText() : null;
				ai_data[2] = rootText.has("inter_actions") ? rootText.get("inter_actions").asText() : null;

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
