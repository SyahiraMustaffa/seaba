<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Edit Drink Item</title>

    <!-- Favicons -->
    <link href="assets/img/seaba raya logo.png" rel="icon">
    <link href="assets/img/SamanSiswa-touch-icon.png" rel="SiswaSaman-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect">

    <!-- Vendor CSS Files -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet">
</head>

<body>
    <!-- ======= Header ======= -->
    <jsp:include page="includes/header.jsp" />

    <!-- ======= Sidebar ======= -->
    <jsp:include page="manager/sidebar.jsp" />

    <!-- ======= Drink Item Editing ========== -->
    <main id="main" class="main">
        <div class="pagetitle">
            <h1>Drink Item Management</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="manager.jsp">Home</a></li>
                    <li class="breadcrumb-item">Drink Item Management</li>
                    <li class="breadcrumb-item active">Edit Drink Item</li>
                </ol>
            </nav>
        </div><!-- End Page Title -->

        <section class="section profile">
            <div class="row">
                <div class="col-xl-11">
                    <div class="card">
                        <div class="card-body pt-3">
                            <div class="tab-content pt-2">

                                <%
                                    // Get the drink ID from the query string parameter
                                    int drinkId = Integer.parseInt(request.getParameter("id"));

                                    try {
                                        // Establish db connection
                                        Class.forName("com.mysql.jdbc.Driver");
                                        String dbURL = "jdbc:mysql://localhost/seaba";
                                        String dbUser = "root";
                                        String dbPassword = "admin";
                                        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                                        // Prepare and execute the SQL statement to retrieve the drink details
                                        String sql = "SELECT * FROM drink WHERE drink_id=?";
                                        PreparedStatement stmt = conn.prepareStatement(sql);
                                        stmt.setInt(1, drinkId);
                                        ResultSet rs = stmt.executeQuery();

                                        if (rs.next()) {
                                            // Get the drink details
                                            String drinkName = rs.getString("drink_name");
                                            String drinkDescription = rs.getString("drinkDescription");
                                            double drinkPrice = rs.getDouble("drinkPrice");

                                            // Close the database resources
                                            rs.close();
                                            stmt.close();
                                            conn.close();

                                            // Display the drink details in the form for editing
                                %>
                                <h2>Edit Drink Item <%= drinkId %></h2>

                                <form action="updateDrink.jsp" method="POST">
                                    <input type="hidden" name="id" value="<%= drinkId %>">

                                    <div class="row mb-3">
                                        <label for="drinkName" class="col-md-4 col-lg-3 col-form-label">Drink Name</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input type="text" name="drinkName" class="form-control" id="drinkName" value="<%= drinkName %>" required>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label for="drinkDescription" class="col-md-4 col-lg-3 col-form-label">Description</label>
                                        <div class="col-md-8 col-lg-9">
                                            <textarea name="drinkDescription" class="form-control" id="drinkDescription" rows="4"><%= drinkDescription %></textarea>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <label for="drinkPrice" class="col-md-4 col-lg-3 col-form-label">Price</label>
                                        <div class="col-md-8 col-lg-9">
                                            <input type="text" name="drinkPrice" class="form-control" id="drinkPrice" value="<%= drinkPrice %>" required>
                                        </div>
                                    </div>

                                    <div class="text-center">
                                        <input type="submit" class="btn btn-primary" value="Update">
                                    </div>
                                </form>

                                <%
                                        } else {
                                            // Drink item not found
                                            out.println("Drink item not found");
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                %>

                            </div><!-- End Bordered Tabs -->

                        </div>
                    </div>

                </div>
            </div>
        </section>

    </main><!-- End #main -->

    <!-- ======= Footer ======= -->
    <jsp:include page="includes/footer.jsp" />

    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

    <!-- Vendor JS Files -->
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/vendor/jquery.easing/jquery.easing.min.js"></script>

    <!-- Template Main JS File -->
    <script src="assets/js/main.js"></script>

</body>

</html>
