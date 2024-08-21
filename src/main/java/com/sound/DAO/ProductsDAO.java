package com.sound.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sound.database.FactoryManager;
import com.sound.entity.Ai_recommendation;
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

		int cnt = session.insert("insertProducts", products);

		// (3) SqlSession 반납하기
		session.close();

		// (4) 실행결과 리턴
		return cnt;
	}

	// 마이페이지에서 나오는 ..
	public List<Products> getProducts(Ai_recommendation ai) {

		SqlSession session = factory.openSession(true);

		List<Products> products_result = session.selectList("getProducts", ai);

		session.close();

		return products_result;
	}

}
