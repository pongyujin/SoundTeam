package com.sound.snsLogin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.sound.DAO.UsersDAO;
import com.sound.entity.Users;

@WebServlet("/kakaocallback")
public class KakaoCallbackController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String clientId = "fdb3f3491258b8bea723bdc70be03745"; // 애플리케이션 클라이언트 아이디값
		String clientSecret = "rOBQj5Gj8cvoaW5TAG5YBnAhB3ipTF3g"; // 애플리케이션 클라이언트 시크릿값
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		String redirectURI = URLEncoder.encode("http://localhost:8081/SoundTeam/kakaocallback", "UTF-8");
		String apiURL = "https://kauth.kakao.com/oauth/token?grant_type=authorization_code" + "&client_id=" + clientId
				+ "&client_secret=" + clientSecret + "&redirect_uri=" + redirectURI + "&code=" + code + "&state="
				+ state;

		String accessToken = "";

		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");

			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuilder res = new StringBuilder();
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();

			if (responseCode == 200) {
				JSONObject jsonResponse = new JSONObject(res.toString());
				accessToken = jsonResponse.getString("access_token");

				// 사용자 정보 요청
				String header = "Bearer " + accessToken; // Bearer 다음에 공백 추가
				String apiURLUserInfo = "https://kapi.kakao.com/v2/user/me";

				url = new URL(apiURLUserInfo);
				con = (HttpURLConnection) url.openConnection();
				con.setRequestMethod("GET");
				con.setRequestProperty("Authorization", header);

				int userInfoResponseCode = con.getResponseCode();
				BufferedReader userInfoBr;

				if (userInfoResponseCode == 200) {
					userInfoBr = new BufferedReader(new InputStreamReader(con.getInputStream()));
				} else {
					userInfoBr = new BufferedReader(new InputStreamReader(con.getErrorStream()));
				}

				StringBuilder userInfoRes = new StringBuilder();

				while ((inputLine = userInfoBr.readLine()) != null) {
					userInfoRes.append(inputLine);
				}
				userInfoBr.close();

				if (userInfoResponseCode == 200) {
					JSONObject userInfo = new JSONObject(userInfoRes.toString());
					JSONObject responseObj = userInfo.getJSONObject("kakao_account");

					String email = responseObj.optString("email", null); // 이메일 주소
					System.out.println(email);

					// DB에 사용자 정보 저장
					Users users = new Users();
					users.setUsrId(email);
					users.setUsrName("kakao_name"); // 임시 이름 설정
					users.setUsrPw("kakao_password"); // 임시 비밀번호 설정

					UsersDAO usersdao = new UsersDAO();

					// id 값 있나 없나 확인
					Users result = usersdao.id_check(email);
					
					
					HttpSession session = request.getSession();
					if (result == null) {
						// 네이버 로그인 값 DB에 insert 하는 메서드
						int cnt = usersdao.Kakao_Join(users);
						if (cnt > 0) {
							System.out.println("카카오 회원가입 성공");
							session.setAttribute("user", users);
							response.sendRedirect("GoMain");
						} else {
							System.out.println("카카오 회원가입 실패...");
						}
					} else {
						// 이미 네이버로 회원가입이 된 상태
						// 창 넘어가기
						session.setAttribute("user", users);
						response.sendRedirect("GoMain");
						System.out.println("카카오 로그인 성공!!!");

					}

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
