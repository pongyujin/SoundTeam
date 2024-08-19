package com.sound.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor // 모든 필드를 초기화하는 생성자를 자동생성
@NoArgsConstructor // 기본생성자 자동생성
@Data // Getter, Setter 자동생성
public class Ai_Analysis {
	
	private Long analysisId; // ANALYSIS_ID: NUMBER(18)
	private String aiResult; // AI_RESULT: CLOB
	private Date createdAt; // CREATED_AT: DATE
	private String interaction; // INTER_ACTION: CLOB
	private String userId; // USR_ID: VARCHAR2(30)
}
