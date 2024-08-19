package com.sound.database;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class FactoryManager {

    private static SqlSessionFactory sqlSessionFactory;

    static {
        try {
            String resource = "com/sound/database/config.xml";
            InputStream inputStream = Resources.getResourceAsStream(resource);
            if (inputStream == null) {
                System.err.println("MyBatis 설정 파일을 찾을 수 없습니다: " + resource);
            } else {
                sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
                System.out.println("SqlSessionFactory 초기화 성공");
            }
        } catch (Exception e) {
            System.err.println("SqlSessionFactory 초기화 중 오류 발생");
            e.printStackTrace();
        }
    }

    public static SqlSessionFactory getSqlSessionFactory() {
        return sqlSessionFactory;
    }

    public static void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
        FactoryManager.sqlSessionFactory = sqlSessionFactory;
    }
}

