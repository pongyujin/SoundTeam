package com.sound.DAO;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sound.database.FactoryManager;
import com.sound.entity.Ai_Analysis;

public class Ai_AnalysisDAO {

	private SqlSessionFactory factory = FactoryManager.getSqlSessionFactory();

	public Ai_AnalysisDAO() {

	}

	public Ai_AnalysisDAO(SqlSessionFactory factory) {
		this.factory = factory;
	}
	
	// 값 넣기 메서드
	public int insert(Ai_Analysis ai_analysis) {

		SqlSession session = factory.openSession(true);

		// (2) 쿼리 실행
		int cnt = session.insert("insert",ai_analysis);

		// (3) SqlSession 반납하기
		session.close();

		// (4) 실행결과 리턴
		return cnt;

	}

}
