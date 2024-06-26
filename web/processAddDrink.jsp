<%-- 
    Document   : processAddDrink
    Created on : 5 Jun 2024, 2:24:23 am
    Author     : Syahira
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.io.IOUtils"%>

<%
    // JDBC connection settings
    String dbURL = "jdbc:mysql://localhost:3306/seaba";
    String dbUser = "root";
    String dbPassword = "admin";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet keys = null;

    // Variables to hold food item details
    String drinkName = null;
    String drinkDescription = null;
    String drinkPrice = null;
    InputStream fileContent = null;

    try {
        // Check if the form is multipart/form-data
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);

        if (isMultipart) {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);

            List<FileItem> items = upload.parseRequest(request);

            for (FileItem item : items) {
                if (item.isFormField()) {
                    // Process regular form fields
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString();

                    if (fieldName.equals("drinkName")) {
                        drinkName = fieldValue;
                    } else if (fieldName.equals("drinkDescription")) {
                        drinkDescription = fieldValue;
                    } else if (fieldName.equals("drinkPrice")) {
                        drinkPrice = fieldValue;
                    }
                } else {
                    // Process form file field (input type="file")
                    fileContent = item.getInputStream();
                }
            }

            // Connect to the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Insert the food item into the database
            String sql = "INSERT INTO drink (drink_name, drinkDescription, drinkPrice, image) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, drinkName);
            stmt.setString(2, drinkDescription);
            stmt.setDouble(3, Double.parseDouble(drinkPrice));
            stmt.setBlob(4, fileContent);

            int row = stmt.executeUpdate();
            if (row > 0) {
                
                    response.sendRedirect("FoodDrink.jsp");
            } else {
                out.println("Failed to add the food item.");
            }
        }
    } catch (Exception ex) {
        ex.printStackTrace();
        out.println("Error: " + ex.getMessage());
    } finally {
        if (keys != null) try { keys.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

