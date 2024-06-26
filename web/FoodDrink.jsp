<%-- 
    Document   : FoodDrink
    Created on : 18 May 2024, 1:00:19 pm
    Author     : user
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Seaba Seafood Management System - Manage Items</title>

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
            <h1>Manage Items</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="manager.jsp">Home</a></li>
                    <li class="breadcrumb-item active">Manage Items</li>
                </ol>
            </nav>
        </div><!-- End Page Title -->

        <%
            List<Map<String, Object>> foodList = new ArrayList<>();
            List<Map<String, Object>> drinkList = new ArrayList<>();
            try {
                // Establish db connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                String dbURL = "jdbc:mysql://localhost:3306/seaba";
                Connection conn = DriverManager.getConnection(dbURL, "root", "admin");

                // Prepare and execute the SQL statement for food items
                String foodSql = "SELECT * FROM food";
                Statement foodStmt = conn.createStatement();

                // Execute the query to retrieve all food items
                ResultSet foodRs = foodStmt.executeQuery(foodSql);

                // Iterate through the result set and populate the food list
                while (foodRs.next()) {
                    Map<String, Object> food = new HashMap<>();
                    food.put("id", foodRs.getInt("id"));
                    food.put("food_name", foodRs.getString("food_name"));
                    food.put("description", foodRs.getString("description"));
                    food.put("price", foodRs.getDouble("price"));
                    food.put("image", foodRs.getBlob("image"));
                    foodList.add(food);
                }

                // Prepare and execute the SQL statement for drink items
                String drinkSql = "SELECT * FROM drink";
                Statement drinkStmt = conn.createStatement();

                // Execute the query to retrieve all drink items
                ResultSet drinkRs = drinkStmt.executeQuery(drinkSql);

                // Iterate through the result set and populate the drink list
                while (drinkRs.next()) {
                    Map<String, Object> drink = new HashMap<>();
                    drink.put("id", drinkRs.getInt("drink_id"));
                    drink.put("drink_name", drinkRs.getString("drink_name"));
                    drink.put("description", drinkRs.getString("drinkDescription"));
                    drink.put("price", drinkRs.getDouble("drinkPrice"));
                    drink.put("image", drinkRs.getBlob("image"));
                    drinkList.add(drink);
                }

                // Close the database resources
                foodRs.close();
                foodStmt.close();
                drinkRs.close();
                drinkStmt.close();
                conn.close();

                // Set the foodList and drinkList attributes to make them accessible in the JSP page
                request.setAttribute("foodList", foodList);
                request.setAttribute("drinkList", drinkList);

            } catch (Exception e) {
                // Handle exceptions
                e.printStackTrace();
            }
        %>

        <!-- All food items list -->
        <div class="col-12">
            <div class="card overflow-auto">
                <div class="card-body">
                    <h5 class="card-title">All Food Items List</h5>
                    <a href="manageFood.jsp" class="btn btn-success">Add Food Item</a>

                    <table class="table table-borderless datatable">
                        <thead>
                            <tr>
                                <th scope="col">#ID</th>
                                <th scope="col">Name</th>
                                <th scope="col">Description</th>
                                <th scope="col">Price</th>
                                <th scope="col">Image</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                // Access the existing foodList variable
                                if (foodList != null && !foodList.isEmpty()) {
                                    // Iterate through the food list and populate the table rows
                                    for (Map<String, Object> food : foodList) {
                            %>
                            <tr>
                                <td><%= food.get("id") %></td>
                                <td><%= food.get("food_name") %></td>
                                <td><%= food.get("description") %></td>
                                <td>RM<%= food.get("price") %></td>
                                <td>
                                    <img src="viewFood.jsp?id=<%= food.get("id") %>" alt="<%= food.get("food_name") %>" style="max-width: 100px;">
                                </td>
                                <td>
                                    <a href="editFood.jsp?id=<%= food.get("id") %>" class="btn btn-warning">Edit</a>
                                    <a href="deleteFood.jsp?id=<%= food.get("id") %>" class="btn btn-danger">Delete</a>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="6">No food items available.</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div><!-- End All Food Items List -->

        <!-- All drink items list -->
        <div class="col-12 mt-4">
            <div class="card overflow-auto">
                <div class="card-body">
                    <h5 class="card-title">All Drink Items List</h5>
                    <a href="manageDrink.jsp" class="btn btn-success">Add Drink Item</a>

                    <table class="table table-borderless datatable">
                        <thead>
                            <tr>
                                <th scope="col">#ID</th>
                                <th scope="col">Name</th>
                                <th scope="col">Description</th>
                                <th scope="col">Price</th>
                                <th scope="col">Image</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%
                                // Access the existing drinkList variable
                                if (drinkList != null && !drinkList.isEmpty()) {
                                    // Iterate through the drink list and populate the table rows
                                    for (Map<String, Object> drink : drinkList) {
                            %>
                            <tr>
                                <td><%= drink.get("id") %></td>
                                <td><%= drink.get("drink_name") %></td>
                                <td><%= drink.get("description") %></td>
                                <td>RM<%= drink.get("price") %></td>
                                <td>
                                    <img src="viewDrink.jsp?id=<%= drink.get("id") %>" alt="<%= drink.get("drink_name") %>" style="max-width: 100px;">
                                </td>
                                <td>
                                    <a href="editDrink.jsp?id=<%= drink.get("id") %>" class="btn btn-warning">Edit</a>
                                    <a href="deleteDrink.jsp?id=<%= drink.get("id") %>" class="btn btn-danger">Delete</a>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="6">No drink items available.</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div><!-- End All Drink Items List -->

    </main><!-- End #main -->

    <!-- Include your footer and script includes here -->
    <jsp:include page="includes/footer.jsp" />

    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

    <jsp:include page="includes/script.jsp" />

</body>

</html>
