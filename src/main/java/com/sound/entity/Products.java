package com.sound.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor // 모든 필드를 초기화하는 생성자를 자동생성
@NoArgsConstructor // 기본생성자 자동생성
@Data // Getter, Setter 자동생성
public class Products {

	private long productId; // 상품식별자: NUMBER(18, 0)
	private String productUrl; // PRODUCT_URL: VARCHAR2(255)
	private String productImage; // PRODUCT_IMAGE: VARCHAR2(255)
	private long suggId; // 추천식별자: NUMBER(18, 0)
}
