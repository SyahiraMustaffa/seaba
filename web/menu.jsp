<%@ page import="java.sql.*, java.util.*, java.util.Base64" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Seaba Seafood Management System - Menu</title>

        <!-- Favicons -->
        <link href="assets/img/seaba raya logo.png" rel="icon">
        <link href="assets/img/SeabaSeafood-touch-icon.png" rel="SeabaSeafood-touch-icon">

        <!-- Google Fonts -->
        <link href="https://fonts.gstatic.com" rel="preconnect">

        <!-- Vendor CSS Files -->
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">

        <!-- Custom CSS for Images -->
        <style>
            .menu-item-image {
                width: 200px; /* Set a fixed width */
                height: 200px; /* Set a fixed height */
                object-fit: cover; /* Maintain aspect ratio and crop if necessary */
            }
        </style>

        <script>
            function addToCart(itemId, itemName, price, quantity) {
                const cartItem = {id: itemId, name: itemName, price: price, quantity: quantity};
                let cart = JSON.parse(localStorage.getItem('cart')) || [];
                cart.push(cartItem);
                localStorage.setItem('cart', JSON.stringify(cart));
                alert('Item added to cart!');
            }

            function updateQuantity(itemId, increment) {
                let quantityInput = document.getElementById('quantity-' + itemId);
                let currentQuantity = parseInt(quantityInput.value);
                if (increment) {
                    quantityInput.value = currentQuantity + 1;
                } else {
                    if (currentQuantity > 1) {
                        quantityInput.value = currentQuantity - 1;
                    }
                }
            }

            function goToReceipt() {
                window.location.href = 'cart.jsp';
            }

            function showCategory(category) {
                document.querySelectorAll('.menu-category').forEach(el => el.style.display = 'none');
                document.getElementById(category).style.display = 'block';
            }
        </script>
    </head>

    <body>

        <main id="main" class="main">
            <div class="pagetitle">
                <h1>Menu</h1>
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="customer.jsp">Customer</a></li>
                        <li class="breadcrumb-item active">Menu</li>
                    </ol>
                </nav>
            </div><!-- End Page Title -->

            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-3">
                        <div class="list-group">
                            <a href="#" class="list-group-item list-group-item-action" onclick="showCategory('foods')">Foods</a>
                            <a href="#" class="list-group-item list-group-item-action" onclick="showCategory('drinks')">Drinks</a>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div id="foods" class="menu-category">
                            <h2>Food Items</h2>
                            <div class="row">
                                <%
                                    List<Map<String, Object>> foodList = new ArrayList<>();
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        String dbURL = "jdbc:mysql://localhost:3306/seaba";
                                        Connection conn = DriverManager.getConnection(dbURL, "root", "admin");
                                        String sql = "SELECT * FROM food";
                                        Statement stmt = conn.createStatement();
                                        ResultSet rs = stmt.executeQuery(sql);

                                        while (rs.next()) {
                                            Map<String, Object> food = new HashMap<>();
                                            food.put("id", rs.getInt("id"));
                                            food.put("food_name", rs.getString("food_name"));
                                            food.put("description", rs.getString("description"));
                                            food.put("price", rs.getDouble("price"));
                                            food.put("image", rs.getBlob("image"));
                                            foodList.add(food);
                                        }

                                        rs.close();
                                        stmt.close();
                                        conn.close();
                                    } catch (Exception e) {
                                %>
                                <div class="alert alert-danger" role="alert">
                                    Error: <%= e.getMessage()%>
                                </div>
                                <%
                                    }

                                    if (foodList.isEmpty()) {
                                %>
                                <div class="alert alert-warning" role="alert">
                                    No food items available.
                                </div>
                                <%
                                } else {
                                    for (Map<String, Object> food : foodList) {
                                        int foodId = (Integer) food.get("id");
                                        String foodName = (String) food.get("food_name");
                                        String description = (String) food.get("description");
                                        double price = (Double) food.get("price");
                                        Blob imageBlob = (Blob) food.get("image");
                                        byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                                        String imageBase64 = Base64.getEncoder().encodeToString(imageBytes);
                                %>
                                <div class="col-md-4">
                                    <div class="card mb-4 shadow-sm h-100">
                                        <img src="data:image/jpeg;base64,<%= imageBase64%>" class="card-img-top menu-item-image" alt="<%= foodName%>">
                                        <div class="card-body d-flex flex-column">
                                            <h5 class="card-title"><%= foodName%></h5>
                                            <p class="card-text"><%= description%></p>
                                            <p class="card-text">RM<%= price%></p>
                                            <div class="input-group mb-3">
                                                <button class="btn btn-outline-secondary" type="button" onclick="updateQuantity(<%= foodId%>, false)">-</button>
                                                <input type="text" class="form-control text-center" id="quantity-<%= foodId%>" value="1" readonly>
                                                <button class="btn btn-outline-secondary" type="button" onclick="updateQuantity(<%= foodId%>, true)">+</button>
                                            </div>
                                            <button class="btn btn-primary mt-auto" onclick="addToCart(<%= foodId%>, '<%= foodName%>', <%= price%>, document.getElementById('quantity-<%= foodId%>').value)">Add to Cart</button>
                                        </div>
                                    </div>
                                </div>
                                <%
                                        }
                                    }
                                %>
                            </div>
                        </div>

                        <div id="drinks" class="menu-category" style="display:none;">
                            <h2>Drink Items</h2>
                            <div class="row">
                                <%
                                List<Map<String, Object>> drinkList = new ArrayList<>();
                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    String dbURL = "jdbc:mysql://localhost:3306/seaba";
                                    Connection conn = DriverManager.getConnection(dbURL, "root", "admin");
                                    String sql = "SELECT * FROM drink";
                                    Statement stmt = conn.createStatement();
                                    ResultSet rs = stmt.executeQuery(sql);

                                    while (rs.next()) {
                                        Map<String, Object> drink = new HashMap<>();
                                        drink.put("id", rs.getInt("drink_id"));
                                        drink.put("drink_name", rs.getString("drink_name"));
                                        drink.put("description", rs.getString("drinkDescription"));
                                        drink.put("price", rs.getDouble("drinkPrice"));
                                        drink.put("image", rs.getBlob("image"));
                                        drinkList.add(drink);
                                    }

                                    rs.close();
                                    stmt.close();
                                    conn.close();
                                } catch (Exception e) {
                            %>
                            <div class="alert alert-danger" role="alert">
                                Error: <%= e.getMessage() %>
                            </div>
                            <%
                                }

                                if (drinkList.isEmpty()) {
                            %>
                            <div class="alert alert-warning" role="alert">
                                No drink items available.
                            </div>
                            <%
                            } else {
                                for (Map<String, Object> drink : drinkList) {
                                    int drinkId = (Integer) drink.get("id");
                                    String drinkName = (String) drink.get("drink_name");
                                    String description = (String) drink.get("description");
                                    double price = (Double) drink.get("price");
                                    Blob imageBlob = (Blob) drink.get("image");
                                    byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                                    String imageBase64 = Base64.getEncoder().encodeToString(imageBytes);
                            %>
                            <div class="col-md-4">
                                <div class="card mb-4 shadow-sm h-100">
                                    <img src="data:image/jpeg;base64,<%= imageBase64 %>" class="card-img-top" alt="<%= drinkName %>">
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title"><%= drinkName %></h5>
                                        <p class="card-text"><%= description %></p>
                                        <p class="card-text">RM<%= price %></p>
                                        <div class="input-group mb-3">
                                            <button class="btn btn-outline-secondary" type="button" onclick="updateQuantity(<%= drinkId %>, false)">-</button>
                                            <input type="text" class="form-control text-center" id="quantity-<%= drinkId %>" value="1" readonly>
                                            <button class="btn btn-outline-secondary" type="button" onclick="updateQuantity(<%= drinkId %>, true)">+</button>
                                        </div>
                                        <button class="btn btn-primary mt-auto" onclick="addToCart(<%= drinkId %>, '<%= drinkName %>', <%= price %>, document.getElementById('quantity-<%= drinkId %>').value)">Add to Cart</button>
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            }
                            %>
                        </div>
                    </div>
                    <button class="btn btn-success" onclick="goToReceipt()">Go to Cart</button>
                </div>
            </div>
        </div>
    </main>
    <jsp:include page="customer/sidebar.jsp" />
    <jsp:include page="customer/header.jsp" />
    <jsp:include page="includes/footer.jsp" />
    <jsp:include page="includes/script.jsp" />

</body>

</html>
