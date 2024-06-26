<%-- 
    Document   : customer
    Created on : 4 May 2024, 12:06:14 pm
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
    <jsp:include page="customer/header.jsp" />

    <!-- ======= Sidebar ======= -->
    <jsp:include page="customer/sidebar.jsp" />

    <!-- ======= Staff Profile ======= -->
    <jsp:include page="customer/customerProfile.jsp" />

    <!-- ======= Footer ======= -->
    <jsp:include page="includes/footer.jsp" />

 
    <!-- Include the shared script -->
    <jsp:include page="includes/script.jsp" />
</body>

</html>

