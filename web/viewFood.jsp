<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>

<%
    // JDBC connection settings
    String dbURL = "jdbc:mysql://localhost:3306/seaba";
    String dbUser = "root";
    String dbPassword = "admin";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    InputStream imageStream = null;

    try {
        // Get the food ID from the request parameter
        String id = request.getParameter("id");

        // Connect to the database
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        // Retrieve the image from the database
        String sql = "SELECT image FROM food WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(id));
        rs = stmt.executeQuery();

        if (rs.next()) {
            // Get the image as an InputStream
            imageStream = rs.getBinaryStream("image");

            // Set the response content type to the appropriate image type
            response.setContentType("image/jpeg");

            // Write the image to the response output stream
            ServletOutputStream servletOut = response.getOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead = -1;

            while ((bytesRead = imageStream.read(buffer)) != -1) {
                servletOut.write(buffer, 0, bytesRead);
            }

            servletOut.flush();
            servletOut.close();
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        if (imageStream != null) try { imageStream.close(); } catch (IOException ignore) {}
    }
%>
