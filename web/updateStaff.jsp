<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>

<%
    // Get the updated users details from the form
    int staffId = Integer.parseInt(request.getParameter("staffId"));
    String staffName = request.getParameter("staffName");
    String staffEmail = request.getParameter("staffEmail");
    String staffPhone = request.getParameter("staffPhone");
    String staffRole = request.getParameter("staffRole");
    String userType = request.getParameter("userType");
    
    try {
        // Establish db connection
        Class.forName("com.mysql.jdbc.Driver");
        String myURL = "jdbc:mysql://localhost/seaba";
        Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

        // Prepare and execute the SQL statement to update the user list
        String updateUserQuery = "UPDATE staff SET staffName=?, staffEmail=?, staffPhone=?, staffRole=?, userType=? WHERE staffId=?";
        PreparedStatement updateUserPS = myConnection.prepareStatement(updateUserQuery);
        updateUserPS.setString(1, staffName);
        updateUserPS.setString(2, staffEmail);
        updateUserPS.setString(3, staffPhone);
        updateUserPS.setString(4, staffRole);
        updateUserPS.setString(5, userType);
        updateUserPS.setInt(6, staffId);
        int rowsAffected = updateUserPS.executeUpdate();
        
        // Close the database resources
        updateUserPS.close();
        myConnection.close();
        
        if (rowsAffected > 0) {
            // Update successful
            response.sendRedirect("manageUser.jsp");
        } else {
            // Update failed
            out.println("Update failed");
        }
    } catch (Exception e) {
        // Handle exceptions
        e.printStackTrace();
        out.println("An error occurred during the update process: " + e.getMessage());

    }
%>
