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

@WebServlet("/NaverCallbackController")
public class NaverCallbackController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("application/json; charset=UTF-8");

		String clientId = "LowTSePK6d7ObwHcqBN0"; // 애플리케이션 클라이언트 아이디값
		String clientSecret = "_AucEn9OXX"; // 애플리케이션 클라이언트 시크릿값
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		String redirectURI = URLEncoder.encode("http://localhost:8081/ST/NaverCallbackController", "UTF-8");
		String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code" + "&client_id=" + clientId
				+ "&client_secret=" + clientSecret + "&redirect_uri=" + redirectURI + "&code=" + code + "&state="
				+ state;

		String accessToken = "";
		String refresh_token = "";

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
				String apiURLUserInfo = "https://openapi.naver.com/v1/nid/me";

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
					JSONObject responseObj = userInfo.getJSONObject("response");

					String name = responseObj.optString("name", null); // 회원 이름
					String email = responseObj.optString("email", null); // 이메일 주소
					String gender = responseObj.optString("gender", null); // 성별
					String birthYear = responseObj.optString("birthyear", null); // 출생연도
					String birth = responseObj.optString("birthday", null); // 생일

					String usrBirthday = birthYear + "-" + birth;

					// DB에 사용자 정보 저장
					System.out.println(name + email + gender);


					Users users = new Users();
					users.setUsrId(email);
					users.setUsrName(name);
					users.setUsrBirthday(usrBirthday); // java.sql.Date 객체를 설정
					users.setUsrGender(gender);
					users.setUsrPw("naver_password"); // 임시 비밀번호 설정

					UsersDAO usersdao = new UsersDAO();

					// id 값 있나 없나 확인
					Users result = usersdao.id_check(email);
					HttpSession session = request.getSession();
					
					if (result == null) {
						// 네이버 로그인 값 DB에 insert 하는 메서드
						int cnt = usersdao.Naver_Join(users);
						if (cnt > 0) {
							System.out.println("네이버 회원가입 성공");
							session.setAttribute("user", users);
							response.sendRedirect("GoMain");
						} else {
							System.out.println("네이버 회원가입 실패...");

						}
						response.sendRedirect("GoMain");
					} else {
						// 이미 네이버로 회원가입이 된 상태
						// 창 넘어가기
						session.setAttribute("user", users);
						response.sendRedirect("GoMain");
						System.out.println("네이버 로그인 성공!!!");

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