<%-- 
    Document   : staff
    Created on : 5 Jan 2024, 4:11:23 pm
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Seaba Seafood Management System - Staff Profile</title>

    <!-- Favicons -->
    <link href="assets/img/seaba raya logo.png" rel="icon">
    <link href="assets/img/SeabaSeafood-touch-icon.png" rel="SeabaSeafood-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">

    <!-- Vendor CSS Files -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">

    <!-- Include the shared CSS -->
    <link href="assets/css/shared-style.css" rel="stylesheet">
</head>

<body>
    <!-- ======= Header ======= -->
    <jsp:include page="includes/header.jsp" />

    <!-- ======= Sidebar ======= -->
    <jsp:include page="staff/sidebar.jsp" />

    <!-- ======= Staff Profile ======= -->
    <jsp:include page="includes/userProfile.jsp" />

    <!-- ======= Footer ======= -->
    <jsp:include page="includes/footer.jsp" />

 
    <!-- Include the shared script -->
    <jsp:include page="includes/script.jsp" />
</body>

</html>
