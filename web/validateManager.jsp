<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    String managerId = request.getParameter("managerId");
    String managerPassword = request.getParameter("managerPassword");

    // JDBC connection parameters (modify as needed)
    String url = "jdbc:mysql://localhost:3306/seaba";
    String username = "root";
    String password = "admin";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(url, username, password);

        String query = "SELECT * FROM manager_table WHERE managerId=? AND managerPassword=?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, managerId);
            preparedStatement.setString(2, managerPassword);

            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                // Successful login
                // Set managerId in the session
                request.getSession().setAttribute("managerId", managerId);
                response.sendRedirect("manager.jsp?success=1");
            } else {
                // Invalid credentials
                response.sendRedirect("ManagerLogin.jsp?error=1");
            }
        }

        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("ManagerLogin.jsp?error=2");
    }
%>
