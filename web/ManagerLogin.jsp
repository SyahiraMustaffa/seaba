<%-- 
    Document   : ManagerLogin
    Created on : 11 Jan 2024, 1:07:21 pm
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Seaba Seafood Management System - Manager Login</title>

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
        <!-- Manager Login Page Content -->
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-4 col-md-6">
                    <div class="card mt-5">
                        <div class="card-body">
                            <h5 class="card-title text-center">Manager Login</h5>
                            <form action="validateManager.jsp" method="POST" class="row g-3 needs-validation">
                                <div class="col-12">
                                    <label for="managerId" class="form-label">Manager ID</label>
                                    <input type="text" name="managerId" class="form-control" id="managerId" required
                                           placeholder="Enter Manager ID">
                                </div>
                                <div class="col-12">
                                    <label for="managerPassword" class="form-label">Password</label>
                                    <input type="password" name="managerPassword" class="form-control" id="password"
                                           required placeholder="Enter Password">
                                </div>
                                <div class="col-12">
                                    <button class="btn btn-primary w-100" type="submit">Login</button>
                                </div>
                            </form>
                            <div class="text-center mt-3">
                                <a href="roleSelection.jsp" class="btn btn-secondary">Back to Role Selection</a>
                            </div>

                            <!-- Placeholder for error handling -->
                            <% String error = request.getParameter("error");
                                if (error != null) {
                                    if (error.equals("1")) { %>
                            <div class="alert alert-danger mt-3" role="alert">
                                Invalid login credentials. Please try again.
                            </div>
                            <%      } else if (error.equals("2")) { %>
                            <div class="alert alert-danger mt-3" role="alert">
                                An error occurred. Please try again later.
                            </div>
                            <%      }
                            } %>

                            <!-- Check for successful login and redirect -->
                            <% String success = request.getParameter("success");
                            if (success != null && success.equals("1")) { %>
                            <script>
                                // Redirect after a short delay
                                setTimeout(function () {
                                    window.location.replace("manager.jsp");
                                }, 2000);
                            </script>
                            <%  }%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

</html>
