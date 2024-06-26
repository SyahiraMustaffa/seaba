<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, java.io.*" %>

<%
    // Get form data
    String currentPassword = request.getParameter("currentpassword");
    String newPassword = request.getParameter("newpassword");
    String confirmPassword = request.getParameter("confirmpassword");

    // Get customerId from session
    Object customerIdObj = request.getSession().getAttribute("customerId");
    String customerId = (customerIdObj != null) ? customerIdObj.toString() : "";

    if (customerId.isEmpty()) {
        out.println("Error: Customer ID is not set in the session.");
        return;
    }

    if (!newPassword.equals(confirmPassword)) {
        out.println("Error: New password and confirm password do not match.");
        return;
    }

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        String myURL = "jdbc:mysql://localhost/seaba";
        Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

        // Check current password
        String checkPasswordQry = "SELECT password FROM customers WHERE customerId = ?";
        PreparedStatement checkPasswordPS = myConnection.prepareStatement(checkPasswordQry);
        checkPasswordPS.setInt(1, Integer.parseInt(customerId));
        ResultSet rs = checkPasswordPS.executeQuery();

        if (rs.next()) {
            String dbPassword = rs.getString("password");

            if (!dbPassword.equals(currentPassword)) {
                out.println("Error: Current password is incorrect.");
                rs.close();
                checkPasswordPS.close();
                myConnection.close();
                return;
            }
        } else {
            out.println("Error: Customer not found.");
            rs.close();
            checkPasswordPS.close();
            myConnection.close();
            return;
        }

        rs.close();
        checkPasswordPS.close();

        // Update password
        String updatePasswordQry = "UPDATE customers SET password = ? WHERE customerId = ?";
        PreparedStatement updatePasswordPS = myConnection.prepareStatement(updatePasswordQry);
        updatePasswordPS.setString(1, newPassword);
        updatePasswordPS.setInt(2, Integer.parseInt(customerId));
        int updateCount = updatePasswordPS.executeUpdate();

        if (updateCount > 0) {
            response.sendRedirect("customer.jsp");
        } else {
            out.println("Error: Password update failed.");
        }

        updatePasswordPS.close();
        myConnection.close();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
%>
