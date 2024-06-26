<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>

<%
    String staffId = session.getAttribute("staffId").toString();
    String clockButtonState = "enabled";
    String clockValidationMessage = "";

    Connection connection = null;
    PreparedStatement preparedStatement = null;
    ResultSet resultSet = null;

    List<String> clockTimes = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String jdbcURL = "jdbc:mysql://localhost/seaba";
        String dbUser = "root";
        String dbPassword = "admin";
        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Retrieve the latest clock times from the database
        preparedStatement = connection.prepareStatement("SELECT * FROM ClockInOut WHERE staffId = ? ORDER BY clockIn DESC LIMIT 2");
        preparedStatement.setString(1, staffId);
        resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            String action = resultSet.getString("action");
            String dateTime = resultSet.getString("dateTime");
            clockTimes.add(action + ": " + dateTime);
        }

        // Validate if both clock in and clock out records exist for today
        if (clockTimes.size() >= 2) {
            clockButtonState = "disabled";
            clockValidationMessage = "You have successfully clocked in and out for today!";
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

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Seaba Seafood Management System - Clock In and Out</title>

        <!-- Favicons -->
        <link href="assets/img/seaba raya logo.png" rel="icon">
        <link href="assets/img/SeabaSeafood-touch-icon.png" rel="SeabaSeafood-touch-icon">

        <!-- Google Fonts -->
        <link href="https://fonts.gstatic.com" rel="preconnect">

        <!-- Vendor CSS Files -->
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">
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
                        <h5 class="card-title text-center">Clock In/Out</h5>

                        <div class="text-center">
                            <h6>WELCOME <%= session.getAttribute("staffName")%></h6>
                        </div>

                        <form id="clockForm" method="POST">
                            <button type="button" id="clockButton" class="btn btn-success" onclick="performClockOperation()" <%= clockButtonState%>>Clock In/Out</button>
                        </form>

                        <div class="mt-3">
                            <div id="clockMessage">
                                <%= clockValidationMessage%>
                            </div>
                            <div id="clockTimes">
                                <%-- Display the retrieved clock times --%>
                                <% for (String clockTime : clockTimes) {%>
                                <%= clockTime%><br>
                                <% }%>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!-- End All Staff List -->


            <script>
                function updateClockTimes() {
                    var clockTimesElement = document.getElementById('clockTimes');
                    clockTimesElement.innerHTML = '';

                <%-- Display the updated clock times using JavaScript --%>
                <% for (String clockTime : clockTimes) {%>
                    clockTimesElement.innerHTML += '<%= clockTime%><br>';
                <% }%>
                }

                function performClockOperation() {
                    var xhr = new XMLHttpRequest();
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState == 4) {
                            if (xhr.status == 200) {
                                var button = document.getElementById('clockButton');
                                var messageElement = document.getElementById('clockMessage');
                                var clockTimesElement = document.getElementById('clockTimes');

                                var formattedDateTime = new Intl.DateTimeFormat('en-US', {
                                    year: 'numeric',
                                    month: 'numeric',
                                    day: 'numeric',
                                    hour: 'numeric',
                                    minute: 'numeric',
                                    second: 'numeric'
                                }).format(new Date());

                                button.disabled = true;
                                clockTimesElement.innerHTML += '<br>Clock In/Out: ' + formattedDateTime;
                                messageElement.innerHTML = "You have successfully clocked in / out for today!";
                            } else {
                                console.error('Failed to receive a response from the server.');
                            }
                        }
                    };

                    xhr.open('POST', 'clockInOutLogic.jsp', true);
                    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
                    xhr.send('action=clockIn'); // You can send 'action=clockOut' for clock-out as needed
                }

                // Call the updateClockTimes function after the DOM has fully loaded
                document.addEventListener('DOMContentLoaded', function () {
                    updateClockTimes();
                });
            </script>

        </main><!-- End #main -->

        <!-- Include your footer and script includes here -->
        <jsp:include page="includes/footer.jsp" />


        <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
                class="bi bi-arrow-up-short"></i></a>

        <jsp:include page="includes/script.jsp" />

    </body>

</html>