<%@page import="com.sound.entity.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>영양제 추천 설문지 - 1</title>
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&family=Jua&family=Noto+Sans+KR:wght@500&display=swap"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
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
	width: 100%;
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

#heightError {
	color: red;
	display: none;
	font-size: 14px;
}

#weightError {
	color: red;
	display: none;
	font-size: 14px;
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
	
	<div class="container">
		<div class="header">
			<div class="logo">
				<a href="GoMain"> <img src="img/로고.png" alt="로고">
				</a>
			</div>
			<div class="menu-icon" onclick="toggleDropdown()">
				<div></div>
				<div></div>
				<div></div>
			</div>
			<div class="dropdown-menu" id="dropdownMenu">
				<a href="GoMyPage1">마이페이지</a> <a href="GoBoard">게시판</a> <a href="LogoutController">로그아웃</a>
			</div>

		</div>
		<h2 class="survey-title">영양제 추천 설문지</h2>
		<p>이 설문지는 귀하의 건강 상태와 생활 습관을 파악하여 적절한 영양제를 추천하는 데 도움이 됩니다. 가능한 정확하고
			정직하게 답변해 주세요.</p>

		<h3>기본 정보</h3>
		<div class="form-group">
			<label for="birth-year">1. 나이</label> <select id="birth-year">
				<option value="">년도를 선택하세요</option>
				<script>
					for (let i = 1940; i <= 2024; i++) {
						document.write('<option value="' + i + '">' + i
								+ '년</option>');
					}
				</script>
			</select>
		</div>
		<div class="form-group">
			<label>2. 성별</label> <label class="inline"><input
				type="radio" name="gender" value="male"> 남성</label> <label
				class="inline"><input type="radio" name="gender"
				value="female"> 여성</label>
		</div>
		<div class="form-group">
			<label for="height">3. 키</label> <input type="number" id="height"
				placeholder="cm" min="100" max="250"> <span id="heightError">제대로
				된 숫자를 입력해주세요 (100-250 cm)</span>
		</div>
		<div class="form-group">
			<label for="weight">4. 몸무게</label> <input type="number" id="weight"
				placeholder="kg" min="10" max="200"> <span id="weightError">제대로
				된 숫자를 입력해주세요 (10-200 kg)</span>

		</div>

		<h3>건강 및 생활 습관</h3>
		<div class="form-group">
			<label>5. 일주일에 몇 번 30분 이상 운동을 하시나요?</label> <label class="inline"><input
				type="radio" name="exercise" value="none"> 전혀 안 함</label> <label
				class="inline"><input type="radio" name="exercise"
				value="1-2"> 1-2회</label> <label class="inline"><input
				type="radio" name="exercise" value="3-4"> 3-4회</label> <label
				class="inline"><input type="radio" name="exercise"
				value="5+"> 5회 이상</label>
		</div>
		<div class="form-group">
			<label>6. 하루 평균 몇 시간 수면을 취하시나요?</label> <label class="inline"><input
				type="radio" name="sleep" value="under_5"> 5시간 미만</label> <label
				class="inline"><input type="radio" name="sleep" value="5-6">
				5-6시간</label> <label class="inline"><input type="radio" name="sleep"
				value="7-8"> 7-8시간</label> <label class="inline"><input
				type="radio" name="sleep" value="9+"> 9시간 이상</label>
		</div>
		<div class="form-group">
			<label>7. 스트레스 수준은 어떠신가요?</label> <label class="inline"><input
				type="radio" name="stress" value="very_low"> 매우 낮음</label> <label
				class="inline"><input type="radio" name="stress" value="low">
				낮음</label> <label class="inline"><input type="radio" name="stress"
				value="medium"> 보통</label> <label class="inline"><input
				type="radio" name="stress" value="high"> 높음</label> <label
				class="inline"><input type="radio" name="stress"
				value="very_high"> 매우 높음</label>
		</div>
		<div class="form-group">
			<label>8. 흡연을 하시나요?</label> <label class="inline"><input
				type="radio" name="smoking" value="yes"> 예</label> <label
				class="inline no-label"><input type="radio" name="smoking"
				value="no"> 아니오</label> <label class="inline"><input
				type="radio" name="smoking" value="past"> 과거에 했지만 현재는 안 함</label>
		</div>
		<div class="form-group">
			<label>9. 일주일에 알코올을 얼마나 자주 섭취하시나요?</label> <label class="inline"><input
				type="radio" name="alcohol" value="none"> 전혀 안 마심</label> <label
				class="inline"><input type="radio" name="alcohol"
				value="1-2"> 1-2회</label> <label class="inline"><input
				type="radio" name="alcohol" value="3-4"> 3-4회</label> <label
				class="inline"><input type="radio" name="alcohol" value="5+">
				5회 이상</label>
		</div>

		<h3>식습관 및 영양</h3>
		<div class="form-group">
			<label>10. 하루에 과일과 채소를 몇 인분 섭취하시나요?</label> <label class="inline"><input
				type="radio" name="fruit_veggies" value="0-1"> 0-1인분</label> <label
				class="inline"><input type="radio" name="fruit_veggies"
				value="2-3"> 2-3인분</label> <label class="inline"><input
				type="radio" name="fruit_veggies" value="4-5"> 4-5인분</label> <label
				class="inline"><input type="radio" name="fruit_veggies"
				value="6+"> 6인분 이상</label>
		</div>

		<button class="submit-btn" onclick="nextPage()">다음</button>
	</div>
	<script>
	// heightInput 변수에 input 요소를 저장합니다.
	const heightInput = document.getElementById("height");
	// heightError 변수에 span 요소를 저장합니다.
	const heightError = document.getElementById("heightError");

	// 키 입력 필드에서 키를 입력할 때마다 이벤트가 발생합니다.
	heightInput.addEventListener("input", function() {
	    // 입력된 값의 길이를 확인합니다.
	    if (heightInput.value.length > 3) {
	        // 값이 3자리 이상이면 마지막 입력을 제거하여 3자리로 유지합니다.
	        heightInput.value = heightInput.value.slice(0, 3);
	    }
	});

	// 키 입력 필드에서 포커스를 벗어날 때 (blur 이벤트) 이벤트가 발생합니다.
	heightInput.addEventListener("blur", function() {
	    // 현재 입력된 값을 가져옵니다.
	    const value = heightInput.value;

	    // 입력된 값이 100보다 작거나 250보다 큰지 확인합니다.
	    if (value < 100 || value > 250) {
	        // 오류 메시지를 표시합니다.
	        heightError.style.display = "inline";
	    } else {
	        // 입력된 값이 범위 내에 있다면 오류 메시지를 숨깁니다.
	        heightError.style.display = "none";
	    }
	});
	
	// weightInput 변수에 input 요소를 저장합니다.
	const weightInput = document.getElementById("weight");
	// weightError 변수에 span 요소를 저장합니다.
	const weightError = document.getElementById("weightError");

	// 몸무게 입력 필드에서 키를 입력할 때마다 이벤트가 발생합니다.
	weightInput.addEventListener("input", function() {
	    // 입력된 값의 길이를 확인합니다.
	    if (weightInput.value.length > 3) {
	        // 값이 3자리 이상이면 마지막 입력을 제거하여 3자리로 유지합니다.
	        weightInput.value = weightInput.value.slice(0, 3);
	    }
	});

	// 몸무게 입력 필드에서 포커스를 벗어날 때 (blur 이벤트) 이벤트가 발생합니다.
	weightInput.addEventListener("blur", function() {
	    // 현재 입력된 값을 가져옵니다.
	    const value = weightInput.value;

	    // 입력된 값이 10보다 작거나 200보다 큰지 확인합니다.
	    if (value < 10 || value > 200) {
	        // 오류 메시지를 표시합니다.
	        weightError.style.display = "inline";
	    } else {
	        // 입력된 값이 범위 내에 있다면 오류 메시지를 숨깁니다.
	        weightError.style.display = "none";
	    }
	});
	
	document.addEventListener("DOMContentLoaded", function() {
	    // URL 파라미터에서 'from' 값을 확인하여 이전 페이지에서 돌아온 경우에만 데이터 복원
	    const urlParams = new URLSearchParams(window.location.search);
	    const fromPage = urlParams.get('from');

	    if (fromPage === 'checklist2') {
	        const savedData = JSON.parse(localStorage.getItem('surveyData'));

	        if (savedData) {
	            savedData.forEach(item => {
	                switch (item.id) {
	                    case 1:
	                        document.getElementById("birth-year").value = item.response;
	                        break;
	                    case 2:
	                        document.querySelector(`input[name="gender"][value="${item.response}"]`).checked = true;
	                        break;
	                    case 3:
	                        document.getElementById("height").value = item.response;
	                        break;
	                    case 4:
	                        document.getElementById("weight").value = item.response;
	                        break;
	                    case 5:
	                        document.querySelector(`input[name="exercise"][value="${item.response}"]`).checked = true;
	                        break;
	                    case 6:
	                        document.querySelector(`input[name="sleep"][value="${item.response}"]`).checked = true;
	                        break;
	                    case 7:
	                        document.querySelector(`input[name="stress"][value="${item.response}"]`).checked = true;
	                        break;
	                    case 8:
	                        document.querySelector(`input[name="smoking"][value="${item.response}"]`).checked = true;
	                        break;
	                    case 9:
	                        document.querySelector(`input[name="alcohol"][value="${item.response}"]`).checked = true;
	                        break;
	                    case 10:
	                        document.querySelector(`input[name="fruit_veggies"][value="${item.response}"]`).checked = true;
	                        break;
	                }
	            });
	        }
	    }
	});



	document.querySelector('.menu-icon').addEventListener('click', function() {
	    var dropdownMenu = document.getElementById('dropdownMenu');
	    if (dropdownMenu.style.display === 'block') {
	        dropdownMenu.style.display = 'none';
	    } else {
	        dropdownMenu.style.display = 'block';
	    }
	});
	</script>




</body>
</html>
