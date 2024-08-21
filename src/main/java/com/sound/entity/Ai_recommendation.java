package com.sound.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor // 모든 필드를 초기화하는 생성자를 자동생성
@NoArgsConstructor // 기본생성자 자동생성
@Data // Getter, Setter 자동생성
public class Ai_recommendation {

	private long suggId; // 추천식별자: NUMBER(18)
	private String suggReason; // 추천이유: VARCHAR2(2000)
	private String suggestedAt; // 추천날짜: DATE (Java에서는 String으로 처리)
	private String nutrId; // 추천 영양제: VARCHAR2(30)
	private String foodId; // 추천 식품: VARCHAR2(30)
	private String interaction; // 상호작용: VARCHAR2(1000)
	private String usrId; // USR_ID: VARCHAR2(30)

}
