<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.gson.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
    // JSP 브릿지: Servlet으로 요청을 전달
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    request.getRequestDispatcher("/work").forward(request, response);
%>
