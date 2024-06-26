<%@ page import="java.sql.*, java.text.*, java.util.*, java.util.concurrent.TimeUnit" %>
<%@ page import="java.io.*" %>

<%
    try {
        String staffId = (String) session.getAttribute("staffId");
        String reason = request.getParameter("reason");

        // Check if staffId is not null or empty
        if (staffId != null && !staffId.isEmpty()) {
            Connection connection = null;
            PreparedStatement preparedStatement = null;

            try {
                // Establish database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                String jdbcURL = "jdbc:mysql://localhost/seaba";
                String dbUser = "root";
                String dbPassword = "admin";
                connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                // Insert into OvertimeRequests table
                String sql = "INSERT INTO OvertimeRequests (staffId, reason) VALUES (?, ?)";
                preparedStatement = connection.prepareStatement(sql);
                preparedStatement.setString(1, staffId);
                preparedStatement.setString(2, reason);
                preparedStatement.executeUpdate();

                // Close resources
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }

                // Introduce a delay for demonstration purposes
                TimeUnit.SECONDS.sleep(2);

                // Redirect with success status
                response.sendRedirect("overtimeRequest.jsp?status=pending");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error submitting overtime request.");
            } finally {
                try {
                    // Close resources if needed
                    if (preparedStatement != null) {
                        preparedStatement.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            out.println("Invalid session. Please log in.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error processing overtime request.");
    }
%>
