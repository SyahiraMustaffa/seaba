<%@ page import="java.sql.*, java.text.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
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
        <jsp:include page="manager/sidebar.jsp" />

        <%
            // Your database connection code to retrieve staff overtime data
            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultSet = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String jdbcURL = "jdbc:mysql://localhost/seaba";
                String dbUser = "root";
                String dbPassword = "admin";
                connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                // Retrieve the list of all staff with their updated overtime requests based on requestId
                String retrieveAllOvertimeListSql = "SELECT * FROM overtimerequests";
                preparedStatement = connection.prepareStatement(retrieveAllOvertimeListSql);
                resultSet = preparedStatement.executeQuery();
        %>

        <!-- Main content -->
        <main id="main" class="main">
            <div class="col-12">
                <div class="card all-overtime-requests">
                    <div class="card-body">
                        <h5 class="card-title">All Overtime Requests</h5>

                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th scope="col">Request ID</th>
                                    <th scope="col">Staff ID</th>
                                    <th scope="col">Reason</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    while (resultSet.next()) {
                                        int requestId = resultSet.getInt("requestId");
                                        int staffIdValue = resultSet.getInt("staffId");
                                        String reason = resultSet.getString("reason");
                                        String status = resultSet.getString("status");
                                        String badgeColor = "";

                                        // Set badge color based on status
                                        switch (status) {
                                            case "Pending":
                                                badgeColor = "warning";
                                                break;
                                            case "Accepted":
                                                badgeColor = "success";
                                                break;
                                            case "Rejected":
                                                badgeColor = "danger";
                                                break;
                                        }
                                %>
                                <tr>
                                    <td><%= requestId%></td>
                                    <td><%= staffIdValue%></td>
                                    <td><%= reason%></td>
                                    <td><span class="badge bg-<%= badgeColor%>"><%= status%></span></td>
                                    <td>
                                        <% if (status.equals("Pending")) {%>
                                        <form method="post" action="processOvertimeRequest.jsp">
                                            <input type="hidden" name="requestId" value="<%= requestId%>">
                                            <button type="submit" name="action" value="accept" class="btn btn-success">Accept</button>
                                            <button type="submit" name="action" value="reject" class="btn btn-danger">Reject</button>
                                        </form>
                                        <% } else { %>
                                        <!-- Display some placeholder or disabled buttons for non-Pending status -->
                                        <button type="button" class="btn btn-secondary" disabled>Accept</button>
                                        <button type="button" class="btn btn-secondary" disabled>Reject</button>
                                        <% } %>
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main><!-- End #main -->

        <%
            } catch (SQLException | ClassNotFoundException e) {
                // Display error alert with exception message
                out.println("<script>showAlert('An unexpected error occurred: " + e.getMessage() + "', 'alert-danger');</script>");
                e.printStackTrace();
            } finally {
                // ... (your existing closing database resources code) ...
            }
        %>

        <a href="#" class="back-to-top d-flex align-items-center justify-content-center">
            <i class="bi bi-arrow-up-short"></i>
        </a>

        <jsp:include page="includes/script.jsp" />
    </body>
</html>
