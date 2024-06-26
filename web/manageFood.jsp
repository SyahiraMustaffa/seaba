<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.io.IOUtils"%>
<%@ page import="java.nio.file.Files"%>
<%@ page import="java.nio.file.Paths"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Seaba Seafood Management System - Manage Food</title>

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
            <h1>Manage Food</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="manager.jsp">Home</a></li>
                    <li class="breadcrumb-item active">Manage Food</li>
                </ol>
            </nav>
        </div><!-- End Page Title -->

        <!-- Add Food -->
        <div class="col-12">
            <div class="card users-list overflow-auto">
                <div class="card-body">
                    <h5 class="card-title">Add Food</h5>
                    <form method="post" action="processAddFood.jsp" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="foodName" class="form-label">Food Name</label>
                            <input type="text" class="form-control" id="foodName" name="foodName" required>
                        </div>
                        <div class="mb-3">
                            <label for="foodDescription" class="form-label">Description</label>
                            <textarea class="form-control" id="foodDescription" name="foodDescription"
                                required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="foodPrice" class="form-label">Price</label>
                            <input type="number" step="0.01" min="0" class="form-control" id="foodPrice"
                                name="foodPrice" required>
                        </div>
                        <div class="mb-3">
                            <label for="foodImage" class="form-label">Food Image</label>
                            <input type="file" class="form-control" id="foodImage" name="foodImage" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Add Food</button>
                    </form>
                </div>
            </div>
        </div><!-- End Add Food -->

        <%-- Include your Java code for adding, deleting, and retrieving food items from the database here --%>

    </main><!-- End #main -->

    <!-- Include your footer and script includes here -->
    <jsp:include page="includes/footer.jsp" />
    <jsp:include page="includes/script.jsp" />

</body>

</html>