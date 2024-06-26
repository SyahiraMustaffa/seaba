<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    String staffId = request.getParameter("staffId");
    String staffName = request.getParameter("staffName");
    String staffEmail = request.getParameter("staffEmail");
    String staffPhone = request.getParameter("staffPhone");

    try {
        // Database connection
        Class.forName("com.mysql.jdbc.Driver");
        String myURL = "jdbc:mysql://localhost/seaba";
        Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

        // Prepare and execute the SQL update statement
        String updateQuery = "UPDATE staff SET staffName=?, staffEmail=?, staffPhone=? WHERE staffId=?";
        PreparedStatement updatePS = myConnection.prepareStatement(updateQuery);
        updatePS.setString(1, staffName);
        updatePS.setString(2, staffEmail);
        updatePS.setString(3, staffPhone);
        updatePS.setString(4, staffId);

        // Execute the update
        int rowsUpdated = updatePS.executeUpdate();

        // Close resources
        updatePS.close();
        myConnection.close();

      
        // Check if the update was successful
        if (rowsUpdated > 0) {
            // Update successful
            out.println("Staff profile updated successfully.");
            // You may set a success message in the session if needed
            session.setAttribute("successMessage", "Staff profile updated successfully.");
        } else {
            // Update failed
            out.println("Error: Failed to update staff profile.");
            // You may set an error message in the session if needed
            session.setAttribute("errorMessage", "Failed to update staff profile.");
        }

        // Close the prepared statement and connection
        updatePS.close();
        myConnection.close();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }

    // Redirect back to the manager's profile page
    response.sendRedirect("staff.jsp");
%>
