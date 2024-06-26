<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Display Manager Profile
    String name = null;
    String email = null;
    String phone = null;
    String role = "Manager"; // Assuming the role is fixed for the manager

    // Retrieve manager ID from the session after login
    Object managerIdObj = request.getSession().getAttribute("managerId");
    String managerId = (managerIdObj != null) ? managerIdObj.toString() : "";

    // Check if managerId is not empty before proceeding
    if (!managerId.isEmpty()) {
        // Your existing code for fetching manager profile
    } else {
        // Handle the case where managerId is not set in the session
        out.println("Error: Manager ID is not set in the session.");
    };

    try {
        // Db connection
//        out.println("Connecting to the database...");
        Class.forName("com.mysql.cj.jdbc.Driver");
        String myURL = "jdbc:mysql://localhost/seaba";
        Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");
//        out.println("Connected to the database.");

        // ...
// Prepare and execute the SQL statement//
//out.println("Manager ID from session: " + managerId);
        String profileQry = "SELECT * FROM manager_table WHERE managerId = ?";
//out.println("SQL Query: " + profileQry);//

        PreparedStatement profilePS = myConnection.prepareStatement(profileQry);

        try {
            // Ensure managerId is a valid integer
            int parsedManagerId = 0; // Default value, you can set it to an appropriate default if needed
            try {
                parsedManagerId = Integer.parseInt(managerId);
//     out.println("Parsed Manager ID: " + parsedManagerId);
            } catch (NumberFormatException ex) {
                // Handle the case where managerId is not a valid integer
//        out.println("Error: Manager ID is not a valid integer");
            }

            // Set the parameter
            profilePS.setInt(1, parsedManagerId);

            // Execute the query to retrieve manager profile data
//    out.println("Executing query...");
            ResultSet profileRS = profilePS.executeQuery();

            // Check if manager data is retrieved
            if (profileRS.next()) {
                name = profileRS.getString("name");
                email = profileRS.getString("email");
                phone = profileRS.getString("phone");
                role = profileRS.getString("role");

//        // Additional debug statements
//        out.println("Name from ResultSet: " + name);
//        out.println("Email from ResultSet: " + email);
//        out.println("Phone from ResultSet: " + phone);
//        out.println("Role from ResultSet: " + role);
            } else {
                // Handle the case where no manager data is retrieved
                out.println("No manager data found for ID: " + parsedManagerId);
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

// ...
        // Close the connection
        myConnection.close();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
    // Retrieve success message from the session
    String successMessage = (String) session.getAttribute("successMessage");

    // Clear the success message from the session
    session.removeAttribute("successMessage");
//    // Add debugging statements
//    out.println("Name: " + name);
//    out.println("Email: " + email);
//    out.println("Phone: " + phone);
//    out.println("Role: " + role);
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <title>Seaba Seafood Management System - Manager Profile</title>

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
                <h1>Manager Profile</h1>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">Home</li>
                        <li class="breadcrumb-item">Manager</li>
                        <li class="breadcrumb-item active">Profile Details</li>
                    </ol>
                </nav>
            </div>

            <section class="section profile">
                <div class="row">
                    <div class="col-xl-4">
                        <div class="card">
                            <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
                                <img src="assets/img/seaba raya logo.png" alt="staff-profiles" class="rounded-circle">
                                <h2><%= name%></h2>
                                <h3><%= role%></h3>
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
                                        <%-- Display success message if it exists --%>
                                        <% if (successMessage != null && !successMessage.isEmpty()) {%>
                                        <div class="alert alert-success" role="alert">
                                            <%= successMessage%>
                                        </div>
                                        <% }%>
                                        <h5 class="card-title">Profile Details</h5>

                                        <div class="row">
                                            <div class="col-lg-3 col-md-4 label">Manager ID</div>
                                            <div class="col-lg-9 col-md-8"><%= managerId%></div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-3 col-md-4 label">Full Name</div>
                                            <div class="col-lg-9 col-md-8"><%= name%></div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-3 col-md-4 label">Phone</div>
                                            <div class="col-lg-9 col-md-8"><%= phone%></div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-3 col-md-4 label">Email</div>
                                            <div class="col-lg-9 col-md-8"><%= email%></div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-3 col-md-4 label">Role</div>
                                            <div class="col-lg-9 col-md-8"><%= role%></div>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade pt-3" id="profile-change-password">
                                        <!-- Change Password Form -->
                                        <form action="editManagerProfile.jsp" method="POST">
                                            <div class="row mb-3">
                                                <label for="newPassword" class="col-md-4 col-lg-3 col-form-label">New Password</label>
                                                <div class="col-md-8 col-lg-9">
                                                    <input name="newpassword" type="password" class="form-control" id="newPassword">
                                                </div>
                                            </div>

                                            <div class="text-center">
                                                <button type="submit" class="btn btn-primary">Change Password</button>
                                            </div>
                                        </form><!-- End Change Password Form -->
                                    </div>

                                    <!-- ... (existing code) -->

                                    <div class="tab-pane fade pt-3" id="profile-update">
                                        <!-- Update Profile Form -->
                                        <form action="editManagerProfile.jsp" method="POST">

                                            <!-- Full Name -->
                                            <div class="row">
                                                <div class="col-lg-3 col-md-4 label">Full Name</div>
                                                <div class="col-lg-9 col-md-8">
                                                    <input name="name" type="text" class="form-control" value="<%= name%>">
                                                </div>
                                            </div>

                                            <!-- Phone -->
                                            <div class="row">
                                                <div class="col-lg-3 col-md-4 label">Phone</div>
                                                <div class="col-lg-9 col-md-8">
                                                    <input name="phone" type="text" class="form-control" value="<%= phone%>">
                                                </div>
                                            </div>

                                            <!-- Email -->
                                            <div class="row">
                                                <div class="col-lg-3 col-md-4 label">Email</div>
                                                <div class="col-lg-9 col-md-8">
                                                    <input name="email" type="email" class="form-control" value="<%= email%>">
                                                </div>
                                            </div>

                                            <!-- Manager ID (hidden input) -->
                                            <input type="hidden" name="managerId" value="<%= managerId%>">

                                            <!-- Update Profile Button -->
                                            <div class="text-center">
                                                <button type="submit" class="btn btn-primary">Update Profile</button>
                                            </div>

                                        </form><!-- End Update Profile Form -->
                                    </div>

                                    <!-- ... (existing code) -->

                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </section>
        </main>


    </body>
</html>
