<%@page import="java.net.URLDecoder"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 간단한 스타일을 추가 */
.result-container {
	margin: 20px;
}

.product-item {
	border: 1px solid #ccc;
	padding: 10px;
	margin-bottom: 10px;
}

.product-item img {
	max-width: 150px;
	height: auto;
}
</style>
</head>
<body>

	<%
	// URL 파라미터에서 비타민 이름 가져오기
	String vitaminName = request.getParameter("vitamin");
	if (vitaminName != null) {
		vitaminName = URLDecoder.decode(vitaminName, "UTF-8");

		// NaverApiController 서블릿 호출
		String apiUrl = "http://localhost:8081/ST/NaverApiController?query=" + vitaminName;

		// API 요청 및 응답 받기
		URL url = new URL(apiUrl);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");

		BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		String inputLine;
		StringBuffer newResponse = new StringBuffer();
		while ((inputLine = in.readLine()) != null) {
			newResponse.append(inputLine);
		}
		in.close();

		// JSON 파싱
		JSONObject jsonResponse = new JSONObject(response.toString());
		JSONArray items = jsonResponse.getJSONArray("items");

		// 검색 결과를 페이지에 표시
	%>

	<div class="result-container">
		<h2><%=vitaminName%>
			검색 결과
		</h2>
		<%
		for (int i = 0; i < items.length(); i++) {
			JSONObject item = items.getJSONObject(i);
			String title = item.getString("title");
			String image = item.getString("image");
			String link = item.getString("link");
			String price = item.getString("lprice");
		%>
		<div class="product-item">
			<h3>
				<a href="<%=link%>" target="_blank"><%=title%></a>
			</h3>
			<img src="<%=image%>" alt="<%=title%>">
			<p>
				가격:
				<%=price%>
				원
			</p>
		</div>
		<%
		}
		%>
	</div>

	<%
	} else {
	out.println("<p>비타민 이름이 제공되지 않았습니다.</p>");
	}
	%>

</body>
</html>