<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.Date" %>

<%
    // In a real application, handle updating the password in the database
    String password = request.getParameter("password");

    // Redirect to success page
    response.sendRedirect("success.jsp");
%>
