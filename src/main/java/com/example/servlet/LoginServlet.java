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
 * The type Login servlet.
 */
@WebServlet ("/login")
public class LoginServlet extends HttpServlet {

    /**
     * Do post.
     *
     * @param request
     *         the request
     * @param response
     *         the response
     *
     * @throws ServletException
     *         the servlet exception
     * @throws IOException
     *         the io exception
     */
    @Override
    protected void doPost (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 한글 인코딩 설정
        request.setCharacterEncoding ("UTF-8");
        response.setContentType ("application/json; charset=UTF-8");

        // 요청 파라미터 가져오기
        String username = request.getParameter ("username");
        String password = request.getParameter ("password");

        PrintWriter out = response.getWriter ();

        // 입력값 검증
        if (username == null || username.trim ().isEmpty () ||
                password == null || password.trim ().isEmpty ()) {
            response.setStatus (HttpServletResponse.SC_BAD_REQUEST);
            out.print ("{\"success\": false, \"message\": \"아이디와 비밀번호를 입력해주세요.\"}");
            return;
        }

        // 사용자 인증 (실제 환경에서는 데이터베이스 조회)
        // 데모용: admin/admin123
        if (authenticate (username, password)) {
            // 세션 생성
            HttpSession session = request.getSession (true);
            session.setAttribute ("isLoggedIn", true);
            session.setAttribute ("username", username);
            session.setAttribute ("loginTime", System.currentTimeMillis ());

            // 세션 타임아웃 설정 (30분)
            session.setMaxInactiveInterval (30 * 60);

            // 성공 응답
            response.setStatus (HttpServletResponse.SC_OK);
            out.print ("{\"success\": true, \"message\": \"로그인 성공\", \"username\": \"" + username + "\"}");
        } else {
            // 실패 응답
            response.setStatus (HttpServletResponse.SC_UNAUTHORIZED);
            out.print ("{\"success\": false, \"message\": \"아이디 또는 비밀번호가 올바르지 않습니다.\"}");
        }
    }

    /**
     * Do get.
     *
     * @param request
     *         the request
     * @param response
     *         the response
     *
     * @throws ServletException
     *         the servlet exception
     * @throws IOException
     *         the io exception
     */
    @Override
    protected void doGet (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // GET 요청은 허용하지 않음
        response.setStatus (HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        response.setContentType ("application/json; charset=UTF-8");
        PrintWriter out = response.getWriter ();
        out.print ("{\"success\": false, \"message\": \"POST 메서드만 허용됩니다.\"}");
    }

    /**
     * 사용자 인증 메서드
     * 실제 환경에서는 데이터베이스와 연동하여 사용자 정보를 확인해야 합니다.
     *
     * @param username
     *         사용자 아이디
     * @param password
     *         비밀번호
     *
     * @return 인증 성공 여부
     */
    private boolean authenticate (String username, String password) {
        // 데모용 하드코딩된 인증
        // 실제 환경에서는 데이터베이스 조회 및 비밀번호 해시 비교
        return "admin".equals (username) && "admin123".equals (password);
    }
}
