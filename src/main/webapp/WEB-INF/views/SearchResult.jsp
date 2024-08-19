<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>검색 결과</title>
</head>
<body>
    <h1>검색 결과</h1>

    <%
        String searchResult = (String) request.getAttribute("searchResult");
        org.json.JSONObject jsonObject = new org.json.JSONObject(searchResult);
        org.json.JSONArray items = jsonObject.getJSONArray("items");

        for (int i = 0; i < items.length(); i++) {
            org.json.JSONObject item = items.getJSONObject(i);
            String title = item.getString("title");
            String link = item.getString("link");
            String image = item.getString("image");
            String price = item.getString("lprice");
    %>
            <div>
                <h3><a href="<%= link %>" target="_blank"><%= title %></a></h3>
                <img src="<%= image %>" alt="<%= title %>"/>
                <p>가격: <%= price %>원</p>
            </div>
            <hr/>
    <%
        }
    %>

    <a href="index.jsp">다시 검색</a>
</body>
</html>
