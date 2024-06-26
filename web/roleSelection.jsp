<%-- 
    Document   : roleSelection
    Created on : 3 Jan 2024, 10:54:13 pm
    Author     : syera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Seaba Seafood Management System - Role Selection</title>

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
        <style>
            body {
                background-image: url('assets/img/beach.jpg');
                background-size: cover;
                background-repeat: no-repeat;
                background-attachment: fixed;
            }
        </style>
    </head>
    <body>
        <!-- Role Selection Page Content -->
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-4 col-md-6 text-center">
                    <div class="mt-5">
                        <!-- Include the logo with the correct path -->
                        <img src="assets/img/seaba raya logo.png" alt="Seaba Logo" class="mb-3" style="max-width: 200px;">
                        <h1>Welcome to Seaba Seafood</h1>
                        <p>Please select your role:</p>
                        <div class="mt-3">
                            <a href="customerLogin.jsp" class="btn btn-primary">Customer</a>
                            <a href="staffManagerLogin.jsp" class="btn btn-secondary">Staff</a>
                            <a href="ManagerLogin.jsp" class="btn btn-secondary">Manager</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

    <!-- ... (remaining HTML code) ... -->

</html>
