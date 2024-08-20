package com.sound.DAO;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sound.database.FactoryManager;
import com.sound.entity.Products;

public class ProductsDAO {
	
	private SqlSessionFactory factory = FactoryManager.getSqlSessionFactory();

	public ProductsDAO() {

	}

	public ProductsDAO(SqlSessionFactory factory) {
		this.factory = factory;
	}
	
	
	// 값 넣는 메서드
	public int insertProducts(Products products) {

		SqlSession session = factory.openSession(true);

		int cnt = session.insert("insertProduct", products);

		// (3) SqlSession 반납하기
		session.close();

		// (4) 실행결과 리턴
		return cnt;
	}


}
