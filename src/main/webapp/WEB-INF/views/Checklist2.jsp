<%@page import="com.sound.entity.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영양제 추천 설문지 - 2</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&family=Jua&family=Noto+Sans+KR:wght@500&display=swap"
	rel="stylesheet">

<style>
body {
	font-family: Arial, sans-serif;
	background-color: #ffffff;
	margin: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	flex-direction: column;
	padding: 0 10px;
	box-sizing: border-box;
}

.container {
	background-color: #ffffff;
	width: 100%;
	max-width: 430px;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	box-sizing: border-box;
	overflow-y: auto;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 0;
	position: relative; /* 드롭다운 메뉴 위치를 설정하기 위해 relative 추가 */
}

.logo img {
	width: 130px;
}

.menu-icon {
	width: 30px;
	height: 30px;
	cursor: pointer;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.menu-icon div {
	width: 100%;
	height: 4px;
	background-color: #000;
}

.dropdown-menu {
	display: none;
	position: absolute;
	top: 30%; /* 아이콘 바로 아래에 위치하도록 설정 */
	right: 0; /* 아이콘에 맞추어 오른쪽 정렬 */
	background-color: #ffffff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 5px;
	overflow: hidden;
	z-index: 1000;
	margin-top: 10px; /* 아이콘과 드롭다운 메뉴 사이의 간격을 조금 추가 */
	font-family: "Jua", sans-serif;
	font-weight: 400;
	font-style: normal;
}

.dropdown-menu a {
	display: block;
	padding: 10px;
	text-decoration: none;
	color: #000;
	border-bottom: 1px solid #ddd;
}

.dropdown-menu a:last-child {
	border-bottom: none;
}

.dropdown-menu a:hover {
	background-color: #f0f0f0;
}

.survey-title {
	text-align: center;
	font-size: 1.5em;
	font-weight: bold;
	margin-bottom: 20px;
}

.form-group {
	margin-bottom: 20px; /* 질문 사이에 여백 추가 */
}

.form-group label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

.form-group input[type="text"], .form-group input[type="number"],
	.form-group select {
	width: 100%;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	box-sizing: border-box;
}

.form-group input[type="checkbox"], .form-group input[type="radio"] {
	margin-right: 10px;
	transform: scale(1.2);
	vertical-align: middle;
	position: relative;
	top: -1px;
}

.form-group input[type="checkbox"] {
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 18px;
	height: 18px;
	border: 2px solid #ddd;
	border-radius: 3px;
	display: inline-block;
	position: relative;
}

.form-group input[type="checkbox"]:checked {
	background-color: #66DAE4;
	border-color: #66DAE4;
}

.form-group input[type="radio"] {
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 18px;
	height: 18px;
	border: 2px solid #ddd;
	border-radius: 50%;
	display: inline-block;
	position: relative;
}

.form-group input[type="radio"]:checked {
	background-color: #66DAE4;
	border-color: #66DAE4;
}

.submit-btn {
	background-color: #66DAE4;
	color: white;
	padding: 10px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-weight: bold;
	width: 48%; /* 버튼 너비 조정 */
	box-sizing: border-box;
	margin-top: 20px;
}

.form-group label.inline {
	display: inline-block;
	margin-right: 10px;
}

.form-group .no-label {
	display: inline;
	margin-left: 10px;
}

.button-group {
	display: flex;
	justify-content: space-between;
	margin-top: 20px;
	gap: 10px; /* 버튼 사이 간격 추가 */
}
</style>
<script type="text/javascript">
    var contextPath = '<%=request.getContextPath()%>';
</script>

<script src="assets/js/checklist1.js"></script>
</head>
<body>

	<%
	Users user = (Users) session.getAttribute("user");
	System.out.print("세션 값있냐?" + user);
	System.out.println("세션 ID: " + session.getId());
	%>

	<script>
    var userId = '<%=user.getUsrId()%>
		';
	</script>


	<div class="container">
		<div class="header">
			<div class="logo">

				<a href="GoMain"> <img src="img/로고.png" alt="로고">
				</a>
			</div>
			<div class="menu-icon">
				<div></div>
				<div></div>
				<div></div>
			</div>
			<div class="dropdown-menu" id="dropdownMenu">
				<a href="GoMyPage1">마이페이지</a> <a href="GoBoard">게시판</a> <a hred="">로그아웃</a>
			</div>
		</div>
		<h2 class="survey-title">영양제 추천 설문지</h2>

		<h3>식습관 및 영양</h3>
		<div class="form-group">
			<label>11. 일주일에 몇 번 생선을 드시나요?</label> <label class="inline"><input
				type="radio" name="fish" value="rarely"> 거의 먹지 않음</label> <label
				class="inline"><input type="radio" name="fish" value="1-2">
				1-2회</label> <label class="inline"><input type="radio" name="fish"
				value="3-4"> 3-4회</label> <label class="inline"><input
				type="radio" name="fish" value="5+"> 5회 이상</label>
		</div>
		<div class="form-group">
			<label>12. 유제품(우유, 요구르트, 치즈 등)을 얼마나 자주 드시나요?</label> <label
				class="inline"><input type="radio" name="dairy"
				value="rarely"> 거의 먹지 않음</label> <label class="inline"><input
				type="radio" name="dairy" value="1-2"> 주 1-2회</label> <label
				class="inline"><input type="radio" name="dairy" value="3-4">
				주 3-4회</label> <label class="inline"><input type="radio"
				name="dairy" value="daily"> 매일</label>
		</div>
		<div class="form-group">
			<label>13. 채식을 하시나요?</label> <label class="inline"><input
				type="radio" name="vegetarian" value="none"> 아니오, 육식을 포함한 모든
				음식을 먹습니다</label> <label class="inline"><input type="radio"
				name="vegetarian" value="pesco"> 페스코 베지테리언 (생선은 먹음)</label> <label
				class="inline"><input type="radio" name="vegetarian"
				value="lacto-ovo"> 락토-오보 베지테리언 (유제품과 달걀은 먹음)</label> <label
				class="inline"><input type="radio" name="vegetarian"
				value="vegan"> 비건 (완전 채식)</label>
		</div>
		<div class="form-group">
			<label>14. 현재 특별한 식단을 따르고 있나요? (해당하는 것 모두 선택)</label> <label
				class="inline"><input type="checkbox" name="diet"
				value="none"> 없음</label> <label class="inline"><input
				type="checkbox" name="diet" value="low_carb"> 저탄수화물 식단</label> <label
				class="inline"><input type="checkbox" name="diet"
				value="low_fat"> 저지방 식단</label> <label class="inline"><input
				type="checkbox" name="diet" value="gluten_free"> 글루텐 프리</label> <label
				class="inline"><input type="checkbox" name="diet"
				value="other"> 기타 <input type="text" name="diet_other"
				placeholder="기타 식단 입력"></label>
		</div>

		<h3>건강 상태</h3>
		<div class="form-group">
			<label>15. 현재 진단받은 건강 문제가 있나요? (해당하는 것 모두 선택)</label> <label
				class="inline"><input type="checkbox" name="health_issues"
				value="none"> 없음</label> <label class="inline"><input
				type="checkbox" name="health_issues" value="hypertension">
				고혈압</label> <label class="inline"><input type="checkbox"
				name="health_issues" value="diabetes"> 당뇨</label> <label
				class="inline"><input type="checkbox" name="health_issues"
				value="osteoporosis"> 골다공증</label> <label class="inline"><input
				type="checkbox" name="health_issues" value="anemia"> 빈혈</label> <label
				class="inline"><input type="checkbox" name="health_issues"
				value="thyroid"> 갑상선 문제</label> <label class="inline"><input
				type="checkbox" name="health_issues" value="heart_disease">
				심장 질환</label> <label class="inline"><input type="checkbox"
				name="health_issues" value="other"> 기타<input type="text"
				name="health_other" placeholder="기타 질병 입력"></label>
		</div>
		<div class="form-group">
			<label>16. 임신 중이거나 수유 중이신가요?</label> <label class="inline"><input
				type="radio" name="pregnancy" value="yes"> 예</label> <label
				class="inline no-label"><input type="radio" name="pregnancy"
				value="no"> 아니오</label>
		</div>
		<div class="form-group">
			<label>17. 현재 복용 중인 약물이 있나요? (있다면 기재해 주세요)</label> <input type="text"
				name="medication" placeholder="예: 약물명 입력"> <label
				class="inline no-label"><input type="radio"
				name="medication_status" value="none"> 아니오</label>
		</div>
		<div class="form-group">
			<label>18. 비타민이나 영양제를 현재 복용하고 있나요? (있다면 기재해 주세요)</label> <input
				type="text" name="supplements" placeholder="예: 영양제명 입력"> <label
				class="inline no-label"><input type="radio"
				name="supplements_status" value="none"> 아니오</label>
		</div>
		<div class="form-group">
			<label>19. 최근 6개월 내에 다음 증상을 경험한 적이 있나요? (해당하는 것 모두 선택)</label> <label
				class="inline"><input type="checkbox" name="symptoms"
				value="none"> 없음</label> <label class="inline"><input
				type="checkbox" name="symptoms" value="fatigue"> 만성 피로</label> <label
				class="inline"><input type="checkbox" name="symptoms"
				value="digestive"> 소화 문제</label> <label class="inline"><input
				type="checkbox" name="symptoms" value="joint_pain"> 관절통</label> <label
				class="inline"><input type="checkbox" name="symptoms"
				value="headache"> 두통</label> <label class="inline"><input
				type="checkbox" name="symptoms" value="insomnia"> 불면증</label> <label
				class="inline"><input type="checkbox" name="symptoms"
				value="skin_issues"> 피부 문제</label> <label class="inline"><input
				type="checkbox" name="symptoms" value="mood_changes"> 기분 변화</label>
		</div>
		<div class="form-group">
			<label>20. 알레르기나 특정 성분에 대한 민감성이 있나요? (있다면 기재해 주세요)</label> <input
				type="text" name="allergies" placeholder="예: 알레르기 입력"> <label
				class="inline no-label"><input type="radio"
				name="allergy_status" value="none"> 아니오</label>
		</div>

		<div class="button-group">
			<button class="submit-btn" onclick="previousPage()">이전</button>
			<button class="submit-btn" onclick="submitSurvey()">제출</button>
		</div>
	</div>
	<script>document.querySelector('.menu-icon').addEventListener('click', function() {
	    var dropdownMenu = document.getElementById('dropdownMenu');
	    if (dropdownMenu.style.display === 'block') {
	        dropdownMenu.style.display = 'none';
	    } else {
	        dropdownMenu.style.display = 'block';
	    }
	});
	document.addEventListener("DOMContentLoaded", function() {
	    function toggleInputField(radioName, inputName) {
	        const radioNone = document.querySelector(`input[name="${radioName}"][value="none"]`);
	        const inputField = document.querySelector(`input[name="${inputName}"]`);

	        // 현재 라디오 버튼이 선택된 상태를 확인할 변수
	        let wasChecked = false;

	        radioNone.addEventListener('click', function() {
	            // 선택된 상태에서 다시 클릭하면 해제
	            if (wasChecked) {
	                radioNone.checked = false;
	                inputField.disabled = false; // 입력 필드 활성화
	                wasChecked = false;
	            } else {
	                radioNone.checked = true;
	                inputField.value = ''; // 입력 필드 비우기
	                inputField.disabled = true; // 입력 필드 비활성화
	                wasChecked = true;
	            }
	        });
	    }

	    // 17번 질문 - 복용 중인 약물
	    toggleInputField('medication_status', 'medication');

	    // 18번 질문 - 비타민이나 영양제
	    toggleInputField('supplements_status', 'supplements');

	    // 20번 질문 - 알레르기나 특정 성분 민감성
	    toggleInputField('allergy_status', 'allergies');
	});


	
	</script>


</body>
</html>
