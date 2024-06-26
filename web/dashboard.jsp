<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.ParseException" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Seaba Seafood Management System - Dashboard</title>

        <link href="assets/img/seaba raya logo.png" rel="icon">
        <link href="assets/img/SeabaSeafood-touch-icon.png" rel="SeabaSeafood-touch-icon">

        <link href="https://fonts.gstatic.com" rel="preconnect">

        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">

        <style>
            /* Additional styles specific to the dashboard.jsp page */
            .dashboard-container {
                margin-top: 60px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            table, th, td {
                border: 1px solid #ddd;
            }

            th, td {
                padding: 15px;
                text-align: left;
            }

            th {
                background-color: #f2f2f2;
            }
        </style>
    </head>

    <body>
        <!-- Include your header and sidebar here -->
        <jsp:include page="includes/header.jsp" />
        <jsp:include page="staff/sidebar.jsp" />

        <!-- Main content -->
        <main id="main" class="main">


            <div class="col-12">
                <div class="card users-list overflow-auto">
                    <div class="card-body">
                        <h5 class="card-title text-center">Staff Dashboard</h5>

                        <div class="text-center mb-3">
                            <h3>Welcome <%= session.getAttribute("staffName")%></h3>
                        </div>

                        <div class="mt-3">
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

                                    // Get clock in/out details
                                    preparedStatement = connection.prepareStatement("SELECT * FROM ClockInOut WHERE staffId = ? ORDER BY clockIn DESC");
                                    preparedStatement.setString(1, staffId);
                                    resultSet = preparedStatement.executeQuery();

                                    out.println("<h4>Your Clock In/Out Details</h4>");
                                    out.println("<table border='1'>");
                                    out.println("<tr><th>Clock In</th><th>Clock Out</th><th>Total Hours Worked</th><th>Total Overtime</th></tr>");

                                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                    DecimalFormat decimalFormat = new DecimalFormat("#.##");

                                    while (resultSet.next()) {
                                        String clockIn = resultSet.getString("clockIn");
                                        String clockOut = resultSet.getString("clockOut");

                                        out.println("<tr>");
                                        out.println("<td>" + clockIn + "</td>");
                                        out.println("<td>" + (clockOut != null ? clockOut : "Not clocked out yet") + "</td>");

                                        // Calculate total hours worked and overtime for each row
                                        Date clockInDate = dateFormat.parse(clockIn);
                                        Date clockOutDate = clockOut != null ? dateFormat.parse(clockOut) : null;

                                        long diffInMilliseconds = clockOutDate != null ? clockOutDate.getTime() - clockInDate.getTime() : 0;
                                        double hoursWorked = diffInMilliseconds / (60 * 60 * 1000.0);

                                        double overtime = 0;
                                        if (hoursWorked > 8) {
                                            overtime = hoursWorked - 8;
                                        }

                                        // Convert total hours worked and overtime to hours and minutes
                                        int totalHoursWorked = (int) hoursWorked;
                                        int totalMinutesWorked = (int) ((hoursWorked - totalHoursWorked) * 60);

                                        int totalHoursOvertime = (int) overtime;
                                        int totalMinutesOvertime = (int) ((overtime - totalHoursOvertime) * 60);

                                        out.println("<td>" + totalHoursWorked + " hours " + totalMinutesWorked + " minutes</td>");
                                        out.println("<td>" + totalHoursOvertime + " hours " + totalMinutesOvertime + " minutes</td>");

                                        out.println("</tr>");
                                    }

                                    out.println("</table>");

                                    // ... (remaining code) ...
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
                        </div>
                    </div>
                </div>
            </div>

        </main><!-- End #main -->

        <!-- Include your footer and script includes here -->
        <jsp:include page="includes/footer.jsp" />


        <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
                class="bi bi-arrow-up-short"></i></a>

        <jsp:include page="includes/script.jsp" />

    </body>

</html>

