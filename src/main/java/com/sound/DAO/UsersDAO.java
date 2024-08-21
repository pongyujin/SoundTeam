package com.sound.DAO;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sound.database.FactoryManager;
import com.sound.entity.Users;

public class UsersDAO {

	private SqlSessionFactory factory = FactoryManager.getSqlSessionFactory();

	public UsersDAO() {

	}

	public UsersDAO(SqlSessionFactory factory) {
		this.factory = factory;
	}

	public Users Login(Users users) {

		SqlSession session = factory.openSession(true);

		// (2) 쿼리 실행
		Users result = session.selectOne("login", users);

		// (3) SqlSession 반납하기
		session.close();

		// (4) 실행결과 리턴
		return result;

	}

	// 홈페이지 회원가입 메서드
	public int Join(Users users) {

		SqlSession session = factory.openSession(true);
		// sql문 실행

		int cnt = session.insert("join", users);

		// session 닫기

		session.close();

		// 리턴

		return cnt;
	}

	// 개인정보 수정 메서드 
    public int update(Users users) {
    	
        SqlSession session = factory.openSession(true);
        
        int cnt = session.update("com.sound.DAO.UsersMapper.update", users);
        
        session.close();
        
        return cnt;
    }

	// id 중복체크 버튼 , 네이버/카카오 중복체크
	public Users id_check(String usr_id) {
		SqlSession session = factory.openSession(true);

		Users result = session.selectOne("check", usr_id);

		session.close();

		return result;
	}

	// 네이버 회원가입 메서드
	public int Naver_Join(Users users) {
		SqlSession session = factory.openSession(true);

		int cnt = session.insert("naverJoin", users);
		
		session.close();

		return cnt;
	}
	
	// 카카오 회원가입 메서드
	public int Kakao_Join(Users users) {
		SqlSession session = factory.openSession(true);

		int cnt = session.insert("kakaoJoin", users);
		
		session.close();

		return cnt;
	}
	
	

}
