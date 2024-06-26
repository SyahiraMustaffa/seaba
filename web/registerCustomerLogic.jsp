<%-- 
    Document   : registerCustomerLogic
    Created on : 20 Jan 2024, 12:02:32 am
    Author     : user
--%>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    // Retrieve form parameters
    String custName = request.getParameter("custName");
    String custEmail = request.getParameter("custEmail");
    String custPhone = request.getParameter("custPhone");
    String password = request.getParameter("password");

    // JDBC variables
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet generatedKeys = null;

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        String jdbcURL = "jdbc:mysql://localhost:3306/seaba";
        String dbUser = "root";
        String dbPassword = "admin";
        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        if (connection != null) {
            // SQL query to insert data into the database without specifying staffId (auto-increment)
            String sqlQuery = "INSERT INTO customers (custName, custEmail, custPhone, password) VALUES (?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sqlQuery, Statement.RETURN_GENERATED_KEYS);

            // Set values for the parameters
            preparedStatement.setString(1, custName);
            preparedStatement.setString(2, custEmail);
            preparedStatement.setString(3, custPhone);
            preparedStatement.setString(4, password); // Store plain text password

            // Execute the insert statement
            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows > 0) {
                // Retrieve the auto-generated customerId
                generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int generatedCustomerId = generatedKeys.getInt(1);
                    // You can use generatedStaffId if needed
                }

                // Redirect to the login page or do further processing
                response.sendRedirect("customerLogin.jsp?registrationStatus=alert-success&registrationMessage=Registration successful! Please login.");
            } else {
                // Log an error if no rows were affected
                out.println("<p>Error: No rows affected</p>");
            }
        } else {
            // Log an error if the connection is null
            out.println("<p>Error: Database connection is null</p>");
        }

    } catch (SQLIntegrityConstraintViolationException e) {
        // Handle duplicate key exception (Id or Email already exists)
        e.printStackTrace();
        response.sendRedirect("registerCustomer.jsp?registrationStatus=alert-danger&registrationMessage=Email or Customer ID already exists. Please try again.");

    } catch (SQLException e) {
        // Handle SQL-related exceptions
        e.printStackTrace();

        // Log the SQL exception details
        out.println("<p>SQL Exception: " + e.getMessage() + "</p>");
        out.println("<p>SQL State: " + e.getSQLState() + "</p>");
        out.println("<p>Vendor Error Code: " + e.getErrorCode() + "</p>");

        response.sendRedirect("registerCustomer.jsp?registrationStatus=alert-danger&registrationMessage=SQL Error. Please check server logs for details.");

    } catch (Exception e) {
        // Handle other exceptions
        e.printStackTrace();

        // Log other exception details
        out.println("<p>Exception: " + e.getMessage() + "</p>");

        response.sendRedirect("registerCustomer.jsp?registrationStatus=alert-danger&registrationMessage=An unexpected error occurred. Please check server logs for details.");

    } finally {
        // Close the database resources
        try {
            if (generatedKeys != null) {
                generatedKeys.close();
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
