package com.sound.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sound.database.FactoryManager;
import com.sound.entity.Board;
import com.sound.entity.Comment; // 새로 추가된 Comment 클래스

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
        
        // Null 체크 추가
        if (list == null) {
            System.out.println("SelectList returned null");
        } else {
            System.out.println("SelectList returned list of size: " + list.size());
        }
        
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
    public Board view(int postId) {
        SqlSession session = factory.openSession(true);
        Board board = session.selectOne("view", postId);
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
    public int delete(int postId) {
        SqlSession session = factory.openSession(true);
        int cnt = session.delete("delete", postId);
        session.close();
        return cnt;
    }

    // 7. 조회수 증가
    public int increaseViewCount(int postId) {
        SqlSession session = factory.openSession(true);
        int cnt = session.update("increaseViewCount", postId);
        session.close();
        return cnt;
    }
    
    // 8. 댓글 저장
    public int saveComment(Comment comment) {
        SqlSession session = factory.openSession(true);
        int cnt = session.insert("saveComment", comment);
        session.close();
        return cnt;
    }

    // 9. 좋아요 수 업데이트
    public int updateLikes(int postId, int likes) {
        SqlSession session = factory.openSession(true);
        Map<String, Integer> params = new HashMap<>();
        params.put("postId", postId);
        params.put("likes", likes);
        int cnt = session.update("updateLikes", params);
        session.close();
        return cnt;
    }

    // 10. 댓글 불러오기
    public List<Comment> getCommentsByPostId(int postId) {
        SqlSession session = factory.openSession(true);
        List<Comment> comments = session.selectList("getCommentsByPostId", postId);
        session.close();
        return comments;
    }

    // 11. 좋아요 수 불러오기
    public int getLikesByPostId(int postId) {
        SqlSession session = factory.openSession(true);
        int likes = session.selectOne("getLikesByPostId", postId);
        session.close();
        return likes;
    }
}
