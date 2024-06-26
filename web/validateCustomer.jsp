<%-- 
    Document   : validateCustomer
    Created on : 19 Jan 2024, 11:50:52 pm
    Author     : user
--%>

<%@ page import="java.sql.*" %>

<%
    // Retrieve form parameters
    String custEmail = request.getParameter("custEmail");
    String Password = request.getParameter("password");

    // JDBC variables
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        String jdbcURL = "jdbc:mysql://localhost:3306/seaba";
        String dbUser = "root";
        String dbPassword = "admin";
        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        if (connection != null) {
            // SQL query to validate staff credentials
            String sqlQuery = "SELECT * FROM customers WHERE custEmail = ? AND password = ?";
            preparedStatement = connection.prepareStatement(sqlQuery);
            preparedStatement.setString(1, custEmail);
            preparedStatement.setString(2, Password);

            // Execute the query
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // Store staff information in session attributes
                session.setAttribute("customerId", resultSet.getInt("customerId"));
                session.setAttribute("custName", resultSet.getString("custName"));
                session.setAttribute("custEmail", resultSet.getString("custEmail"));
                session.setAttribute("custPhone", resultSet.getString("custPhone"));
       

                // Login successful
                response.sendRedirect("customer.jsp?success=1");
            } else {
                // Invalid login credentials
                response.sendRedirect("customerLogin.jsp?error=1");
            }
        } else {
            // Log an error if the connection is null
            out.println("Error: Database connection is null");
            response.sendRedirect("customerLogin.jsp?error=2");
        }

    } catch (SQLException e) {
        // Handle SQL-related exceptions
        e.printStackTrace();

        // Log the SQL exception details
        out.println("SQL Exception: " + e.getMessage());
        out.println("SQL State: " + e.getSQLState());
        out.println("Vendor Error Code: " + e.getErrorCode());

        response.sendRedirect("customer.jsp?error=2");

    } catch (Exception e) {
        // Handle other exceptions
        e.printStackTrace();

        // Log other exception details
        out.println("Exception: " + e.getMessage());

        response.sendRedirect("customerLogin.jsp?error=2");

    } finally {
        // Close the database resources
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

