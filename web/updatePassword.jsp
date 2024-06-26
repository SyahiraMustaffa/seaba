<%-- 
    Document   : updatePassword
    Created on : 23 Jun 2024, 3:29:08 am
    Author     : user
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.UUID" %>

<%
    String token = request.getParameter("token");
    String sessionToken = (String) session.getAttribute("token");

    if (sessionToken != null && sessionToken.equals(token)) {
%>
<!DOCTYPE html>
<html>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Seaba Seafood Management System - Update Password</title>

    <!-- Favicons -->
    <link href="assets/img/seaba raya logo.png" rel="icon">
    <link href="assets/img/SeabaSeafood-touch-icon.png" rel="SeabaSeafood-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">

    <!-- Vendor CSS Files -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">
</head>
<body>
    <h2>Update Your Password</h2>
    <form action="updatePassword.jsp" method="post">
        Enter a new password:
        <input type="password" name="password" required>
        <button type="submit">Update Password</button>
    </form>
</body>
</html>
<%
    } else {
        response.getWriter().println("Invalid or expired token.");
    }
%>
