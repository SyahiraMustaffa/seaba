<%-- 
    Document   : deleteStaff
    Created on : 16 Jan 2024, 9:14:16 pm
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java"%>
<%@page import="java.sql.*"%>
<%
    // Get the user ID from the query string parameter
    String userId = request.getParameter("staffId");
    
    try {
        // Establish db connection
        Class.forName("com.mysql.jdbc.Driver");
        String myURL = "jdbc:mysql://localhost/seaba";
        Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

        // Prepare and execute the SQL statement to delete the staff
        String deleteQry = "DELETE FROM staff WHERE staffId=?";
        PreparedStatement deletePS = myConnection.prepareStatement(deleteQry);
        deletePS.setString(1, userId);
        int rowsAffected = deletePS.executeUpdate();
        
        // Close the database resources
        deletePS.close();
        myConnection.close();
        
        if (rowsAffected > 0) {
        // Delete successful
        response.sendRedirect("manageUser.jsp");
        // Delete failed
        out.println("Delete failed");
        }


    } catch (Exception e) {
        e.printStackTrace();
    }
%>
