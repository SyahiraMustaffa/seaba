<%@ page import="java.sql.*,java.text.*,java.util.*" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Include necessary meta tags, styles, and scripts -->
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Seaba Seafood Management System - Overtime</title>

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
        <!-- Include your header and sidebar here -->
        <jsp:include page="includes/header.jsp" />
        <jsp:include page="staff/sidebar.jsp" />

        <!-- Main content -->
        <main id="main" class="main">

            <div class="col-12">
                <div class="card users-list overflow-auto">
                    <div class="card-body">
                        <div class="mt-3">
                            <h2 class="card-title text-center mb-4">Overtime Request</h2>
                            <form action="submitOvertimeRequest.jsp" method="post">
                                <div class="mb-3">
                                    <label for="reason" class="form-label">Reason for Overtime:</label>
                                    <textarea id="reason" name="reason" class="form-control" required></textarea>
                                </div>
                                <div class="text-center">
                                    <button type="submit" class="btn btn-success">Submit Request</button>
                                </div>
                            </form>
                        </div>
                        
                        <%@ include file="viewPendingOvertimeRequest.jsp" %>
                    </div>
                </div>
            </div>

        </main><!-- End #main -->



        <a href="#" class="back-to-top d-flex align-items-center justify-content-center">
            <i class="bi bi-arrow-up-short"></i>
        </a>

        <jsp:include page="includes/script.jsp" />
    </body>

</html>
