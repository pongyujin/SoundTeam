package com.sound.snsLogin;

import java.io.IOException;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/kakaologin")
public class KakaoLoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String clientId = "fdb3f3491258b8bea723bdc70be03745"; // 애플리케이션 클라이언트 아이디값
        String redirectURI = URLEncoder.encode("http://localhost:8081/SoundTeam/kakaocallback", "UTF-8");
        SecureRandom random = new SecureRandom();
        String state = new BigInteger(130, random).toString();
        String apiURL = "https://kauth.kakao.com/oauth/authorize?response_type=code";
        apiURL += "&client_id=" + clientId;
        apiURL += "&redirect_uri=" + redirectURI;
        apiURL += "&state=" + state;

        // 세션에 상태값 저장
        request.getSession().setAttribute("state", state);

        // 카카오 로그인 페이지로 리다이렉트
        response.sendRedirect(apiURL);
    }
}
