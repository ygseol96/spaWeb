package com.example.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * 세션 체크 필터
 * 로그인이 필요한 페이지에 접근 시 세션을 확인하고,
 * 세션이 없으면 로그인 페이지로 리다이렉트합니다.
 */
@WebFilter("/*")
public class SessionCheckFilter implements Filter {

    // 로그인 없이 접근 가능한 URL 패턴
    private static final List<String> EXCLUDE_URLS = Arrays.asList(
            "/login.html",
            "/login",
            "/index.html",
            "/logout"
    );

    // 정적 리소스 확장자
    private static final List<String> STATIC_EXTENSIONS = Arrays.asList(
            ".css", ".js", ".jpg", ".jpeg", ".png", ".gif", ".ico", ".svg", ".woff", ".woff2", ".ttf"
    );

    /**
     * Init.
     *
     * @param filterConfig the filter config
     * @throws ServletException the servlet exception
     */
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 필터 초기화 (필요시 설정 로드)
        System.out.println("SessionCheckFilter initialized");
    }

    /**
     * Do filter.
     *
     * @param request  the request
     * @param response the response
     * @param chain    the chain
     * @throws IOException      the io exception
     * @throws ServletException the servlet exception
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());

        // 루트 경로 처리
        if (path.isEmpty() || path.equals("/")) {
            path = "/index.html";
        }

        // 제외 URL 체크
        if (isExcludedUrl(path)) {
            chain.doFilter(request, response);
            return;
        }

        // 정적 리소스 체크
        if (isStaticResource(path)) {
            chain.doFilter(request, response);
            return;
        }

        // 세션 체크
        HttpSession session = httpRequest.getSession(false);
        Boolean isLoggedIn = (session != null) ? (Boolean) session.getAttribute("isLoggedIn") : null;

        if (isLoggedIn != null && isLoggedIn) {
            // 로그인된 상태 - 요청 계속 진행
            chain.doFilter(request, response);
        } else {
            // 로그인되지 않은 상태
            // AJAX 요청인지 확인
            String requestedWith = httpRequest.getHeader("X-Requested-With");
            String acceptHeader = httpRequest.getHeader("Accept");

            if ("XMLHttpRequest".equals(requestedWith) ||
                    (acceptHeader != null && acceptHeader.contains("application/json"))) {
                // AJAX 요청인 경우 JSON 응답
                httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                httpResponse.setContentType("application/json; charset=UTF-8");
                httpResponse.getWriter().write("{\"success\": false, \"message\": \"로그인이 필요합니다.\", \"redirect\": \"/login.html\"}");
            } else {
                // 일반 요청인 경우 로그인 페이지로 리다이렉트
                httpResponse.sendRedirect(contextPath + "/login.html");
            }
        }
    }

    /**
     * Destroy.
     */
    @Override
    public void destroy() {
        // 필터 종료 시 정리 작업
        System.out.println("SessionCheckFilter destroyed");
    }

    /**
     * 제외 URL 체크
     */
    private boolean isExcludedUrl(String path) {
        return EXCLUDE_URLS.stream().anyMatch(path::startsWith);
    }

    /**
     * 정적 리소스 체크
     */
    private boolean isStaticResource(String path) {
        return STATIC_EXTENSIONS.stream().anyMatch(path::endsWith);
    }
}
