<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Update Drink Item</title>

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

    <!-- ======= Drink Item Updating ========== -->
    <main id="main" class="main">
        <div class="pagetitle">
            <h1>Update Drink Item</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="manager.jsp">Home</a></li>
                    <li class="breadcrumb-item">Drink Item Management</li>
                    <li class="breadcrumb-item active">Update Drink Item</li>
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
                                    try {
                                        // Get form data
                                        String idParameter = request.getParameter("id");
                                        int id = (idParameter != null && !idParameter.isEmpty()) ? Integer.parseInt(idParameter) : 0;
                                        String drinkName = request.getParameter("drinkName");
                                        String drinkDescription = request.getParameter("drinkDescription");
                                        double drinkPrice = Double.parseDouble(request.getParameter("drinkPrice"));

                                        // Establish db connection
                                        Class.forName("com.mysql.jdbc.Driver");
                                        String myURL = "jdbc:mysql://localhost/seaba";
                                        Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

                                        // Prepare and execute the SQL statement to update the drink item
                                        String updateQry = "UPDATE drink SET drink_name=?, drinkDescription=?, drinkPrice=? WHERE drinkid=?";
                                        PreparedStatement updatePS = myConnection.prepareStatement(updateQry);
                                        updatePS.setString(1, drinkName);
                                        updatePS.setString(2, drinkDescription);
                                        updatePS.setDouble(3, drinkPrice);
                                        updatePS.setInt(4, id);

                                        // Execute update
                                        int rowsAffected = updatePS.executeUpdate();

                                        // Close the database resources
                                        updatePS.close();
                                        myConnection.close();

                                        if (rowsAffected > 0) {
                                %>
                                <div class="alert alert-success" role="alert">
                                    Drink item updated successfully!
                                </div>
                                <%
                                        } else {
                                %>
                                <div class="alert alert-danger" role="alert">
                                    Failed to update drink item.
                                </div>
                                <%
                                        }
                                    } catch (NumberFormatException e) {
                                %>
                                <div class="alert alert-danger" role="alert">
                                    Invalid input. Please enter valid numeric values.
                                </div>
                                <%
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                %>
                                <div class="alert alert-danger" role="alert">
                                    An error occurred while updating drink item.
                                </div>
                                <%
                                    }
                                %>

                                <div class="text-center">
                                    <a href="FoodDrink.jsp" class="btn btn-primary">Back to Drink Items</a>
                                </div>

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
