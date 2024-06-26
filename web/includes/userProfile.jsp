<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java"%>
<%@page import="java.sql.*"%>

<%
    // Display User Profile
    String staffName = null;
    String staffEmail = null;
    String staffPhone = null;
    String staffRole = null;
    String userType = null;

    // Retrieve user ID from the session after login
    Object staffIdObj = request.getSession().getAttribute("staffId");
    String staffId = " ";

    if (staffIdObj != null) {
        staffId = staffIdObj.toString();

        try {
            // Db connection
            Class.forName("com.mysql.jdbc.Driver");
            String myURL = "jdbc:mysql://localhost/seaba";
            Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

            // Prepare and execute the SQL statement
            String profileQry = "SELECT * FROM staff WHERE staffId = ?";
            PreparedStatement profilePS = myConnection.prepareStatement(profileQry);
            profilePS.setString(1, staffId);

            // Execute the query to retrieve user profile data
            ResultSet profileRS = profilePS.executeQuery();

            // Check if user data is retrieved
            if (profileRS.next()) {
                staffName = profileRS.getString("staffName");
                staffEmail = profileRS.getString("staffEmail");
                staffPhone = profileRS.getString("staffPhone");
                staffRole = profileRS.getString("staffRole");
                userType = profileRS.getString("userType");
            } else {
                // Handle the case where no user data is retrieved
                out.println("No user data found for ID: " + staffId);
            }

            // Close the result set, prepared statement, and connection
            profileRS.close();
            profilePS.close();
            myConnection.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    // Retrieve success message from the session
    String successMessage = (String) session.getAttribute("successMessage");

    // Clear the success message from the session
    session.removeAttribute("successMessage");
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Seaba Seafood Management System - Profile</title>

        <!-- Favicons -->
        <link href="assets/img/favicon.png" rel="icon">
        <link href="assets/img/SeabaSeafood-touch-icon.png" rel="SeabaSeafood-touch-icon">

        <!-- Google Fonts -->
        <link href="https://fonts.gstatic.com" rel="preconnect">

        <!-- Vendor CSS Files -->
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">
    </head>

    <body>
        <!-- Main Content -->
        <main id="main" class="main">
            <div class="pagetitle">
                <h1>Profile Details</h1>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">Home</li>
                        <li class="breadcrumb-item">Users</li>
                        <li class="breadcrumb-item active">Profile Details</li>
                    </ol>
                </nav>
            </div><!-- End Page Title -->

            <section class="section profile">
                <div class="row">
                    <div class="col-xl-4">
                        <div class="card">
                            <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
                                <img src="assets/img/profile.jpg" alt="staff-profiles" class="rounded-circle">
                                <h2><%= staffName%></h2>
                                <h3><%= staffRole%></h3>
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
                                            <div class="col-lg-3 col-md-4 label">Full Name</div>
                                            <div class="col-lg-9 col-md-8"><%= staffName%></div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-3 col-md-4 label">ID Number</div>
                                            <div class="col-lg-9 col-md-8"><%= staffId%></div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-3 col-md-4 label">Phone</div>
                                            <div class="col-lg-9 col-md-8"><%= staffPhone%></div>
                                        </div>

                                        <div class="row">
                                            <div class="col-lg-3 col-md-4 label">Email</div>
                                            <div class="col-lg-9 col-md-8"><%= staffEmail%></div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-3 col-md-4 label">User Type</div>
                                            <div class="col-lg-9 col-md-8"><%= userType%></div>
                                        </div>
                                    </div>

                                    <div class="tab-pane fade pt-3" id="profile-change-password">
                                        <!-- Change Password Form -->
                                        <form action="editPassword.jsp" method="POST">
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

                                    <div class="tab-pane fade pt-3" id="profile-update">
                                        <!-- Update Profile Form (Create a separate JSP for this) -->
                                        <form action="editProfile.jsp" method="POST">
                                           

                              
                                            <!-- Full Name -->
                                            <div class="row">
                                                <div class="col-lg-3 col-md-4 label">Full Name</div>
                                                <div class="col-lg-9 col-md-8">
                                                    <input name="staffName" type="text" class="form-control" value="<%= staffName%>">
                                                </div>
                                            </div>

                                            <!-- Phone -->
                                            <div class="row">
                                                <div class="col-lg-3 col-md-4 label">Phone</div>
                                                <div class="col-lg-9 col-md-8">
                                                    <input name="staffPhone" type="text" class="form-control" value="<%= staffPhone%>">
                                                </div>
                                            </div>

                                            <!-- Email -->
                                            <div class="row">
                                                <div class="col-lg-3 col-md-4 label">Email</div>
                                                <div class="col-lg-9 col-md-8">
                                                    <input name="staffEmail" type="email" class="form-control" value="<%= staffEmail%>">
                                                </div>
                                            </div>


                                           
                                            <!-- Staff ID (hidden input) -->
                                           <input type="hidden" name="staffId" value="<%= staffId%>">

                                            <!-- Update Profile Button -->

                                            <div class="text-center">
                                                <button type="submit" class="btn btn-primary">Update Profile</button>
                                            </div>

                                        </form><!-- End Update Profile Form -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main><!-- End #main -->

        <!-- ... (additional content) -->

        <!-- ... (scripts and other dependencies) -->

        <!-- JavaScript code to handle redirection -->
        <script>
            // Check if the success message exists and redirect after 2 seconds
            /*if ("<%= successMessage%>" !== "") {
             setTimeout(function() {
             window.location.href = "userProfile.jsp";
             }, 2000); // Redirect after 2 seconds (2000 milliseconds)
             }*/
        </script>
    </body>
</html>

