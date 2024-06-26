<%@ page import="java.sql.*" %>
<%@ page import="java.io.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String jdbcURL = "jdbc:mysql://localhost:3306/seaba";
    String jdbcUsername = "root";
    String jdbcPassword = "admin";

    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String subject = request.getParameter("subject");
    String message = request.getParameter("message");
    
    if (name != null && !name.isEmpty() && email != null && !email.isEmpty() &&
        subject != null && !subject.isEmpty() && message != null && !message.isEmpty()) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            String sql = "INSERT INTO contact (name, email, subject, message) VALUES (?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, subject);
            statement.setString(4, message);
        
            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("contact.jsp");
                return; // Stop further execution
            } else {
                out.println("<p>Error: Failed to insert data into the database.</p>");
            }
        } catch (SQLException e) {
            out.println("<p>An error occurred while processing your request: " + e.getMessage() + "</p>");
        } catch (ClassNotFoundException e) {
            out.println("<p>Driver not found: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                out.println("<p>Error closing database resources: " + e.getMessage() + "</p>");
            }
        }
    } else {
        out.println("<p>Error: Please fill out all required fields.</p>");
    }
%>
