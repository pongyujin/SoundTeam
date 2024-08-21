package com.sound.DAO;

import java.util.List;

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

		int cnt = session.insert("insertAiRecommendation", ai);

		// (3) SqlSession 반납하기
		session.close();

		// (4) 실행결과 리턴
		return cnt;
	}

	// 추천된 영양제 리스트 검색get
	public List<Ai_recommendation> getAi(String user_id) {

		SqlSession session = factory.openSession(true);

		List<Ai_recommendation> result = session.selectList("get", user_id);

		session.close();

		return result;
	}

	public int getMaxSuggIdBy(String user_id) {

		SqlSession session = factory.openSession(true);

		int suggid = session.selectOne("getMaxSuggIdBy", user_id);

		session.close();

		return suggid;
	}
	
	public List<Ai_recommendation> getAiRecommendation(Ai_recommendation ai) {
		
		SqlSession session = factory.openSession(true);
		
		List<Ai_recommendation> ai_result = session.selectList("getAiRecommendation",ai);
		
		session.close();

		return ai_result;
	}

}
