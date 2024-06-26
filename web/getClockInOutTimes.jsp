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

        preparedStatement = connection.prepareStatement("SELECT * FROM ClockInOut WHERE staffId = ? ORDER BY clockIn DESC");
        preparedStatement.setString(1, staffId);
        resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            String clockIn = resultSet.getString("clockIn");
            String clockOut = resultSet.getString("clockOut");

            /*out.println("Clock In: " + clockIn);
            if (clockOut != null) {
                out.println("<br>Clock Out: " + clockOut);
            } else {
                out.println("<br>Not clocked out yet");
            } */
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
