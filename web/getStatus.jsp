<%-- 
    Document   : getStatus
    Created on : 22 Jan 2024, 6:17:59 am
    Author     : user
--%>

<%@ page import="java.sql.*, java.text.*, java.util.*" %>

<%
    // Retrieve data from the request
    String staffId = request.getParameter("staffId");

    // Your database connection code
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String jdbcURL = "jdbc:mysql://localhost/seaba";
        String dbUser = "root";
        String dbPassword = "admin";
        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Retrieve the status based on staffId
        String getStatusSql = "SELECT status FROM overtimerequests WHERE staffId = ?";
        preparedStatement = connection.prepareStatement(getStatusSql);
        preparedStatement.setInt(1, Integer.parseInt(staffId));
        resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            // Output the status
            out.println(resultSet.getString("status"));
        } else {
            // Output a default status or handle accordingly
            out.println("Not Found");
        }
    } catch (SQLException | ClassNotFoundException e) {
        out.println("An unexpected error occurred: " + e.getMessage());
        e.printStackTrace();
    } finally {
        try {
            if (resultSet != null) {
                resultSet.close();
            }
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
%>
