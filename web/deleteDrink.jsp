<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java"%>
<%@page import="java.sql.*"%>
<%
    // Get the drink ID from the query string parameter
    String id = request.getParameter("id");
    
    try {
        // Establish db connection
        Class.forName("com.mysql.jdbc.Driver");
        String myURL = "jdbc:mysql://localhost/seaba";
        Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

        // Prepare and execute the SQL statement to delete the drink item
        String deleteQry = "DELETE FROM drink WHERE drink_id=?";
        PreparedStatement deletePS = myConnection.prepareStatement(deleteQry);
        deletePS.setString(1, id);
        int rowsAffected = deletePS.executeUpdate();
        
        // Close the database resources
        deletePS.close();
        myConnection.close();
        
        if (rowsAffected > 0) {
            // Delete successful
            response.sendRedirect("FoodDrink.jsp");
        } else {
            // Delete failed
            out.println("Delete failed");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
