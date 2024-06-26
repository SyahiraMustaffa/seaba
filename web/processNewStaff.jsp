<%-- 
    Document   : processNewStaff
    Created on : 16 Jan 2024, 10:19:33 pm
    Author     : user
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<%
    // Get the new user's details from the form
    String staffName = request.getParameter("staffName");
    String staffEmail = request.getParameter("staffEmail");
    String staffPhone = request.getParameter("staffPhone");
    String staffRole = request.getParameter("staffRole");
    String userType = request.getParameter("userType");
    String password = request.getParameter("password");

    // Print parameters for debugging
    out.println("Parameters: ");
    out.println("staffName: " + staffName + "<br/>");
    out.println("staffEmail: " + staffEmail + "<br/>");
    out.println("staffPhone: " + staffPhone + "<br/>");
    out.println("staffRole: " + staffRole + "<br/>");
    out.println("userType: " + userType + "<br/>");
    out.println("password: " + password + "<br/>");
     
    try {
        // Establish db connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        String myURL = "jdbc:mysql://localhost/seaba";
        Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

        // Prepare and execute the SQL statement to insert the user list
        String newUserQry = "INSERT INTO staff (staffName, staffEmail, staffPhone, staffRole, userType, password) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement insertPS = myConnection.prepareStatement(newUserQry);
        insertPS.setString(1, staffName);
        insertPS.setString(2, staffEmail);
        insertPS.setString(3, staffPhone);
        insertPS.setString(4, staffRole);
        insertPS.setString(5, userType);
        insertPS.setString(6, password);
        int rowsAffected = insertPS.executeUpdate();

        // Print for debugging
        out.println("Rows affected: " + rowsAffected + "<br/>");
        
        // Close the database resources
        insertPS.close();
        myConnection.close();

        if (rowsAffected > 0) {
            // Insert successful
            response.sendRedirect("manageUser.jsp");
        } else {
            // Insert failed
            out.println("Insert user failed");
        }
    } catch (Exception e) {
        // Handle exceptions
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        out.println("<pre>" + sw.toString() + "</pre>");
    }
%>
