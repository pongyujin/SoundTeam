package com.sound.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sound.database.FactoryManager;
import com.sound.entity.Board;

public class BoardDAO {
    private SqlSessionFactory factory = FactoryManager.getSqlSessionFactory();

    // 1. 게시글 목록 조회 (페이지네이션 추가)
    public List<Board> list(int offset, int limit) {
        SqlSession session = factory.openSession(true);
        Map<String, Integer> params = new HashMap<>();
        params.put("offset", offset);
        params.put("limit", limit);
        List<Board> list = session.selectList("listWithPagination", params);
        session.close();
        return list;
    }
    
    // 2. 게시글 작성하기
    public int writer(Board board) {
        SqlSession session = factory.openSession(true);
        int cnt = session.insert("writer", board);
        session.close();
        return cnt;
    }
    
    // 3. 게시글 상세보기
    public Board view(int idx) {
        SqlSession session = factory.openSession(true);
        Board board = session.selectOne("view", idx);
        session.close();
        return board;
    }
    
    // 4. 게시글 검색 (검색 대상 확장 및 검증 추가)
    public List<Board> search(String search) {
        SqlSession session = factory.openSession(true);
        List<Board> list = session.selectList("search", search);
        session.close();
        return list;
    }
    
    // 5. 게시글 수정
    public int update(Board board) {
        SqlSession session = factory.openSession(true);
        int cnt = session.update("update", board);
        session.close();
        return cnt;
    }
    
    // 6. 게시글 삭제
    public int delete(int idx) {
        SqlSession session = factory.openSession(true);
        int cnt = session.delete("delete", idx);
        session.close();
        return cnt;
    }
}
