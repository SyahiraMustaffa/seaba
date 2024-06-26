<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>About Us - Seaba Seafood Management System</title>

    <!-- Favicons -->
    <link href="assets/img/seaba raya logo.png" rel="icon">
    <link href="assets/img/SeabaSeafood-touch-icon.png" rel="SeabaSeafood-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        .about-section {
            padding: 60px 0;
            text-align: center;
            background-color: #f8f9fa;
        }

        .about-section h2 {
            font-size: 2.5em;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .about-section p {
            font-size: 1.1em;
            margin-bottom: 40px;
            line-height: 1.8;
        }

        .about-img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
        }
    </style>
    
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const links = document.querySelectorAll('a[href^="#"]');
            for (const link of links) {
                link.addEventListener("click", function (e) {
                    e.preventDefault();
                    document.querySelector(this.getAttribute("href")).scrollIntoView({
                        behavior: "smooth"
                    });
                });
            }
        });
    </script>
</head>

<body>
    <!-- Include your header and sidebar here -->
    <jsp:include page="includes/header.jsp" />
    <jsp:include page="customer/sidebar.jsp" />



    <!-- Main Content -->
      <main id="main" class="main">
        <div class="pagetitle">
            <h1>About Us</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="customer.jsp">Home</a></li>
                    <li class="breadcrumb-item active">About Us</li>
                </ol>
            </nav>
        </div><!-- End Page Title -->
        <!-- Header Title -->
        <header class="d-flex justify-content-center py-3 bg-dark text-white">
            <h1>About Seaba</h1>
        </header>

        <!-- Carousel -->
        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="assets/img/seafood_1.jpg" class="d-block w-100" alt="Slide 1">
                </div>
                <div class="carousel-item">
                    <img src="assets/img/beach2.jpg" class="d-block w-100" alt="Slide 2">
                </div>
                <div class="carousel-item">
                    <img src="assets/img/img.jpg" class="d-block w-100" alt="Slide 3">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>

        <!-- About Us Section -->
        <div class="about-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <h2>Welcome to Seaba Seafood Management System</h2>
                        <p>
                            Seaba Seafood Management System is dedicated to providing the freshest and most delicious seafood
                            to our valued customers. Our commitment to quality and service is unmatched, and we strive to
                            exceed your expectations with every meal.
                        </p>
                        <p>
                            Our team of expert chefs and seafood specialists work tirelessly to source the best seafood
                            from around the world, ensuring that every dish we serve is a testament to our passion for
                            excellence. Whether you're dining in or ordering takeout, we promise a memorable culinary
                            experience.
                        </p>
                        <img src="assets/img/about-us.jpg" class="about-img" alt="About Us Image">
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <jsp:include page="includes/footer.jsp" />
    <jsp:include page="includes/script.jsp" />

    <!-- Bootstrap JS -->
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>

</html>
