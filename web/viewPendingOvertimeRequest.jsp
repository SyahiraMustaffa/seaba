<%@ page import="java.sql.*, java.text.*, java.util.*" %>

<div class="pagetitle">
    <h1>Pending Overtime Requests</h1>
    <nav>
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="#">Home</a></li>
            <li class="breadcrumb-item active"> Overtime Requests</li>
        </ol>
    </nav>
</div><!-- End Page Title -->

<%!
    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String jdbcURL = "jdbc:mysql://localhost/seaba";
        String dbUser = "root";
        String dbPassword = "admin";
        return DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
    }
    
    // Function to determine badge class based on status
    private String getStatusBadgeClass(String status) {
        if ("Pending".equals(status)) {
            return "warning";
        } else if ("Accepted".equals(status)) {
            return "success";
        } else if ("Rejected".equals(status)) {
            return "danger";
        } else {
            return ""; // Handle other cases or set a default class
        }
    }
%>

<%
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    try {
        connection = getConnection();

        // Assuming staffId is the user's ID stored in the session
        String staffId = (String) session.getAttribute("staffId");

        String sql = "SELECT * FROM overtimerequests WHERE staffId = ?";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setInt(1, Integer.parseInt(staffId));
        resultSet = preparedStatement.executeQuery();
%>

<!-- Pending overtime requests table for staff -->
<div class="col-12">
    <div class="card overtime-requests">
        <div class="card-body">
            <h5 class="card-title">Overtime Requests</h5>

            <table class="table table-striped">
                <thead>
                    <tr>
                        <th scope="col">Staff Id</th>
                        <th scope="col">Reason</th>
                        <th scope="col">Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        while (resultSet.next()) {
                            int staffIdValue = resultSet.getInt("staffId");
                            String reason = resultSet.getString("reason");
                            String status = resultSet.getString("status");
                            String badgeClass = getStatusBadgeClass(status);
                    %>
                    <tr>
                        <td><%= staffIdValue %></td>
                        <td><%= reason %></td>
                        <td><span class="badge bg-<%= badgeClass %>"><%= status %></span></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div><!-- End Pending Overtime Requests for staff -->

<%
    } catch (SQLException e) {
        out.println("Error executing SQL query: " + e.getMessage());
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        out.println("Error loading database driver: " + e.getMessage());
        e.printStackTrace();
    } catch (Exception e) {
        out.println("An unexpected error occurred: " + e.getMessage());
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
