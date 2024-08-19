package com.sound.DAO;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sound.database.FactoryManager;
import com.sound.entity.User_check;

public class User_checkDAO {

	private SqlSessionFactory factory = FactoryManager.getSqlSessionFactory();

	public User_checkDAO() {

	}

	public User_checkDAO(SqlSessionFactory factory) {
		this.factory = factory;
	}

	public int insertUserCheck(User_check userCheck) {

		SqlSession session = factory.openSession(true);

		int cnt = session.insert("insertUserCheck", userCheck);

		// (3) SqlSession 반납하기
		session.close();

		// (4) 실행결과 리턴
		return cnt;
	}
	
	public int getNextCheckId() {
		
		int maxCheckId = 0;

		SqlSession session = factory.openSession(true);

		maxCheckId = session.selectOne("getMaxCheckId");

		// (3) SqlSession 반납하기
		session.close();

		// (4) 실행결과 리턴
		return maxCheckId + 1; // 가장 큰 check_id에 1을 더해 반환
	}

}
