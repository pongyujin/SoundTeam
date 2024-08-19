package com.sound.DAO;

public class MyBatisTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
            Class.forName("org.apache.ibatis.io.Resources");
            System.out.println("MyBatis 클래스 로드 성공");
        } catch (ClassNotFoundException e) {
            System.out.println("MyBatis 클래스 로드 실패");
            e.printStackTrace();
        }
	}

}
