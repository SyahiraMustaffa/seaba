<%-- 
    Document   : editFood
    Created on : 18 May 2024, 2:46:22 pm
    Author     : user
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>SamanSiswa</title>

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

        <!-- ======= Food Item Editing ========== -->
        <main id="main" class="main">
            <div class="pagetitle">
                <h1>Food Item Management</h1>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="manager.jsp">Home</a></li>
                        <li class="breadcrumb-item">Food Item Management</li>
                        <li class="breadcrumb-item active">Edit Food Item</li>
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
                                        // Get the food ID from the query string parameter
                                        int foodId = Integer.parseInt(request.getParameter("id"));

                                        try {
                                            // Establish db connection
                                            Class.forName("com.mysql.jdbc.Driver");
                                            String myURL = "jdbc:mysql://localhost/seaba";
                                            Connection myConnection = DriverManager.getConnection(myURL, "root", "admin");

                                            // Prepare and execute the SQL statement to retrieve the food item details
                                            String foodQry = "SELECT * FROM food WHERE id=?";
                                            PreparedStatement foodPS = myConnection.prepareStatement(foodQry);
                                            foodPS.setInt(1, foodId);
                                            ResultSet foodRS = foodPS.executeQuery();

                                            if (foodRS.next()) {
                                                // Get the food item details
                                                String foodName = foodRS.getString("food_name");
                                                String description = foodRS.getString("description");
                                                double price = foodRS.getDouble("price");

                                                // Close the database resources
                                                foodRS.close();
                                                foodPS.close();
                                                myConnection.close();

                                                // Display the food item details in the form for editing
%>
                                    <h2>Edit Food Item <%=foodId%></h2>

                                    <form action="updateFood.jsp" method="POST">
                                        <input type="hidden" name="id" value="<%= foodId%>">

                                        <div class="row mb-3">
                                            <label for="text" class="col-md-4 col-lg-3 col-form-label">Food Name</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="foodName" type="text" class="form-control" id="foodName" value="<%= foodName%>">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="text" class="col-md-4 col-lg-3 col-form-label">Description</label>
                                            <div class="col-md-8 col-lg-9">
                                                <textarea name="description" class="form-control" id="description" rows="4"><%= description%></textarea>
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="text" class="col-md-4 col-lg-3 col-form-label">Price</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="price" type="text" class="form-control" id="price" value="<%= price%>">
                                            </div>
                                        </div>

                                        <div class="text-center">
                                            <input type="submit" class="btn btn-primary" value="Update">
                                        </div>
                                    </form>
                                    <%
                                            } else {
                                                // Food item not found
                                                out.println("Food item not found");
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

        <jsp:include page="includes/script.jsp" />
    </body>

</html>

