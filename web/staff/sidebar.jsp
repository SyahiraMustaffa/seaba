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
            <a class="nav-link collapsed" href="staff.jsp">
                <i class="bi bi-person"></i>
                <span>Profile</span>
            </a>
        </li><!-- End Profile Page Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" data-bs-target="#attendance-nav" data-bs-toggle="collapse" href="#">
                <i class="bi bi-clock"></i><span>Attendance</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="attendance-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                <li>
                    <a href="clockInOut.jsp">
                        <i class="bi bi-circle"></i><span>Clock In/Clock Out</span>
                    </a>
                </li>
                <!-- Add a link to the dashboard here -->
                <li>
                    <a href="dashboard.jsp">
                        <i class="bi bi-house"></i><span>Dashboard</span>
                    </a>
                </li>
                <li>
                    <a href="overtimeRequest.jsp">
                        <i class="bi bi-house"></i><span>Request Overtime</span>
                    </a>
                </li>
            </ul>
        </li><!-- End Attendance Nav -->

        <li class="nav-item">
            <a class="nav-link collapsed" href="staffManagerLogin.jsp">
                <i class="bi bi-box-arrow-in-right"></i>
                <span>Log Out</span>
            </a>
        </li><!-- End Logout page Nav -->

    </ul>

</aside><!-- End Sidebar -->
