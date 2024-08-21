package com.sound.DAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.sound.database.FactoryManager;
import com.sound.entity.Board;
import com.sound.entity.Comment;

public class BoardDAO {
    private SqlSessionFactory factory = FactoryManager.getSqlSessionFactory();

    public List<Board> list(int offset, int limit) {
        SqlSession session = factory.openSession(true);
        Map<String, Integer> params = new HashMap<>();

        params.put("offset", offset);
        params.put("limit", limit);
        List<Board> list = session.selectList("com.sound.DAO.BoardMapper.listWithPagination", params);
        session.close();

        return list;
    }

    public int writer(Board board) {
        SqlSession session = factory.openSession(true);
        int cnt = session.insert("com.sound.DAO.BoardMapper.writer", board);
        session.close();
        return cnt;
    }

    public Board view(int postId) {
        SqlSession session = factory.openSession(true);
        Board board = session.selectOne("com.sound.DAO.BoardMapper.view", postId);
        session.close();
        return board;
    }

    public List<Board> search(String search) {
        SqlSession session = factory.openSession(true);
        List<Board> list = session.selectList("com.sound.DAO.BoardMapper.search", search);
        session.close();
        return list;
    }

    public int update(Board board) {
        SqlSession session = factory.openSession(true);
        int cnt = session.update("com.sound.DAO.BoardMapper.update", board);
        session.close();
        return cnt;
    }

    public int delete(int postId) {
        SqlSession session = factory.openSession(true);
        int cnt = session.delete("com.sound.DAO.BoardMapper.delete", postId);
        session.close();
        return cnt;
    }

    public int increaseViewCount(int postId) {
        SqlSession session = factory.openSession(true);
        int cnt = session.update("com.sound.DAO.BoardMapper.increaseViewCount", postId);
        session.close();
        return cnt;
    }

    public int increaseLikes(int postId) {
        SqlSession session = factory.openSession(true);
        int cnt = session.update("com.sound.DAO.BoardMapper.increaseLikes", postId);
        session.close();
        return cnt;
    }

    public int getLikes(int postId) {
        SqlSession session = factory.openSession(true);
        int likes = session.selectOne("com.sound.DAO.BoardMapper.getLikes", postId);
        session.close();
        return likes;
    }

    public List<Comment> getCommentsByPostId(int postId) {
        SqlSession session = factory.openSession(true);
        List<Comment> comments = session.selectList("com.sound.DAO.BoardMapper.getCommentsByPostId", postId);
        session.close();
        return comments;
    }

    public int addComment(Comment comment) {
        SqlSession session = factory.openSession(true);
        int cnt = session.insert("com.sound.DAO.BoardMapper.addComment", comment);
        session.close();
        System.out.println("댓글 추가 결과: " + cnt);  // 로그 추가
        return cnt;
    }

    public int getTotalPosts() {
        SqlSession session = factory.openSession(true);
        int totalPosts = session.selectOne("com.sound.DAO.BoardMapper.getTotalPosts");
        session.close();
        return totalPosts;
    }
}
