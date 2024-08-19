package com.sound.controller;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

public class SearchController extends HttpServlet {

	private static final long serialVersionUID = 1L; // serialVersionUID 추가

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String[] vitamins = { "비타민 C", "마그네슘", "밀크씨슬", "비타민 A", "멀티비타민&미네랄", "아연", "루테인", "테아닌", "오메가3", "비타민 D",
				"코엔자임Q10", "유산균", "비타민 E", "칼슘", "철분", "비타민 B", "비오틴", "엽산", "셀레늄", "콜라겐", "인삼", "비타민 K", "커큐민",
				"멜라토닌" };

		// OkHttpClient를 사용하여 네이버 검색 API 호출
		OkHttpClient client = new OkHttpClient();

		Map<String, String> vitaminImages = new HashMap<>();
		
		String DEFAULT_IMAGE = "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMjEyMThfODIg%2FMDAxNjcxMzM5NjUyODg4.OEeNgvtyBxXz2skpWjwcN95wWUqTmLbEPdGFz83wCBsg.Y2aapLHlU7jttip7kEF109Z22Xru4p1M2x9VuNicc2Qg.PNG.themeccagym%2FKakaoTalk_Snapshot_20221218_133423.png&type=sc960_832";

		// 네이버 API 또는 다른 소스에서 이미지 URL 가져오기
		for (String vitamin : vitamins) {
			String imageUrl = searchNaverForImage(vitamin, client);

			// URL의 유효성을 검사하고, 유효하지 않은 경우 기본 이미지로 대체
			if (isValidImageUrl(imageUrl)) {
				vitaminImages.put(vitamin, imageUrl);
			} else {
				vitaminImages.put(vitamin, DEFAULT_IMAGE);
			}
		}

		// 세션에 vitaminImages 저장
		HttpSession session = request.getSession();
		session.setAttribute("vitaminImages", vitaminImages);

		// JSP 페이지로 포워딩
		request.getRequestDispatcher("WEB-INF/views/Search.jsp").forward(request, response);
	}

	// 유효한 url인지 확인하는 메서드
	private boolean isValidImageUrl(String imageUrl) {
		if (imageUrl == null || imageUrl.isEmpty()) {
			return false;
		}
		try {
			URL url = new URL(imageUrl);
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("HEAD");
			int responseCode = connection.getResponseCode();
			return (responseCode >= 200 && responseCode < 400); // 2xx 및 3xx 응답 코드만 허용
		} catch (IOException e) {
			return false;
		}
	}

	private String searchNaverForImage(String query, OkHttpClient client) {
		String clientId = "g5siLwJYkgE_dazRmlS5"; // 네이버 API 클라이언트 ID
		String clientSecret = "ik50JL1LnT"; // 네이버 API 클라이언트 시크릿

		String apiUrl = "https://openapi.naver.com/v1/search/image?query=" + query;

		Request request = new Request.Builder().url(apiUrl).addHeader("X-Naver-Client-Id", clientId)
				.addHeader("X-Naver-Client-Secret", clientSecret).build();

		try (Response response = client.newCall(request).execute()) {

			if (response.isSuccessful()) {

				String jsonResponse = response.body().string();
				JSONObject jsonObject = new JSONObject(jsonResponse);

				JSONArray items = jsonObject.getJSONArray("items");
				if (items.length() > 0) {
					return items.getJSONObject(0).getString("link"); // 첫 번째 이미지 링크 반환
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
