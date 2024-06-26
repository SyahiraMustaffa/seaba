<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Retrieve form data
    String managerId = request.getParameter("managerId");
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");

    try {
        // Db connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        String myURL = "jdbc:mysql://localhost/seaba";
        Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

        // Prepare and execute the SQL statement to update manager profile
        String updateQry = "UPDATE manager_table SET name=?, phone=?, email=? WHERE managerId=?";
        PreparedStatement updatePS = myConnection.prepareStatement(updateQry);
        updatePS.setString(1, name);
        updatePS.setString(2, phone);
        updatePS.setString(3, email);
        updatePS.setString(4, managerId);

        // Execute the update query
        int rowsAffected = updatePS.executeUpdate();

        // Check if the update was successful
        if (rowsAffected > 0) {
            // Update successful
            out.println("Manager profile updated successfully.");
            // You may set a success message in the session if needed
            session.setAttribute("successMessage", "Manager profile updated successfully.");
        } else {
            // Update failed
            out.println("Error: Failed to update manager profile.");
            // You may set an error message in the session if needed
            session.setAttribute("errorMessage", "Failed to update manager profile.");
        }

        // Close the prepared statement and connection
        updatePS.close();
        myConnection.close();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }

    // Redirect back to the manager's profile page
    response.sendRedirect("manager.jsp");
%>
