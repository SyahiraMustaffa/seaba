<%-- 
    Document   : editStaff
    Created on : 16 Jan 2024, 9:19:45 pm
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>SamanSiswa</title>

        <!-- Favicons -->
        <link href="assets/img/seaba raya logo.png" rel="icon">
        <link href="assets/img/SamanSiswa-touch-icon.png" rel="SiswaSaman-touch-icon">

        <!-- Google Fonts -->
        <link href="https://fonts.gstatic.com" rel="preconnect">

        <!-- Vendor CSS Files -->
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
        <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
        <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
        <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
        <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

        <!-- Template Main CSS File -->
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
                <h1>Staff Management</h1>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="manager.jsp">Home</a></li>
                        <li class="breadcrumb-item">Users Management</li>
                        <li class="breadcrumb-item active">Edit Staff</li>
                    </ol>
                </nav>
            </div><!-- End Page Title -->

            <section class="section profile">
                <div class="row">
                    <div class="col-xl-11">
                        <div class="card">
                            <div class="card-body pt-3">
                                <div class="tab-content pt-2">

                                    <%
                                        // Get the user ID from the query string parameter
                                        int staffId = Integer.parseInt(request.getParameter("staffId"));

                                        try {
                                            // Establish db connection
                                            Class.forName("com.mysql.jdbc.Driver");
                                            String myURL = "jdbc:mysql://localhost/seaba";
                                            Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

                                            // Prepare and execute the SQL statement to retrieve the user details
                                            String userQry = "SELECT * FROM staff WHERE staffId=?";
                                            PreparedStatement userPS = myConnection.prepareStatement(userQry);
                                            userPS.setInt(1, staffId);
                                            ResultSet userRS = userPS.executeQuery();

                                            if (userRS.next()) {
                                                // Get the user details
                                                String staffName = userRS.getString("staffName");
                                                String staffEmail = userRS.getString("staffEmail");
                                                String staffPhone = userRS.getString("staffPhone");
                                                String staffRole = userRS.getString("staffRole");
                                                String userType = userRS.getString("userType");

                                                // Close the database resources
                                                userRS.close();
                                                userPS.close();
                                                myConnection.close();

                                                // Display the offense details in the form for editing
                                    %>
                                    <h2>Edit User <%=staffId%></h2>

                                    <form action="updateStaff.jsp" method="POST">
                                        <input type="hidden" name="staffId" value="<%= staffId%>">
                                        <div class="row mb-3">
                                            <label for="text" class="col-md-4 col-lg-3 col-form-label">Name</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="staffName" type="text" class="form-control" id="staffName" value="<%= staffName%>">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="text" class="col-md-4 col-lg-3 col-form-label">Email</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="staffEmail" type="email" class="form-control" id="staffEmail" value="<%= staffEmail%>">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="text" class="col-md-4 col-lg-3 col-form-label">Phone</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="staffPhone" type="text" class="form-control" id="staffPhone" value="<%= staffPhone%>">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="text" class="col-md-4 col-lg-3 col-form-label">Role</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="staffRole" type="text" class="form-control" id="staffRole" value="<%= staffRole%>">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="text" class="col-md-4 col-lg-3 col-form-label">User Type</label>
                                            <div class="col-md-8 col-lg-9">
                                                <select name="userType" type="text" class="form-control" id="userType" value="<%= userType%>">
                                                    <option>Choose Role</option>
                                                    <option>part-time</option>
                                                    <option>full-time</option>

                                                </select>
                                            </div>
                                        </div>

                                        <div class="text-center">
                                            <input type="submit" class="btn btn-primary" value="Update">
                                        </div>
                                    </form>
                                    <%
                                            } else {
                                                // staff not found
                                                out.println("Staff not found");
                                            }
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }
                                    %>


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

