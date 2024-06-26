<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>

<%
    String staffId = session.getAttribute("staffId").toString();
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String jdbcURL = "jdbc:mysql://localhost/seaba";
        String dbUser = "root";
        String dbPassword = "admin";
        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Check if there is an entry for the current day
        preparedStatement = connection.prepareStatement("SELECT * FROM ClockInOut WHERE staffId = ? AND DATE(clockIn) = CURDATE()");
        preparedStatement.setString(1, staffId);
        resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            // If there is an entry for the current day, perform clock-out
            preparedStatement = connection.prepareStatement("UPDATE ClockInOut SET clockOut = NOW() WHERE staffId = ? AND DATE(clockIn) = CURDATE() AND clockOut IS NULL");
            preparedStatement.setString(1, staffId);
            preparedStatement.executeUpdate();
            out.println("Clock In");
        } else {
            // If there is no entry for the current day, perform clock-in
            preparedStatement = connection.prepareStatement("INSERT INTO ClockInOut (staffId, clockIn) VALUES (?, NOW())");
            preparedStatement.setString(1, staffId);
            preparedStatement.executeUpdate();
            out.println("Clock Out");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
