<%@ page import="java.sql.*" %>
<%@ page session="false" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>

<%@ page session="false" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Assuming you have the customer ID stored in session
    HttpSession session = request.getSession();
    int customerId = (int) session.getAttribute("customerId"); // Adjust this to retrieve the customer ID properly

    // Replace these with your actual database credentials
    String url = "jdbc:mysql://localhost:3306/seaba";
    String username = "root";
    String password = "admin";

    // Variables to store customer data
    String custName = "";
    String custEmail = "";

    // Database connection objects
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection to the database
        conn = DriverManager.getConnection(url, username, password);

        // Prepare the SQL query to retrieve customer's name and email
        String sql = "SELECT name, email FROM customer WHERE id = ?";
        pstmt = conn.prepareStatement(sql);

        // Set the customer ID parameter in the SQL query
        pstmt.setInt(1, customerId);

        // Execute the query to retrieve customer data
        rs = pstmt.executeQuery();

        // Process the result set
        if (rs.next()) {
            custName = rs.getString("name");
            custEmail = rs.getString("email");
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        // Close the database resources
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (pstmt != null) {
                pstmt.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Seaba Seafood Management System - Contact</title>

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

        <!-- Main Content -->
        <main id="main" class="main">
            <div class="container">
                <div class="pagetitle">
                    <h1>Contact</h1>
                    <nav>
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                            <li class="breadcrumb-item">Pages</li>
                            <li class="breadcrumb-item active">Contact</li>
                        </ol>
                    </nav>
                </div><!-- End Page Title -->

                <section class="section contact">
                    <div class="row">
                        <div class="col-xl-6">
                            <div class="row">
                                <div class="col-lg-6 mb-4">
                                    <div class="card info-box">
                                        <i class="bi bi-geo-alt"></i>
                                        <h3>Address</h3>
                                        <p>Pantai Batu Hitam,<br>Kuantan, Pahang</p>
                                    </div>
                                </div>
                                <div class="col-lg-6 mb-4">
                                    <div class="card info-box">
                                        <i class="bi bi-telephone"></i>
                                        <h3>Call Us</h3>
                                        <p>+1 5589 55488 55<br>+1 6678 254445 41</p>
                                    </div>
                                </div>
                                <div class="col-lg-6 mb-4">
                                    <div class="card info-box">
                                        <i class="bi bi-envelope"></i>
                                        <h3>Email Us</h3>
                                        <p>seabaseafod@gmail.com</p>
                                    </div>
                                </div>
                                <div class="col-lg-6 mb-4">
                                    <div class="card info-box">
                                        <i class="bi bi-clock"></i>
                                        <h3>Open Hours</h3>
                                        <p>Tuesday - Sunday<br>10:00AM - 12:00AM</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-6">
                            <div class="card p-4">
                                <form action="processContact.jsp" method="post" >
                                    <div class="form-group">
                                        <label for="name">Your Name:</label>
                                        <input type="text" class="form-control" id="name" name="name" value="<%= custName%>" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Your Email:</label>
                                        <input type="email" class="form-control" id="email" name="email" value="<%= custEmail%>" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="subject">Subject:</label>
                                        <input type="text" class="form-control" id="subject" name="subject" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="message">Message:</label>
                                        <textarea class="form-control" id="message" name="message" rows="5" required></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Send Message</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </section>
            </div><!-- /.container -->

            <%@ include file="includes/footer.jsp" %>
            <%@ include file="includes/script.jsp" %>

        </main><!-- End #main -->




    </body>
    <%@ include file="customer/header.jsp" %>
    <%@ include file="customer/sidebar.jsp" %>
</html>
