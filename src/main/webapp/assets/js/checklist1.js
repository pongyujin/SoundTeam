// 데이터를 저장할 배열 선언
let surveyData = [];

// checklist1.jsp에서 다음 버튼을 클릭했을 때 실행되는 함수
function nextPage() {
	// 설문 1에서 입력받은 데이터를 가져오기
	const birthYear = document.getElementById("birth-year").value.trim(); // 공백 제거
	const genderElement = document.querySelector('input[name="gender"]:checked');
	const gender = genderElement ? genderElement.value : null;
	const height = document.getElementById("height").value.trim(); // 공백 제거
	const weight = document.getElementById("weight").value.trim(); // 공백 제거
	const exerciseElement = document.querySelector('input[name="exercise"]:checked');
	const exercise = exerciseElement ? exerciseElement.value : null;
	const sleepElement = document.querySelector('input[name="sleep"]:checked');
	const sleep = sleepElement ? sleepElement.value : null;
	const stressElement = document.querySelector('input[name="stress"]:checked');
	const stress = stressElement ? stressElement.value : null;
	const smokingElement = document.querySelector('input[name="smoking"]:checked');
	const smoking = smokingElement ? smokingElement.value : null;
	const alcoholElement = document.querySelector('input[name="alcohol"]:checked');
	const alcohol = alcoholElement ? alcoholElement.value : null;
	const fruitVeggiesElement = document.querySelector('input[name="fruit_veggies"]:checked');
	const fruitVeggies = fruitVeggiesElement ? fruitVeggiesElement.value : null;

	console.log("birthYear:", birthYear);
	console.log("gender:", gender);

	// 필수 항목이 입력되었는지 확인
	if (!birthYear || !gender || !height || !weight || !exercise || !sleep || !stress || !smoking || !alcohol || !fruitVeggies) {
		alert("모든 항목을 입력해 주세요.");
		return; // 빈 값이 있으면 함수 종료, 다음 페이지로 이동하지 않음
	}
	// surveyData 배열에 저장
	surveyData.push({ id: 1, response: birthYear });
	surveyData.push({ id: 2, response: gender });
	surveyData.push({ id: 3, response: height });
	surveyData.push({ id: 4, response: weight });
	surveyData.push({ id: 5, response: exercise });
	surveyData.push({ id: 6, response: sleep });
	surveyData.push({ id: 7, response: stress });
	surveyData.push({ id: 8, response: smoking });
	surveyData.push({ id: 9, response: alcohol });
	surveyData.push({ id: 10, response: fruitVeggies });

	// 데이터를 로컬 스토리지에 저장
	localStorage.setItem('surveyData', JSON.stringify(surveyData));

	// 데이터 전송이 완료된 후에 다음 페이지로 이동
	const url = window.contextPath + '/GoChecklist2?action=next';
	window.location.replace(url);
}

// checklist2.jsp에서 이전 버튼을 클릭했을 때 실행되는 함수
function previousPage() {
	// checklist1.jsp로 이동
	const url = window.contextPath + '/GoCheckListPage?action=next&from=checklist2';
	window.location.replace(url);
}

