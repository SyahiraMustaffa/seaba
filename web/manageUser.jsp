<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="Seaba.Users"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Seaba Seafood Management System - Manager Profile</title>

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
    <jsp:include page="manager/sidebar.jsp" />

    <!-- Main content -->
    <main id="main" class="main">
        <div class="pagetitle">
            <h1>Manage Staff</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="manager.jsp">Home</a></li>
                    <li class="breadcrumb-item active">Manage Staff</li>
                </ol>
            </nav>
        </div><!-- End Page Title -->

        <% 
            try {
                // Establish db connection
                Class.forName("com.mysql.jdbc.Driver");
                String myURL = "jdbc:mysql://localhost/seaba";
                Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

                // Prepare and execute the SQL statement
                String staffQry = "SELECT * FROM Staff";
                Statement staffPS = myConnection.createStatement();

                // Execute the query to retrieve all staff
                ResultSet staffRS = staffPS.executeQuery(staffQry);

                // Create a list to store the staff data
                List<Users> staffList = new ArrayList<>();

                // Iterate through the result set and populate the staff list
                while (staffRS.next()) {
                    Users staff = new Users();
                    staff.setStaffId(staffRS.getInt("staffId"));
                    staff.setStaffName(staffRS.getString("staffName"));
                    staff.setStaffPhone(staffRS.getString("staffPhone"));
                    staff.setStaffEmail(staffRS.getString("staffEmail"));
                    staff.setStaffRole(staffRS.getString("staffRole"));
                    staff.setUserType(staffRS.getString("userType"));
                    staffList.add(staff);
                }

                // Close the database resources
                staffRS.close();
                staffPS.close();
                myConnection.close();

                // Set the staffList attribute to make it accessible in the JSP page
                request.setAttribute("staffList", staffList);

            } catch (Exception e) {
                // Handle exceptions
                e.printStackTrace();
            }
        %>

        <!-- All staff list -->
        <div class="col-12">
            <div class="card users-list overflow-auto">
                <div class="card-body">
                    <h5 class="card-title">All Staff List</h5>
                    <a href="addStaff.jsp" class="btn btn-success">Add</a>

                    <table class="table table-borderless datatable">
                        <thead>
                            <tr>
                                <th scope="col">#Staff ID</th>
                                <th scope="col">Full Name</th>
                                <th scope="col">Phone No</th>
                                <th scope="col">Email</th>
                                <th scope="col">Role</th>
                                <th scope="col">User Type</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>

                        <tbody>
                            <% 
                                // Retrieve the staffList attribute
                                List<Users> staffList = (List<Users>) request.getAttribute("staffList");

                                // Check if staffList is not null and not empty
                                if (staffList != null && !staffList.isEmpty()) {
                                    // Iterate through the staff list and populate the table rows
                                    for (Users staff : staffList) {
                            %>
                            <tr>
                                <td><%= staff.getStaffId() %></td>
                                <td><%= staff.getStaffName() %></td>
                                <td><%= staff.getStaffPhone() %></td>
                                <td><%= staff.getStaffEmail() %></td>
                                <td><%= staff.getStaffRole() %></td>
                                <td><%= staff.getUserType() %></td>
                                <td>
                                    <a href="editStaff.jsp?staffId=<%= staff.getStaffId() %>" class="btn btn-warning">Edit</a>
                                    <a href="deleteStaff.jsp?staffId=<%= staff.getStaffId() %>" class="btn btn-danger">Delete</a>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="7">No staff records available.</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div><!-- End All Staff List -->

    </main><!-- End #main -->

    <!-- Include your footer and script includes here -->
    <jsp:include page="includes/footer.jsp" />


    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
            class="bi bi-arrow-up-short"></i></a>

    <jsp:include page="includes/script.jsp" />

</body>

</html>



