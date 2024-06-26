<%-- 
    Document   : customerProfile
    Created on : 4 May 2024, 12:07:27 pm
    Author     : user
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Display Customer Profile
    String custName = null;
    String custEmail = null;
    String custPhone = null;
    String password = null;

    // Retrieve customer ID from the session after login
    Object customerIdObj = request.getSession().getAttribute("customerId");
    String customerId = (customerIdObj != null) ? customerIdObj.toString() : "";

    // Check if customerId is not empty before proceeding
    if (!customerId.isEmpty()) {
        // Your existing code for fetching customer profile
    } else {
        // Handle the case where customerId is not set in the session
        out.println("Error: Customer ID is not set in the session.");
        return;
    };

    try {
        // Db connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        String myURL = "jdbc:mysql://localhost/seaba";
        Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

        // Prepare and execute the SQL statement
        String profileQry = "SELECT * FROM customers WHERE customerId = ?";
        PreparedStatement profilePS = myConnection.prepareStatement(profileQry);

        try {
            // Ensure customerId is a valid integer
            int parsedCustomerId = 0; // Default value, you can set it to an appropriate default if needed
            try {
                parsedCustomerId = Integer.parseInt(customerId);
            } catch (NumberFormatException ex) {
                // Handle the case where customerId is not a valid integer
            }

            // Set the parameter
            profilePS.setInt(1, parsedCustomerId);

            // Execute the query to retrieve customer profile data
            ResultSet profileRS = profilePS.executeQuery();

            // Check if customer data is retrieved
            if (profileRS.next()) {
                custName = profileRS.getString("custName");
                custEmail = profileRS.getString("custEmail");
                custPhone = profileRS.getString("custPhone");
                password = profileRS.getString("password");
                customerId = profileRS.getString("customerId"); // Update customerId here
            } else {
                // Handle the case where no customer data is retrieved
                out.println("No customer data found for ID: " + parsedCustomerId);
                return;
            }

            // Close the result set
            profileRS.close();
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("SQL Exception during query execution: " + e.getMessage());
        } finally {
            // Close the prepared statement
            profilePS.close();
        }

        // Close the connection
        myConnection.close();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <title>Seaba Seafood Management System - Customer Profile</title>

        <!-- Favicons -->
        <link href="assets/img/favicon.png" rel="icon">
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
        <main id="main" class="main">
            <div class="pagetitle">
                <h1>Customer Profile</h1>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">Home</li>
                        <li class="breadcrumb-item">Customer</li>
                        <li class="breadcrumb-item active">Profile Details</li>
                    </ol>
                </nav>
            </div>

            <section class="section profile">
                <div class="row">
                    <div class="col-xl-4">
                        <div class="card">
                            <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
                                <img src="assets/img/seaba raya logo.png" alt="customer-profiles" class="rounded-circle">
                                <h2><%= custName%></h2>
                                <h3>Customer</h3>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-8">
                        <div class="card">
                            <div class="card-body pt-3">
                                <!-- Bordered Tabs -->
                                <ul class="nav nav-tabs nav-tabs-bordered">
                                    <li class="nav-item">
                                        <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">Overview</button>
                                    </li>

                                    <li class="nav-item">
                                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">Change Password</button>
                                    </li>

                                    <li class="nav-item">
                                        <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-update">Update Profile</button>
                                    </li>
                                </ul>

                                <div class="tab-content pt-2">
                                    <div class="tab-pane fade show active profile-overview" id="profile-overview">
                                        <!-- Display customer profile details -->
                                        <div class="row">
                                            <div class="col-lg-3 col-md-4 label">Customer ID</div>
                                            <div class="col-lg-9 col-md-8"><%= customerId%></div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-3 col-md-4 label">Full Name</div>
                                            <div class="col-lg-9 col-md-8"><%= custName%></div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-3 col-md-4 label">Phone</div>
                                            <div class="col-lg-9 col-md-8"><%= custPhone%></div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-3 col-md-4 label">Email</div>
                                            <div class="col-lg-9 col-md-8"><%= custEmail%></div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-3 col-md-4 label">Password</div>
                                            <div class="col-lg-9 col-md-8">********</div>
                                        </div>
                                    </div>

                    
                                    
                                        <!-- Change Password Form -->
                                        <div class="tab-pane fade pt-3" id="profile-change-password">
                                            <form action="changePassword.jsp" method="POST">
                                                <div class="row mb-3">
                                                    <label for="currentPassword" class="col-md-4 col-lg-3 col-form-label">Current Password</label>
                                                    <div class="col-md-8 col-lg-9">
                                                        <input name="currentpassword" type="password" class="form-control" id="currentPassword" required>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">New Password</label>
                                                    <div class="col-md-8 col-lg-9">
                                                        <input name="newpassword" type="password" class="form-control" id="newPassword" required>
                                                    </div>
                                                </div>

                                                <div class="row mb-3">
                                                    <label for="confirmPassword" class="col-md-4 col-lg-3 col-form-label">Confirm Password</label>
                                                    <div class="col-md-8 col-lg-9">
                                                        <input name="confirmpassword" type="password" class="form-control" id="confirmPassword" required>
                                                    </div>
                                                </div>

                                                <div class="text-center">
                                                    <button type="submit" class="btn btn-primary">Change Password</button>
                                                </div>
                                            </form>
                                        </div>

                                    </div>

                                    <!-- Update Profile Form -->
                                    <div class="tab-pane fade pt-3" id="profile-update">
                                        <form action="editCustomerProfile.jsp" method="POST">
                                            <div class="row">
                                                <div class="col-lg-3 col-md-4 label">Full Name</div>
                                                <div class="col-lg-9 col-md-8">
                                                    <input name="name" type="text" class="form-control" value="<%= custName%>">
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-lg-3 col-md-4 label">Phone</div>
                                                <div class="col-lg-9 col-md-8">
                                                    <input name="phone" type="text" class="form-control" value="<%= custPhone%>">
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-lg-3 col-md-4 label">Email</div>
                                                <div class="col-lg-9 col-md-8">
                                                    <input name="email" type="email" class="form-control" value="<%= custEmail%>">
                                                </div>
                                            </div>

                                            <!-- Customer ID (hidden input) -->
                                            <input type="hidden" name="customerId" value="<%= customerId%>">

                                            <div class="text-center">
                                                <button type="submit" class="btn btn-primary">Update Profile</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                
            </section>
        </main>
    </body>
</html>
