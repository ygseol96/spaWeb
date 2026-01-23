package com.example.servlet;

import com.example.util.DBConnection;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 주말근무 서블릿 - SPA 형태로 직접 DB 처리
 */
@WebServlet(urlPatterns = {"/api/*", "/work/*"})
public class WeekendWorkServlet extends HttpServlet {

    private final Gson gson = new Gson();

    /**
     * GET 요청 처리 - 주말근무 목록 조회 (페이징)
     *
     * @param request  the request
     * @param response the response
     * @throws ServletException the servlet exception
     * @throws IOException      the io exception
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 한글 인코딩 설정
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        PrintWriter out = response.getWriter();

        try {
            // 페이징 파라미터 가져오기
            String pageParam = request.getParameter("page");
            String sizeParam = request.getParameter("size");

            int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
            int size = (sizeParam != null) ? Integer.parseInt(sizeParam) : 10;

            // 유효성 검증
            if (page < 1) page = 1;
            if (size < 1 || size > 100) size = 10;

            // 데이터 조회
            List<Map<String, Object>> list = getWeekendWorkList(page, size);
            int totalCount = getTotalCount();
            int totalPages = (int) Math.ceil((double) totalCount / size);

            // 응답 데이터 구성
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("success", true);
            responseData.put("data", list);

            Map<String, Object> pagination = new HashMap<>();
            pagination.put("currentPage", page);
            pagination.put("pageSize", size);
            pagination.put("totalCount", totalCount);
            pagination.put("totalPages", totalPages);
            responseData.put("pagination", pagination);

            response.setStatus(HttpServletResponse.SC_OK);
            out.print(gson.toJson(responseData));

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JsonObject error = new JsonObject();
            error.addProperty("success", false);
            error.addProperty("message", "잘못된 페이지 파라미터입니다.");
            out.print(gson.toJson(error));
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JsonObject error = new JsonObject();
            error.addProperty("success", false);
            error.addProperty("message", "서버 오류가 발생했습니다: " + e.getMessage());
            out.print(gson.toJson(error));
        }
    }



    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 한글 인코딩 설정
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");

        PrintWriter out = response.getWriter();

        try {
            // 페이징 파라미터 가져오기
            String pageParam = request.getParameter("page");
            String sizeParam = request.getParameter("size");

            int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
            int size = (sizeParam != null) ? Integer.parseInt(sizeParam) : 10;

            // 유효성 검증
            if (page < 1) page = 1;
            if (size < 1 || size > 100) size = 10;

            // 데이터 조회
            List<Map<String, Object>> list = getWeekendWorkList(page, size);
            int totalCount = getTotalCount();
            int totalPages = (int) Math.ceil((double) totalCount / size);

            // 응답 데이터 구성
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("success", true);
            responseData.put("data", list);

            Map<String, Object> pagination = new HashMap<>();
            pagination.put("currentPage", page);
            pagination.put("pageSize", size);
            pagination.put("totalCount", totalCount);
            pagination.put("totalPages", totalPages);
            responseData.put("pagination", pagination);

            response.setStatus(HttpServletResponse.SC_OK);
            out.print(gson.toJson(responseData));

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            JsonObject error = new JsonObject();
            error.addProperty("success", false);
            error.addProperty("message", "잘못된 페이지 파라미터입니다.");
            out.print(gson.toJson(error));
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            JsonObject error = new JsonObject();
            error.addProperty("success", false);
            error.addProperty("message", "서버 오류가 발생했습니다: " + e.getMessage());
            out.print(gson.toJson(error));
        }
    }
    /**
     * 전체 레코드 수를 조회합니다.
     *
     * @return 전체 레코드 수
     */
    private int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM tbl_weekend_work";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 페이징 처리된 주말근무 목록을 조회합니다.
     *
     * @param page 페이지 번호 (1부터 시작)
     * @param size 페이지당 레코드 수
     * @return 주말근무 목록
     */
    private List<Map<String, Object>> getWeekendWorkList(int page, int size) {
        List<Map<String, Object>> list = new ArrayList<>();
        int offset = (page - 1) * size;

        String sql = "SELECT * FROM tbl_weekend_work ORDER BY work_idx DESC, user_id DESC LIMIT ? OFFSET ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, size);
            pstmt.setInt(2, offset);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> work = new HashMap<>();
                    work.put("id", rs.getLong("user_id"));
                    work.put("employeeName", rs.getString("user_name"));
                    work.put("department", rs.getString("user_dept"));
                    work.put("workDate", rs.getDate("work_date").toString());
                    work.put("startTime", rs.getTime("start_at").toString());
                    work.put("endTime", rs.getTime("end_at").toString());
                    work.put("workHours", rs.getDouble("created_at"));
                    work.put("workType", rs.getString("work_flag"));
                    work.put("reason", rs.getString("etc_comment"));
                    work.put("status", rs.getString("confirm_yn"));
                    list.add(work);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
