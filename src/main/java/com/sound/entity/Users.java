package com.sound.entity;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor // 모든 필드를 초기화하는 생성자를 자동생성
@NoArgsConstructor // 기본생성자 자동생성
@Data // Getter, Setter 자동생성
public class Users {

	private String usrId;
	private String usrPw;
	private String usrName;
	private String usrEmail;
	private String usrBirthday;
	private String usrGender;
	private Timestamp joinedAt;
}
