<%-- 
    Document   : viewDrink
    Created on : 28 May 2024, 1:00:19 pm
    Author     : user
--%>

<%@ page contentType="image/jpeg" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>

<%
    // Retrieve the drink id from the request parameter
    String drinkId = request.getParameter("id");

    if (drinkId != null && !drinkId.isEmpty()) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbURL = "jdbc:mysql://localhost:3306/seaba";
            conn = DriverManager.getConnection(dbURL, "root", "admin");

            // Prepare and execute the SQL statement
            String sql = "SELECT image FROM drink WHERE drink_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(drinkId));
            rs = stmt.executeQuery();

            if (rs.next()) {
                Blob imageBlob = rs.getBlob("image");

                if (imageBlob != null) {
                    InputStream is = imageBlob.getBinaryStream();
                    OutputStream os = response.getOutputStream();
                    byte[] buffer = new byte[1024];
                    int bytesRead;

                    while ((bytesRead = is.read(buffer)) != -1) {
                        os.write(buffer, 0, bytesRead);
                    }

                    is.close();
                    os.flush();
                    os.close();
                } else {
                    out.println("No image available for this drink item.");
                }
            } else {
                out.println("No drink item found with the specified id.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    } else {
        out.println("Invalid drink id.");
    }
%>
