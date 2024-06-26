<%-- 
    Document   : deleteFood
    Created on : 18 May 2024, 1:37:11 pm
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java"%>
<%@page import="java.sql.*"%>
<%
    // Get the user ID from the query string parameter
    String id = request.getParameter("id");
    
    try {
        // Establish db connection
        Class.forName("com.mysql.jdbc.Driver");
        String myURL = "jdbc:mysql://localhost/seaba";
        Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

        // Prepare and execute the SQL statement to delete the staff
        String deleteQry = "DELETE FROM food WHERE Id=?";
        PreparedStatement deletePS = myConnection.prepareStatement(deleteQry);
        deletePS.setString(1,id);
        int rowsAffected = deletePS.executeUpdate();
        
        // Close the database resources
        deletePS.close();
        myConnection.close();
        
        if (rowsAffected > 0) {
        // Delete successful
        response.sendRedirect("FoodDrink.jsp");
        // Delete failed
        out.println("Delete failed");
        }


    } catch (Exception e) {
        e.printStackTrace();
    }
%>
