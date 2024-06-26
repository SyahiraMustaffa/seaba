<%-- 
    Document   : registerCustomer
    Created on : 19 Jan 2024, 11:51:23 pm
    Author     : user
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Seaba Seafood Management System - Customer Registration</title>

        <!-- Favicons -->
        <link href="assets/img/seaba raya logo.png" rel="icon">
        <link rel="SeabaSeafood-touch-icon" href="assets/img/SeabaSeafood-touch-icon.png">

        <!-- Google Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">

        <!-- Vendor CSS Files -->
        <link rel="stylesheet" href="assets/vendor/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/vendor/bootstrap-icons/bootstrap-icons.css">
        <link rel="stylesheet" href="assets/css/style.css">
    </head>

    <body>
        <!-- Staff/Manager Registration Page Content -->
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-4 col-md-6">
                    <div class="card mt-5">
                        <div class="card-body">
                            <h5 class="card-title text-center">Customer Registration</h5>
                            <form action="registerCustomerLogic.jsp" method="POST" class="row g-3 needs-validation">
                                <!-- Your form fields for registration -->
                                <div class="col-12">
                                    <label for="staffName" class="form-label">Name</label>
                                    <input type="text" name="custName" class="form-control" id="custName" required placeholder="Enter Name">
                                </div>
                                <div class="col-12">
                                    <label for="custEmail" class="form-label">Email</label>
                                    <input type="email" name="custEmail" class="form-control" id="custEmail" required placeholder="Enter Email">
                                </div>
                                <div class="col-12">
                                    <label for="custPhone" class="form-label">Phone</label>
                                    <input type="text" name="custPhone" class="form-control" id="custPhone" required placeholder="Enter Phone">
                                </div>
                                <div class="col-12">
                                    <label for="password" class="form-label">Password</label>
                                    <input type="text" name="password" class="form-control" id="password" required placeholder="Enter Password">
                                </div>
   

                                <!-- Add other fields as needed -->

                                <div class="col-12">
                                    <button class="btn btn-primary w-100" type="submit">Register</button>
                                </div>
                            </form>
                            <div class="text-center mt-3">
                                <p class="small">Already have an account? <a href="customerLogin.jsp">Login here</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Display Registration Status Message -->
        <div class="container mt-3">
            <% if (request.getParameter("registrationStatus") != null) {%>
            <div class="alert alert-dismissible fade show <%= request.getParameter("registrationStatus")%>" role="alert">
                <strong><%= request.getParameter("registrationMessage")%></strong>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% }%>
        </div>
    </body>

</html>

