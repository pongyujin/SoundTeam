package com.sound.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONException;
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

			JsonNode promptNode = requestData.get("prompt");
			if (promptNode == null) {
				throw new RuntimeException("prompt 필드가 요청 데이터에 존재하지 않습니다.");
			}

			String prompt = promptNode.asText();
			int retries = 3;

			// ai 실행 메서드
			String[] aiData = null;
			for (int i = 0; i < retries; i++) {
				aiData = ai_access(prompt);
				if (aiData != null && aiData[0] != null) {
					break;
				}
				Thread.sleep(2000);
			}
			if (aiData == null || aiData[0] == null) {
				throw new RuntimeException("AI 응답이 없습니다.");
			}

			System.out.println("ai응답결과: " + aiData);
			// userid값 가져오기
			String userId = requestData.get("userId").asText();
			System.out.println(userId);
			if (userId == null) {
				System.out.println(userId);
				throw new RuntimeException("userId가 전송되지 않았습니다.");
			}

			// 4개의 배열 선언
			String[] nutritionNames = new String[3]; // 영양제 이름 배열
			String[] foodNames = new String[3]; // 음식 이름 배열
			String[] nutritionReasons = new String[3]; // 영양제 추천 이유 배열
			String[] foodReasons = new String[3]; // 음식 추천 이유 배열

			// 1. 영양제 이름 파싱
			nutritionNames[0] = StringUtils.defaultString(StringUtils.substringBetween(aiData[0], "1. ", " 2."), "").trim();
			nutritionNames[1] = StringUtils.defaultString(StringUtils.substringBetween(aiData[0], "2. ", " 3."), "").trim();
			nutritionNames[2] = StringUtils.defaultString(StringUtils.substringBefore(StringUtils.substringAfter(aiData[0], "3. "), "식품"), "").trim();

			
			String cutfood= StringUtils.substringAfter(aiData[0], "식품:");
			// 2. 음식 이름 파싱
			String foodGroup1 = StringUtils.defaultString(StringUtils.substringBetween(cutfood, "1. ", " 2."), "").trim();
			String foodGroup2 = StringUtils.defaultString(StringUtils.substringBetween(cutfood, "2. ", " 3."), "").trim();
			String foodGroup3 = StringUtils.defaultString(StringUtils.substringAfter(cutfood, "3. "), "").trim();

			foodNames[0] = "1. " + foodGroup1; 
			foodNames[1] = "2. " + foodGroup2; 
			foodNames[2] = "3. " + foodGroup3; 

			// 3. 영양제 추천 이유 파싱
			nutritionReasons[0] = StringUtils.defaultString(StringUtils.substringBetween(aiData[1], "1. ", " 2."), "").trim();
			nutritionReasons[1] = StringUtils.defaultString(StringUtils.substringBetween(aiData[1], "2. ", " 3."), "").trim();
			nutritionReasons[2] = StringUtils.defaultString(StringUtils.substringBefore(StringUtils.substringAfter(aiData[1], "3. "), "식품:"), "").trim();

			String cutfood2= StringUtils.substringAfter(aiData[1], "식품:");
			// 4. 음식 추천 이유 파싱
			String foodReason1 = StringUtils.defaultString(StringUtils.substringBetween(cutfood2, "1. ", " 2."), "").trim();
			String foodReason2 = StringUtils.defaultString(StringUtils.substringBetween(cutfood2, "2. ", " 3."), "").trim();
			String foodReason3 = StringUtils.defaultString(StringUtils.substringAfter(cutfood2, "3."), "").trim();

			foodReasons[0] = foodReason1;  
			foodReasons[1] = foodReason2;  
			foodReasons[2] = foodReason3; 
			
			// 상호작용 파싱
			String interaction = aiData[2].trim();


			// 파싱 결과 출력
			System.out.println();
			System.out.println("파싱 결과");
			System.out.println("Nutrition Names: " + Arrays.toString(nutritionNames));
			System.out.println("Food Names: " + Arrays.toString(foodNames));
			System.out.println("Nutrition Reasons: " + Arrays.toString(nutritionReasons));
			System.out.println("Food Reasons: " + Arrays.toString(foodReasons));
			System.out.println("Interaction: " + interaction);

			// 네이버 API 시작
			String naverApiUrl = "http://localhost:8081/ST/NaverApiController?query=";

			JSONArray itemsArray = new JSONArray();
			JSONArray linksArray = new JSONArray();
			JSONArray imagesArray = new JSONArray();
			JSONArray titlesArray = new JSONArray();

			for (String nutritionItem : nutritionNames) {
				// 네이버 API 호출
				System.out.println("네이버 API에 요청할 값: " + nutritionItem);
				String naverResponse = null;

				try {
					naverResponse = callNaverApi(naverApiUrl + URLEncoder.encode(nutritionItem, "UTF-8"));

				} catch (IOException e) {
					System.out.println("네이버 API 호출 중 오류 발생: " + nutritionItem);
					e.printStackTrace();
					continue;
				}

				JSONObject naverJson = null;
				try {
					naverJson = new JSONObject(naverResponse);
				} catch (JSONException e) {
					System.out.println("네이버 API 응답 파싱 중 오류 발생: " + nutritionItem);
					e.printStackTrace();
					continue;
				}

				// 네이버 API 응답에서 링크와 이미지를 추출
				String productUrl = null;
				String productImage = null;
				String productTitle = null;

				try {
					JSONArray items = naverJson.getJSONArray("items");
					if (items.length() > 0) {
						JSONObject firstItem = items.getJSONObject(0);

						// 링크와 이미지에서 URL만 추출
						productUrl = firstItem.optString("link", "").trim();
						productImage = firstItem.optString("image", "").trim();

						// HTML 태그 제거 및 한글 디코딩
						productTitle = firstItem.optString("title", "").trim().replaceAll("<[^>]*>", "");
						productTitle = org.apache.commons.text.StringEscapeUtils.unescapeHtml4(productTitle);

						// URL과 이미지가 유효한지 검사
						if (!productUrl.isEmpty() && !productImage.isEmpty()) {
							itemsArray.put(nutritionItem);
							linksArray.put(productUrl);
							imagesArray.put(productImage);
							titlesArray.put(productTitle);

							System.out
									.println("추출된 데이터 - NutritionItem: " + nutritionItem + ", ProductUrl: " + productUrl
											+ ", ProductImage: " + productImage + ", ProductTitle: " + productTitle);
						} else {
							System.out.println("유효한 productUrl 또는 productImage가 없습니다: " + nutritionItem);
						}
					} else {
						System.out.println("네이버 API 응답에 items가 없습니다: " + nutritionItem);
					}
				} catch (JSONException e) {
					System.out.println("네이버 API 응답에서 데이터 추출 중 오류 발생: " + nutritionItem);
					e.printStackTrace();
				}
			}

			// 값있는지 확인
			for (Object t : itemsArray) {
				System.out.println("itemsArray" + t);
			}
			for (Object t : linksArray) {
				System.out.println("linksArray" + t);
			}
			for (Object t : imagesArray) {
				System.out.println("imagesArray" + t);
			}
			for (Object t : titlesArray) {
				System.out.println("titlesArray" + t);
			}

			// ai DB 저장하기
			Ai_recommendation aiDB = new Ai_recommendation();
			Ai_recommendationDAO aidao = new Ai_recommendationDAO();

			aiDB.setSuggReason(aiData[1]);
			aiDB.setNutrId(String.join(", ", nutritionNames)); // 영양 성분을 콤마로 연결하여 저장
			aiDB.setFoodId(String.join(", ", foodNames)); // 식품을 콤마로 연결하여 저장
			aiDB.setInteraction(interaction);
			aiDB.setUsrId(userId);

			int suggId = aidao.insertAi(aiDB); // 삽입 후 생성된 SUGG_ID 반환

			if (suggId > 0) {
				System.out.println("ai DB  저장 성공");
			} else {
				System.out.println("ai DB 저장 실패.");
			}

			ProductsDAO productsDAO = new ProductsDAO();

			for (int i = 0; i < 3; i++) {

				Products product = new Products();
				product.setProductUrl(linksArray.getString(i));
				product.setProductImage(imagesArray.getString(i));
				product.setSuggId(suggId); // AI_RECOMMENDATION의 SUGG_ID와 매칭

				int cnt = productsDAO.insertProducts(product);
				if (cnt > 0) {
					System.out.println("Product DB 저장 성공");
				} else {
					System.out.println("Product DB 저장 실패.");
				}
			}

			// JSON 객체인 resultNode에 데이터 저장
			ObjectNode resultNode = objectMapper.createObjectNode();
			resultNode.put("user_id", userId);
			resultNode.put("interaction_parsed", interaction);

			// 영양 성분 저장
			ArrayNode nutritionArray = resultNode.putArray("nutritionNames");
			for (String nutr : nutritionNames) {
				nutritionArray.add(nutr);
			}

			// 식품 데이터 저장
			ArrayNode foodArray = resultNode.putArray("foodNames");
			for (String food : foodNames) {
				foodArray.add(food);
			}

			// 추천 이유 저장
			ArrayNode reasonArray = resultNode.putArray("nutritionReasons");
			for (String reason : nutritionReasons) {
				reasonArray.add(reason);
			}

			ArrayNode foodReasonArray = resultNode.putArray("foodReasons");
			for (String foodReason : foodReasons) {
				foodReasonArray.add(foodReason);
			}

			// 네이버 API 결과 저장
			ArrayNode itemsArrayNode = resultNode.putArray("items");
			ArrayNode linksArrayNode = resultNode.putArray("links");
			ArrayNode imagesArrayNode = resultNode.putArray("images");

			for (int i = 0; i < itemsArray.length(); i++) {
				itemsArrayNode.add(itemsArray.getString(i));
				linksArrayNode.add(linksArray.getString(i));
				imagesArrayNode.add(imagesArray.getString(i));
			}

			// 세션에 resultNode 저장
			HttpSession session = request.getSession();
			session.setAttribute("resultNode", resultNode);

			// 클라이언트에 JSON 반환
			response.setContentType("application/json;charset=UTF-8");
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

		// OkHttpClient를 생성할 때 타임아웃을 설정합니다.
		OkHttpClient client = new OkHttpClient.Builder().connectTimeout(30, TimeUnit.SECONDS)
				.writeTimeout(30, TimeUnit.SECONDS).readTimeout(30, TimeUnit.SECONDS).build();

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

			System.out.println("AI 응답: " + responseBody); // 원본 응답 출력

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
