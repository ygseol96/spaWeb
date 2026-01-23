<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.gson.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
    // JSON 응답 설정
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    // JSON 파일에서 응답 메시지 로드
    String messagesPath = application.getRealPath("/WEB-INF/response-messages.json");
    JsonObject messages = null;

    try (FileReader reader = new FileReader(messagesPath)) {
        messages = JsonParser.parseReader(reader).getAsJsonObject();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 응답 객체 생성
    JsonObject responseJson = new JsonObject();

    try {
        // 파라미터 받기
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 입력값 검증
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {

            JsonObject loginRequired = messages.getAsJsonObject("LOGIN_REQUIRED");
            responseJson.addProperty("success", false);
            responseJson.addProperty("code", loginRequired.get("code").getAsString());
            responseJson.addProperty("message", loginRequired.get("message").getAsString());
            out.print(responseJson.toString());
            return;
        }

        // DB 연결 정보
        String dbUrl = "jdbc:mysql://localhost:3307/skn?useSSL=false&characterEncoding=UTF-8";
        String dbUser = "root";
        String dbPassword = "4563";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // JDBC 드라이버 로드
            Class.forName("com.mysql.cj.jdbc.Driver");

            // DB 연결
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // SQL 쿼리 실행
            String query = "SELECT user_id, user_name, user_level, user_tel \n" +
                            "FROM tbl_weekend_member \n" +
                            "WHERE user_id = ? \n" +
                            "AND user_password = ?;";
            String sql = query;
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                // 로그인 성공
                JsonObject loginSuccess = messages.getAsJsonObject("LOGIN_SUCCESS");

                // 세션에 사용자 정보 저장
                session.setAttribute("userId", rs.getLong("user_id"));
                session.setAttribute("username", rs.getString("user_name"));
                session.setAttribute("userLevel", rs.getString("user_level"));
                session.setAttribute("phone", rs.getString("user_tel"));


                // 사용자 정보 객체 생성
                JsonObject userInfo = new JsonObject();
                userInfo.addProperty("userId", rs.getLong("user_id"));
                userInfo.addProperty("username", rs.getString("user_name"));
                userInfo.addProperty("userLevel", rs.getString("user_level"));
                userInfo.addProperty("phone", rs.getString("user_tel"));

                responseJson.addProperty("success", true);
                responseJson.addProperty("code", loginSuccess.get("code").getAsString());
                responseJson.addProperty("message", loginSuccess.get("message").getAsString());
                responseJson.add("user", userInfo);

            } else {
                // 로그인 실패
                JsonObject loginFailed = messages.getAsJsonObject("LOGIN_FAILED");
                responseJson.addProperty("success", false);
                responseJson.addProperty("code", loginFailed.get("code").getAsString());
                responseJson.addProperty("message", loginFailed.get("message").getAsString());
            }

        } catch (ClassNotFoundException e) {
            // 드라이버 로드 실패
            JsonObject dbError = messages.getAsJsonObject("DB_CONNECTION_ERROR");
            responseJson.addProperty("success", false);
            responseJson.addProperty("code", dbError.get("code").getAsString());
            responseJson.addProperty("message", dbError.get("message").getAsString());
            e.printStackTrace();

        } catch (SQLException e) {
            // DB 연결 또는 쿼리 실패
            JsonObject dbError = messages.getAsJsonObject("DB_QUERY_ERROR");
            responseJson.addProperty("success", false);
            responseJson.addProperty("code", dbError.get("code").getAsString());
            responseJson.addProperty("message", dbError.get("message").getAsString());
            e.printStackTrace();

        } finally {
            // 리소스 정리
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

    } catch (Exception e) {
        // 기타 예외 처리
        JsonObject loginError = messages.getAsJsonObject("LOGIN_ERROR");
        responseJson.addProperty("success", false);
        responseJson.addProperty("code", loginError.get("code").getAsString());
        responseJson.addProperty("message", loginError.get("message").getAsString());
        e.printStackTrace();
    }

    // JSON 응답 출력
    out.print(responseJson.toString());
%>
