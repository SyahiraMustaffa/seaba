<%-- 
    Document   : addStaff
    Created on : 16 Jan 2024, 10:07:50 pm
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Seaba Seafood Management System - Add Staff</title>

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
        <!-- ======= Header ======= -->
        <jsp:include page = "includes/header.jsp"/>

        <!-- ======= Sidebar ======= -->
        <jsp:include page = "manager/sidebar.jsp"/>

        <!-- ======= User ========== -->
        <main id="main" class="main">
            <div class="pagetitle">
                <h1>Seaba Management</h1>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="manager.jsp">Home</a></li>
                        <li class="breadcrumb-item">Seaba Management</li>
                        <li class="breadcrumb-item active">Add New Staff</li>
                    </ol>
                </nav>
            </div><!-- End Page Title -->

            <section class="section profile">
                <div class="row">
                    <div class="col-xl-11">

                        <div class="card">
                            <div class="card-body pt-3">

                                <div class="tab-content pt-2">
                                    <form action="processNewStaff.jsp" method="POST">
                                        <div class="row mb-3">
                                            <label for="text" class="col-md-4 col-lg-3 col-form-label">Name</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="staffName" type="text" class="form-control" id="staffName" placeholder="Enter Full Name">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="text" class="col-md-4 col-lg-3 col-form-label">Email</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="staffEmail" type="email" class="form-control" id="staffEmail" placeholder="Enter Email">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="text" class="col-md-4 col-lg-3 col-form-label">Phone</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="staffPhone" type="text" class="form-control" id="staffPhone" placeholder="Enter Phone No.">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="text" class="col-md-4 col-lg-3 col-form-label">Role</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="staffRole" type="text" class="form-control" id="staffRole" placeholder="Role">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="text" class="col-md-4 col-lg-3 col-form-label">User Type</label>
                                            <div class="col-md-8 col-lg-9">
                                                <select name="userType" id="userType" class="form-control">
                                                    <option>Choose Role</option>
                                                    <option>part-time</option>
                                                    <option>full-time</option>

                                                </select>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="text" class="col-md-4 col-lg-3 col-form-label">Password</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="password" type="password" class="form-control" id="password" placeholder="Enter Password">
                                            </div>
                                        </div>

                                        <div class="text-center">
                                            <input type="submit" class="btn btn-primary" value="Add New Staff">
                                        </div>
                                    </form>

                                </div><!-- End Bordered Tabs -->

                            </div>
                        </div>

                    </div>
                </div>
            </section>

        </main><!-- End #main -->
        <!-- ======= Footer ======= -->
        <jsp:include page = "includes/footer.jsp"/>

        <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

        <jsp:include page = "includes/script.jsp"/>
    </body>
</html>

