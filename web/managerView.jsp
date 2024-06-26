<%@ page import="java.sql.*" %>
<%@ page session="false" %>

<%
    // Replace these with your actual database credentials
    String url = "jdbc:mysql://localhost:3306/seaba";
    String username = "root";
    String password = "admin";

    // Database connection objects
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection to the database
        conn = DriverManager.getConnection(url, username, password);

        // Retrieve customer IDs and names
        String sql = "SELECT id, name FROM customers";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        // Display list of customers and links to view their form submissions
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Seaba Seafood Management System - Customer Message</title>

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
        <div class="container mt-5">
            <h1>Manager View - Form Submissions</h1>
            <table class="table">
                <thead>
                    <tr>
                        <th>Customer ID</th>
                        <th>Customer Name</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%    while (rs.next()) {
                            int customerId = rs.getInt("id");
                            String custName = rs.getString("name");
                    %>
                    <tr>
                        <td><%= customerId%></td>
                        <td><%= custName%></td>
                        <td><a href="viewMessage.jsp?customerId=<%= customerId%>" class="btn btn-primary">View Form Submissions</a></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        <!-- ======= Header ======= -->
        <jsp:include page="includes/header.jsp" />

        <!-- ======= Sidebar ======= -->
        <jsp:include page="manager/sidebar.jsp" />

        <!-- ======= Footer ======= -->
        <jsp:include page="includes/footer.jsp" />

        <!-- Include the shared script -->
        <jsp:include page="includes/script.jsp" />
    </body>
</html>
<%
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        // Close the database resources
        try {
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
