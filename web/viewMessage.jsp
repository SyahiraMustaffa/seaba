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

        // Retrieve customer ID from request parameter
        int customerId = Integer.parseInt(request.getParameter("customerId"));

        // Retrieve customer details
        String sql = "SELECT name, email FROM customers WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, customerId);
        rs = pstmt.executeQuery();

        String custName = "";
        String custEmail = "";

        if (rs.next()) {
            custName = rs.getString("name");
            custEmail = rs.getString("email");
        }

        // Fetch submitted form details
        sql = "SELECT subject, message FROM submitted_forms WHERE customerId = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, customerId);
        rs = pstmt.executeQuery();

%>
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Form Submissions for <%= custName %></title>
            <!-- Bootstrap CSS -->
            <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        </head>
        <body>
            <div class="container mt-5">
                <h1>Form Submissions for <%= custName %></h1>
                <h3>Email: <%= custEmail %></h3>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Subject</th>
                            <th>Message</th>
                        </tr>
                    </thead>
                    <tbody>
<%
        // Display form submission details
        while (rs.next()) {
            String subject = rs.getString("subject");
            String message = rs.getString("message");
%>
                        <tr>
                            <td><%= subject %></td>
                            <td><%= message %></td>
                        </tr>
<%
        }
%>
                    </tbody>
                </table>
                <a href="managerView.jsp" class="btn btn-primary">Back to Manager View</a>
            </div>
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
