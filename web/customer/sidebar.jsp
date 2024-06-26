<%-- 
    Document   : sidebar
    Created on : 5 Jan 2024, 4:43:03 pm
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-heading">Pages</li>

        <li class="nav-item">
            <a class="nav-link collapsed" href="customer.jsp">
                <i class="bi bi-person"></i>
                <span>Profile</span>
            </a>
        </li><!-- End Profile Page Nav -->

        <!-- Add About Us Section -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="about.jsp">
                <i class="bi bi-info-circle"></i>
                <span>About Us</span>
            </a>
        </li><!-- End About Us Page Nav -->

        <!-- Add Contact Section -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="contact.jsp">
                <i class="bi bi-telephone"></i>
                <span>Contact</span>
            </a>
        </li><!-- End Contact Page Nav -->

        <!-- Add Menu Section -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="menu.jsp">
                <i class="bi bi-list"></i>
                <span>Menu</span>
            </a>
        </li><!-- End Menu Page Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="customerLogin.jsp">
                <i class="bi bi-box-arrow-in-right"></i>
                <span>Log Out</span>
            </a>
        </li><!-- End Logout page Nav -->

    </ul>

</aside><!-- End Sidebar -->
