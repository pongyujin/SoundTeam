package com.sound.DAO;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sound.database.FactoryManager;
import com.sound.entity.Ai_recommendation;

public class Ai_recommendationDAO {

	private SqlSessionFactory factory = FactoryManager.getSqlSessionFactory();

	public Ai_recommendationDAO() {

	}

	public Ai_recommendationDAO(SqlSessionFactory factory) {
		this.factory = factory;
	}

	// 값 넣는 메서드

	public int insertAi(Ai_recommendation ai) {

		SqlSession session = factory.openSession(true);

		int cnt = session.insert("insert", ai);

		// (3) SqlSession 반납하기
		session.close();

		// (4) 실행결과 리턴
		return cnt;
	}
}