function submitSurvey() {
	// 로딩 화면 표시
	document.getElementById("loadingScreen").style.display = "flex";

	// 설문 2에서 입력받은 데이터를 가져오기
	const fishElement = document.querySelector('input[name="fish"]:checked');
	const fish = fishElement ? fishElement.value : null;

	const dairyElement = document.querySelector('input[name="dairy"]:checked');
	const dairy = dairyElement ? dairyElement.value : null;

	const vegetarianElement = document.querySelector('input[name="vegetarian"]:checked');
	const vegetarian = vegetarianElement ? vegetarianElement.value : null;

	const diet = [];
	document.querySelectorAll('input[name="diet"]:checked').forEach((item) => {
		diet.push(item.value);
	});
	const dietOther = diet.includes("other") ? document.querySelector('input[name="diet_other"]').value.trim() : '';

	const healthIssues = [];
	document.querySelectorAll('input[name="health_issues"]:checked').forEach((item) => {
		healthIssues.push(item.value);
	});
	const healthOther = healthIssues.includes("other") ? document.querySelector('input[name="health_other"]').value.trim() : '';

	const pregnancyElement = document.querySelector('input[name="pregnancy"]:checked');
	const pregnancy = pregnancyElement ? pregnancyElement.value : null;

	const medicationElement = document.querySelector('input[name="medication_status"]:checked');
	const medication = medicationElement && medicationElement.value === "none"
		? "none"
		: (document.querySelector('input[name="medication"]').value.trim() || null);

	const supplementsElement = document.querySelector('input[name="supplements_status"]:checked');
	const supplements = supplementsElement && supplementsElement.value === "none"
		? "none"
		: (document.querySelector('input[name="supplements"]').value.trim() || null);

	const symptoms = [];
	document.querySelectorAll('input[name="symptoms"]:checked').forEach((item) => {
		symptoms.push(item.value);
	});

	const allergiesElement = document.querySelector('input[name="allergy_status"]:checked');
	const allergies = allergiesElement && allergiesElement.value === "none"
		? "none"
		: (document.querySelector('input[name="allergies"]').value.trim() || null);

	// 필수 항목이 입력되었는지 확인
	if (!fish || !dairy || !vegetarian ||
		(diet.includes("other") && !dietOther) || // "기타" 선택 시 기타 입력 필드 필수
		(healthIssues.includes("other") && !healthOther) || // "기타" 선택 시 기타 입력 필드 필수
		!pregnancy ||
		!medication ||
		!supplements ||
		symptoms.length === 0 ||
		!allergies) {
		alert("모든 항목을 선택해 주세요.");
		document.getElementById("loadingScreen").style.display = "none"; // 로딩 화면 숨김
		return; // 빈 값이 있으면 함수 종료, 제출을 진행하지 않음
	}

	// 로컬 스토리지에서 surveyData를 불러오기
	let surveyData = JSON.parse(localStorage.getItem('surveyData')) || [];

	// surveyData 배열에 저장
	surveyData.push({ id: 11, response: fish });
	surveyData.push({ id: 12, response: dairy });
	surveyData.push({ id: 13, response: vegetarian });
	surveyData.push({ id: 14, response: diet.join(', ') + ' ' + dietOther });
	surveyData.push({ id: 15, response: healthIssues.join(', ') + ' ' + healthOther });
	surveyData.push({ id: 16, response: pregnancy });
	surveyData.push({ id: 17, response: medication });
	surveyData.push({ id: 18, response: supplements });
	surveyData.push({ id: 19, response: symptoms.join(', ') });
	surveyData.push({ id: 20, response: allergies });

	// 설문 데이터를 ChecklistController에 전송
	const xhr = new XMLHttpRequest();
	xhr.open('POST', 'ChecklistController', true);
	xhr.setRequestHeader('Content-Type', 'application/json');

	xhr.onreadystatechange = function() {
		if (xhr.readyState === 4) {
			if (xhr.status === 200) {
				try {
					// JSON 응답을 처리
					const responseData = JSON.parse(xhr.responseText);
					console.log('AI 결과:', responseData);

					// recommend.jsp 페이지로 리디렉션
					window.location.href = 'http://localhost:8081/ST/GoRecommendPage';

				} catch (e) {
					// JSON 파싱 오류 처리 (HTML 페이지가 반환된 경우)
					console.error('응답이 JSON 형식이 아닙니다: ', xhr.responseText);
					alert('서버에서 잘못된 응답을 받았습니다. 다시 시도해주세요.');
					document.getElementById("loadingScreen").style.display = "none"; // 로딩 화면 숨김
				}
			} else {
				console.error('서버 오류:', xhr.status, xhr.responseText);
				alert('서버 오류가 발생했습니다. 다시 시도해주세요.');
				document.getElementById("loadingScreen").style.display = "none"; // 로딩 화면 숨김
			}
		}
	};

	xhr.onerror = function() {
		console.error('요청 중 오류 발생');
		alert('요청 중 오류가 발생했습니다. 네트워크 상태를 확인하세요.');
		document.getElementById("loadingScreen").style.display = "none"; // 로딩 화면 숨김
	};

	console.log("Sending data to server:", surveyData);
	xhr.send(JSON.stringify(surveyData));
}
