<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    // Retrieve form parameters
    String staffName = request.getParameter("staffName");
    String staffEmail = request.getParameter("staffEmail");
    String staffPhone = request.getParameter("staffPhone");
    String staffRole = request.getParameter("staffRole");
    String userType = request.getParameter("userType");
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
            String sqlQuery = "INSERT INTO staff (staffName, staffEmail, staffPhone, staffRole, userType, password) VALUES (?, ?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(sqlQuery, Statement.RETURN_GENERATED_KEYS);

            // Set values for the parameters
            preparedStatement.setString(1, staffName);
            preparedStatement.setString(2, staffEmail);
            preparedStatement.setString(3, staffPhone);
            preparedStatement.setString(4, staffRole);
            preparedStatement.setString(5, userType);
            preparedStatement.setString(6, password); // Store plain text password

            // Execute the insert statement
            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows > 0) {
                // Retrieve the auto-generated staffId
                generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int generatedStaffId = generatedKeys.getInt(1);
                    // You can use generatedStaffId if needed
                }

                // Redirect to the login page or do further processing
                response.sendRedirect("staffManagerLogin.jsp?registrationStatus=alert-success&registrationMessage=Registration successful! Please login.");
            } else {
                // Log an error if no rows were affected
                out.println("<p>Error: No rows affected</p>");
            }
        } else {
            // Log an error if the connection is null
            out.println("<p>Error: Database connection is null</p>");
        }

    } catch (SQLIntegrityConstraintViolationException e) {
        // Handle duplicate key exception (staffId or staffEmail already exists)
        e.printStackTrace();
        response.sendRedirect("registerStaff.jsp?registrationStatus=alert-danger&registrationMessage=Email or Staff ID already exists. Please try again.");

    } catch (SQLException e) {
        // Handle SQL-related exceptions
        e.printStackTrace();

        // Log the SQL exception details
        out.println("<p>SQL Exception: " + e.getMessage() + "</p>");
        out.println("<p>SQL State: " + e.getSQLState() + "</p>");
        out.println("<p>Vendor Error Code: " + e.getErrorCode() + "</p>");

        response.sendRedirect("registerStaff.jsp?registrationStatus=alert-danger&registrationMessage=SQL Error. Please check server logs for details.");

    } catch (Exception e) {
        // Handle other exceptions
        e.printStackTrace();

        // Log other exception details
        out.println("<p>Exception: " + e.getMessage() + "</p>");

        response.sendRedirect("registerStaff.jsp?registrationStatus=alert-danger&registrationMessage=An unexpected error occurred. Please check server logs for details.");

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
