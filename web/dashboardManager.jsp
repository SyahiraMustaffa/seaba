<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.time.*, java.time.format.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Seaba Seafood Management System - Dashboard</title>

        <!-- Favicons -->
        <link href="assets/img/seaba raya logo.png" rel="icon">
        <link href="assets/img/SeabaSeafood-touch-icon.png" rel="SeabaSeafood-touch-icon">

        <!-- Google Fonts -->
        <link href="https://fonts.gstatic.com" rel="preconnect">

        <!-- Vendor CSS Files -->
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">

        <!-- Include the shared CSS -->
        <link href="assets/css/shared-style.css" rel="stylesheet">
    </head>
    <body>
        <%
            String dbURL = "jdbc:mysql://localhost:3306/seaba";
            String dbUser = "root";
            String dbPassword = "admin";
            int totalCustomers = 0;
            int totalFood = 0;
            int totalSales = 0;
            int totalStaff = 0;
            String topSellingProduct = "";
            int topSellingCount = 0;
            String filter = request.getParameter("filter");

            // Determine date range based on filter
            LocalDate startDate = null;
            LocalDate endDate = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            if ("today".equals(filter)) {
                startDate = LocalDate.now();
            } else if ("month".equals(filter)) {
                startDate = endDate.withDayOfMonth(1);
            } else if ("year".equals(filter)) {
                startDate = endDate.withDayOfYear(1);
            } else {
                filter = "all"; // default filter
            }

            String dateCondition = "";
            if (startDate != null) {
                dateCondition = "WHERE o.order_date BETWEEN '" + startDate.format(formatter) + "' AND '" + endDate.format(formatter) + "'";
            }

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                Statement stmt = conn.createStatement();

                // Query to get total customers based on filter
                ResultSet rsCustomers = stmt.executeQuery("SELECT COUNT(*) AS total FROM customers " + dateCondition);
                if (rsCustomers.next()) {
                    totalCustomers = rsCustomers.getInt("total");
                }

                // Query to get total food items based on filter
                ResultSet rsFood = stmt.executeQuery("SELECT COUNT(*) AS total FROM food");
                if (rsFood.next()) {
                    totalFood = rsFood.getInt("total");
                }

                // Query to get total sales based on filter
                ResultSet rsSales = stmt.executeQuery("SELECT SUM(od.quantity * f.price) AS total FROM order_details od JOIN food f ON od.food_id = f.id JOIN orders o ON od.order_id = o.order_id " + dateCondition);
                if (rsSales.next()) {
                    totalSales = rsSales.getInt("total");
                }

                // Query to get top selling product based on filter
                ResultSet rsTopSelling = stmt.executeQuery(
                        "SELECT f.food_name, SUM(od.quantity) AS count FROM order_details od JOIN food f ON od.food_id = f.id JOIN orders o ON od.order_id = o.order_id " + dateCondition + " GROUP BY f.food_name ORDER BY count DESC LIMIT 1");
                if (rsTopSelling.next()) {
                    topSellingProduct = rsTopSelling.getString("food_name");
                    topSellingCount = rsTopSelling.getInt("count");
                }

                // Query to get total staff
                ResultSet rsStaff = stmt.executeQuery("SELECT COUNT(*) AS total FROM staff");
                if (rsStaff.next()) {
                    totalStaff = rsStaff.getInt("total");
                }

                rsCustomers.close();
                rsFood.close();
                rsSales.close();
                rsStaff.close();
                rsTopSelling.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>

        <main id="main" class="main">
            <div class="pagetitle">
                <h1>Dashboard</h1>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                        <li class="breadcrumb-item active">Dashboard</li>
                    </ol>
                </nav>
            </div><!-- End Page Title -->

            <section class="section dashboard">
                <div class="row">

                    <!-- Total Customers Card -->
                    <div class="col-xxl-3 col-md-6">
                        <div class="card info-card customers-card">
                            <div class="filter">
                                <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                    <li class="dropdown-header text-start">
                                        <h6>Filter</h6>
                                    </li>
                                    <li><a class="dropdown-item" href="?filter=today">Today</a></li>
                                    <li><a class="dropdown-item" href="?filter=month">This Month</a></li>
                                    <li><a class="dropdown-item" href="?filter=year">This Year</a></li>
                                </ul>
                            </div>

                            <div class="card-body">
                                <h5 class="card-title">Customers <span>| <%= filter.substring(0, 1).toUpperCase() + filter.substring(1)%></span></h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-people"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6><%= totalCustomers%></h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!-- End Customers Card -->

                    <!-- Total Food Items Card -->
                    <div class="col-xxl-3 col-md-6">
                        <div class="card info-card food-card">
                            <div class="filter">
                                <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                    <li class="dropdown-header text-start">
                                        <h6>Filter</h6>
                                    </li>
                                    <li><a class="dropdown-item" href="?filter=today">Today</a></li>
                                    <li><a class="dropdown-item" href="?filter=month">This Month</a></li>
                                    <li><a class="dropdown-item" href="?filter=year">This Year</a></li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">Food Items <span>| <%= filter.substring(0, 1).toUpperCase() + filter.substring(1)%></span></h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-box-seam"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6><%= totalFood%></h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!-- End Food Items Card -->

                    <!-- Top Selling Product Card -->
                    <div class="col-xxl-3 col-md-6">
                        <div class="card info-card top-selling-card">
                            <div class="filter">
                                <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                    <li class="dropdown-header text-start">
                                        <h6>Filter</h6>
                                    </li>
                                    <li><a class="dropdown-item" href="?filter=today">Today</a></li>
                                    <li><a class="dropdown-item" href="?filter=month">This Month</a></li>
                                    <li><a class="dropdown-item" href="?filter=year">This Year</a></li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">Top Selling <span>| <%= filter.substring(0, 1).toUpperCase() + filter.substring(1)%></span></h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-star"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6><%= topSellingProduct%></h6>
                                        <span class="text-primary small pt-1 fw-bold"><%= topSellingCount%> units</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!-- End Top Selling Product Card -->

                    <!-- Total Sales Card -->
                    <div class="col-xxl-3 col-md-6">
                        <div class="card info-card sales-card">
                            <div class="filter">
                                <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                    <li class="dropdown-header text-start">
                                        <h6>Filter</h6>
                                    </li>
                                    <li><a class="dropdown-item" href="?filter=today">Today</a></li>
                                    <li><a class="dropdown-item" href="?filter=month">This Month</a></li>
                                    <li><a class="dropdown-item" href="?filter=year">This Year</a></li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">Total Sales <span>| <%= filter.substring(0, 1).toUpperCase() + filter.substring(1)%></span></h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-currency-dollar"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6>$<%= totalSales%></h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!-- End Total Sales Card -->

                    <!-- Total Staff Card -->
                    <div class="col-xxl-3 col-md-6">
                        <div class="card info-card staff-card">
                            <div class="filter">
                                <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                    <li class="dropdown-header text-start">
                                        <h6>Filter</h6>
                                    </li>
                                    <li><a class="dropdown-item" href="?filter=today">Today</a></li>
                                    <li><a class="dropdown-item" href="?filter=month">This Month</a></li>
                                    <li><a class="dropdown-item" href="?filter=year">This Year</a></li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">Staff <span>| <%= filter.substring(0, 1).toUpperCase() + filter.substring(1)%></span></h5>
                                <div class="d-flex align-items-center">
                                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                                        <i class="bi bi-person-badge"></i>
                                    </div>
                                    <div class="ps-3">
                                        <h6><%= totalStaff%></h6>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div><!-- End Staff Card -->

                    <!-- ======= Recent Sales ======= -->
                    <div class="col-12">
                        <div class="card recent-sales overflow-auto">
                            <div class="filter">
                                <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                                    <li class="dropdown-header text-start">
                                        <h6>Filter</h6>
                                    </li>
                                    <li><a class="dropdown-item" href="?filter=today">Today</a></li>
                                    <li><a class="dropdown-item" href="?filter=month">This Month</a></li>
                                    <li><a class="dropdown-item" href="?filter=year">This Year</a></li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">Recent Sales <span>| <%= filter.substring(0, 1).toUpperCase() + filter.substring(1)%></span></h5>
                                <table class="table table-borderless datatable">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Order ID</th>
                                            <th scope="col">Price</th>
                                            <th scope="col">Quantity</th>
                                            <th scope="col">Total Amount</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            try {
                                                Class.forName("com.mysql.cj.jdbc.Driver");
                                                Connection connRecentSales = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                                                Statement stmtRecentSales = connRecentSales.createStatement();
                                                String recentSalesQuery = "SELECT od.order_id, f.price, od.quantity, (f.price * od.quantity) AS total_amount "
                                                        + "FROM order_details od "
                                                        + "JOIN food f ON od.food_id = f.id "
                                                        + "JOIN orders o ON od.order_id = o.order_id "
                                                        + dateCondition
                                                        + " ORDER BY o.order_date DESC LIMIT 5"; // Example: Retrieve last 5 recent sales
                                                ResultSet rsRecentSales = stmtRecentSales.executeQuery(recentSalesQuery);

                                                int count = 1;
                                                while (rsRecentSales.next()) {
                                                    int orderId = rsRecentSales.getInt("order_id");
                                                    double price = rsRecentSales.getDouble("price");
                                                    int quantity = rsRecentSales.getInt("quantity");
                                                    double totalAmount = rsRecentSales.getDouble("total_amount");

                                        %>
                                        <tr>
                                            <td><%= count%></td>
                                            <td><%= orderId%></td>
                                            <td>$<%= price%></td>
                                            <td><%= quantity%></td>
                                            <td>$<%= totalAmount%></td>
                                        </tr>
                                        <%
                                                    count++;
                                                }

                                                rsRecentSales.close();
                                                stmtRecentSales.close();
                                                connRecentSales.close();
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- End Recent Sales -->

                </div>
            </section>
        </main>

        <!-- ======= Header ======= -->
        <jsp:include page="includes/header.jsp" />

        <!-- ======= Sidebar ======= -->
        <jsp:include page="manager/sidebar.jsp" />

        <!-- ======= Footer ======= -->
        <jsp:include page="includes/footer.jsp" />

        <!-- Include the shared script -->
        <jsp:include page="includes/script.jsp" />

        <!-- Vendor JS Files -->
        <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/vendor/chart.js/chart.umd.js"></script>
        <script src="assets/vendor/echarts/echarts.min.js"></script>
        <script src="assets/vendor/quill/quill.min.js"></script>
        <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
        <script src="assets/vendor/tinymce/tinymce.min.js"></script>
        <script src="assets/vendor/php-email-form/validate.js"></script>

        <!-- Template Main JS File -->
        <script src="assets/js/main.js"></script>

    </body>
</html>
