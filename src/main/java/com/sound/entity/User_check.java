package com.sound.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor // 모든 필드를 초기화하는 생성자를 자동생성
@NoArgsConstructor // 기본생성자 자동생성
@Data // Getter, Setter 자동생성
public class User_check {

	private long checkId; // CHECK_ID: NUMBER(18, 0)
	private long listIdent; // LIST_IDENT: NUMBER(18, 0)
	private String itemResponse; // ITEM_RESPONSE: VARCHAR2(255)
	private String usrId; // USR_ID: VARCHAR2(30)
}
