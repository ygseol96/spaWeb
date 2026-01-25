package com.example.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * 데이터베이스 연결 유틸리티 클래스
 */
public class DBConnection {

    private static final String URL = "JDBC:mysql://localhost:3307/skn?characterEncoding=UTF-8";
    private static final String USER = "root";
    private static final String PASSWORD = "4563";

    static {
        try {
            // MySQL JDBC 드라이버 로드
            Class.forName ("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException ("MySQL JDBC 드라이버를 찾을 수 없습니다.", e);
        }
    }

    /**
     * 데이터베이스 연결을 반환합니다.
     *
     * @return Connection 객체
     *
     * @throws SQLException
     *         SQL 예외
     */
    public static Connection getConnection () throws SQLException {
        return DriverManager.getConnection (URL, USER, PASSWORD);
    }
}
