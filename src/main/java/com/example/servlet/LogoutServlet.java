package com.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * The type Logout servlet.
 */
@WebServlet ("/logout")
public class LogoutServlet extends HttpServlet {

    /**
     * Do post.
     *
     * @param request  the request
     * @param response the response
     *
     * @throws ServletException the servlet exception
     * @throws IOException      the io exception
     */
    @Override
    protected void doPost (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleLogout (request, response);
    }

    /**
     * Do get.
     *
     * @param request  the request
     * @param response the response
     *
     * @throws ServletException the servlet exception
     * @throws IOException      the io exception
     */
    @Override
    protected void doGet (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleLogout (request, response);
    }

    /**
     * 로그아웃 처리 메서드
     */
    private void handleLogout (HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // 세션 가져오기 (없으면 null 반환)
        HttpSession session = request.getSession (false);

        if (session != null) {
            // 세션 무효화
            session.invalidate ();
        }

        // Accept 헤더 확인하여 JSON 또는 리다이렉트 응답
        String acceptHeader = request.getHeader ("Accept");

        if (acceptHeader != null && acceptHeader.contains ("application/json")) {
            // JSON 응답
            response.setContentType ("application/json; charset=UTF-8");
            response.setStatus (HttpServletResponse.SC_OK);
            PrintWriter out = response.getWriter ();
            out.print ("{\"success\": true, \"message\": \"로그아웃되었습니다.\"}");
        } else {
            // 로그인 페이지로 리다이렉트
            response.sendRedirect (request.getContextPath () + "/login.html");
        }
    }
}
