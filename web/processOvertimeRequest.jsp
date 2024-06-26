<%@ page import="java.sql.*, java.text.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Your database connection code
    Connection connection = null;
    PreparedStatement updateStatement = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String jdbcURL = "jdbc:mysql://localhost/seaba";
        String dbUser = "root";
        String dbPassword = "admin";
        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Get parameters from the form
        int requestId = Integer.parseInt(request.getParameter("requestId"));
        String action = request.getParameter("action");

        // Update the status based on the action (Accept or Reject)
        String updateStatusSql = "UPDATE overtimerequests SET status = ? WHERE requestId = ?";
        updateStatement = connection.prepareStatement(updateStatusSql);

        if (action.equals("accept")) {
            updateStatement.setString(1, "Accepted");
        } else if (action.equals("reject")) {
            updateStatement.setString(1, "Rejected");
        }

        updateStatement.setInt(2, requestId);
        updateStatement.executeUpdate();

        // Redirect back to the original page
        response.sendRedirect("staffOvertime.jsp");
    } catch (SQLException | ClassNotFoundException | NumberFormatException e) {
        // Handle exceptions (display error message or log)
        out.println("<script>alert('An unexpected error occurred.'); window.location.href='overtimeRequests.jsp';</script>");
        e.printStackTrace();
    } finally {
        // ... (your existing closing database resources code) ...
    }
%>
