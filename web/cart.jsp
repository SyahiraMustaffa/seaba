<%@ page import="java.util.*, java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Seaba Seafood Management System - Cart</title>

        <!-- Favicons -->
        <link href="assets/img/seaba raya logo.png" rel="icon">
        <link href="assets/img/SeabaSeafood-touch-icon.png" rel="SeabaSeafood-touch-icon">
        <!-- Google Fonts -->
        <link href="https://fonts.gstatic.com" rel="preconnect">

        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">

        <script>
            function loadCart() {
                let cart = JSON.parse(localStorage.getItem('cart')) || [];
                let cartTable = document.getElementById('cartTable');
                let total = 0;

                // Clear existing table content
                cartTable.innerHTML = '';

                cart.forEach((item, index) => {
                    let row = cartTable.insertRow();
                    row.setAttribute('data-id', item.id);

                    let itemNameCell = row.insertCell(0);
                    itemNameCell.innerText = item.name;

                    let priceCell = row.insertCell(1);
                    priceCell.innerText = 'RM' + item.price;

                    let quantityCell = row.insertCell(2);
                    quantityCell.className = 'quantity';
                    let quantity = item.quantity || 1; // Default quantity is 1
                    quantityCell.innerText = quantity;

                    let incButton = document.createElement('button');
                    incButton.className = 'btn btn-sm btn-outline-secondary';
                    incButton.innerText = '+';
                    incButton.onclick = function () {
                        quantity++;
                        updateQuantity(index, quantity);
                    };
                    quantityCell.appendChild(incButton);

                    let decButton = document.createElement('button');
                    decButton.className = 'btn btn-sm btn-outline-secondary';
                    decButton.innerText = '-';
                    decButton.onclick = function () {
                        if (quantity > 1) {
                            quantity--;
                            updateQuantity(index, quantity);
                        }
                    };
                    quantityCell.appendChild(decButton);

                    let removeButton = document.createElement('button');
                    removeButton.className = 'btn btn-sm btn-outline-danger';
                    removeButton.innerText = 'Remove';
                    removeButton.onclick = function () {
                        removeItem(index);
                    };
                    quantityCell.appendChild(removeButton);

                    total += item.price * quantity;
                });

                document.getElementById('total').innerText = 'Total: RM' + total.toFixed(2);
            }

            function updateQuantity(index, quantity) {
                let cart = JSON.parse(localStorage.getItem('cart')) || [];
                cart[index].quantity = quantity;
                localStorage.setItem('cart', JSON.stringify(cart));
                loadCart();
            }

            function removeItem(index) {
                let cart = JSON.parse(localStorage.getItem('cart')) || [];
                cart.splice(index, 1);
                localStorage.setItem('cart', JSON.stringify(cart));
                loadCart();
            }

            function submitCart() {
                let cart = JSON.parse(localStorage.getItem('cart')) || [];
                fetch('submitCart.jsp', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(cart)
                })
                .then(response => response.blob())  // Receive response as Blob
                .then(blob => {
                    // Create download link for the PDF Blob
                    const url = window.URL.createObjectURL(new Blob([blob]));
                    const a = document.createElement('a');
                    a.style.display = 'none';
                    a.href = url;
                    a.download = 'Seaba receipt.pdf';  // Set filename for the downloaded file
                    document.body.appendChild(a);
                    a.click();
                    window.URL.revokeObjectURL(url);

                    // Clear the cart after download completes
                    localStorage.removeItem('cart');

                    // Redirect to menu.jsp after download completes
                    window.location.href = 'menu.jsp';
                })
                .catch(error => console.error('Error downloading PDF:', error));
            }

            window.onload = loadCart;
        </script>

    </head>

    <body>

        <main id="main" class="main">
            <div class="pagetitle">
                <h1>Shopping Cart</h1>
            </div><!-- End Page Title -->

            <div class="container">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Item Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                        </tr>
                    </thead>
                    <tbody id="cartTable">
                    </tbody>
                </table>
                <p id="total"></p>
                <button class="btn btn-primary" onclick="submitCart()">Submit Cart</button>
            </div>

        </main>
        <jsp:include page="customer/sidebar.jsp" />
        <jsp:include page="customer/header.jsp" />
        <jsp:include page="includes/footer.jsp" />
        <jsp:include page="includes/script.jsp" />

        <!-- Bootstrap JS -->
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>

</html>
