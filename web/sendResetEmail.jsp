<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.UUID, javax.mail.*, javax.mail.internet.*, java.util.Properties" %>
<%@ page import="java.sql.*, java.util.Date" %>

<%
    String email = request.getParameter("email");
    String token = UUID.randomUUID().toString();

    // Update token for the existing email in the database
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/seaba", "root", "admin");
        PreparedStatement ps = conn.prepareStatement("UPDATE customers SET token = ? WHERE custEmail = ?");
        ps.setString(1, token);
        ps.setString(2, email);
        int rowsUpdated = ps.executeUpdate();
        ps.close();
        conn.close();
        
        if (rowsUpdated == 0) {
            out.println("<p>No user found with the provided email address.</p>");
            return;
        }
    } catch (SQLException e) {
        out.println("<p>Database error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } catch (Exception e) {
        out.println("<p>Database error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }

    // Construct the reset password link
    String resetLink = "http://localhost:8080/Seaba/updatePassword.jsp?token=" + token;

    // Send email with reset link
    String host = "smtp.gmail.com";
    final String from = "syahiraira584@gmail.com"; // Your email
    final String pass = "vcyq hspz aztq nkvf"; // App-specific password generated from Gmail
    String to = email;
    String subject = "Password Reset";
    String body = "Click the link to reset your password:\n" + resetLink;

    Properties props = new Properties();
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.smtp.host", host);
    props.put("mail.smtp.port", "587");
    props.put("mail.smtp.auth", "true");

    Session mailSession = Session.getInstance(props, new Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(from, pass);
        }
    });

    boolean emailSent = false;
    try {
        MimeMessage message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(from));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject(subject);
        message.setText(body);
        Transport.send(message);
        emailSent = true;
    } catch (MessagingException mex) {
        out.println("<p>Email error: " + mex.getMessage() + "</p>");
        mex.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Seaba Seafood Management System - Forgot Password</title>

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
    <h2>Password Reset Email Sent</h2>
    <% if (emailSent) { %>
        <p>An email with instructions to reset your password has been sent to your email address.</p>
    <% } else { %>
        <p>There was an error sending the email. Please try again later.</p>
    <% } %>
    <p><a href="forgotPassword.jsp">Go Back</a></p>
</body>
</html>
