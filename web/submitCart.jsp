<%@ page import="java.util.*, java.sql.*, java.io.*, com.itextpdf.text.*, com.itextpdf.text.pdf.*, org.json.*" %>
<%@ page contentType="application/json;charset=UTF-8" %>
<%
    String errorMessage = null;
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    Connection conn = null;

    try {
        // Retrieve the cart from the request body
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        String cartJson = sb.toString();
        JSONArray cart = new JSONArray(cartJson);

        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        String dbURL = "jdbc:mysql://localhost:3306/seaba";
        conn = DriverManager.getConnection(dbURL, "root", "admin");

        // Insert the order into the database
        String orderSql = "INSERT INTO orders (order_date) VALUES (NOW())";
        PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
        orderStmt.executeUpdate();
        ResultSet rs = orderStmt.getGeneratedKeys();
        rs.next();
        int orderId = rs.getInt(1);

        String orderDetailsSql = "INSERT INTO order_details (order_id, food_id, quantity, price) VALUES (?, ?, ?, ?)";
        PreparedStatement orderDetailsStmt = conn.prepareStatement(orderDetailsSql);

        for (int i = 0; i < cart.length(); i++) {
            JSONObject item = cart.getJSONObject(i);
            int foodId = item.getInt("id");
            int quantity = item.getInt("quantity");
            double price = item.getDouble("price");

            orderDetailsStmt.setInt(1, orderId);
            orderDetailsStmt.setInt(2, foodId);
            orderDetailsStmt.setInt(3, quantity);
            orderDetailsStmt.setDouble(4, price);
            orderDetailsStmt.executeUpdate();
        }

        // Generate the receipt PDF
        Document document = new Document();
        PdfWriter.getInstance(document, baos);
        document.open();

        // Add logo
        String logoPath = application.getRealPath("/") + "assets/img/seaba raya logo.png";
        Image logo = Image.getInstance(logoPath);
        logo.scaleToFit(150, 100); // Adjust the logo size
        logo.setAlignment(Element.ALIGN_CENTER);
        document.add(logo);
        
        // Add space after logo
        document.add(new Paragraph(" "));

        // Add content to the PDF
        Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16);
        Font subHeaderFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12);
        Font normalFont = FontFactory.getFont(FontFactory.HELVETICA, 10);
        Font boldFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10);

        // Add header
        document.add(new Paragraph("Seaba Seafood Management System - Receipt", headerFont));
        document.add(new Paragraph("Order ID: " + orderId, normalFont));
        document.add(new Paragraph("Date: " + new java.util.Date(), normalFont));
        document.add(new Paragraph(" "));

        // Add table
        PdfPTable table = new PdfPTable(4);
        table.setWidthPercentage(100);
        table.setWidths(new int[]{3, 1, 1, 1});

        PdfPCell cell;

        cell = new PdfPCell(new Phrase("Item Name", boldFont));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
        table.addCell(cell);

        cell = new PdfPCell(new Phrase("Price (RM)", boldFont));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
        table.addCell(cell);

        cell = new PdfPCell(new Phrase("Quantity", boldFont));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
        table.addCell(cell);

        cell = new PdfPCell(new Phrase("Total (RM)", boldFont));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
        table.addCell(cell);

        double total = 0;
        for (int i = 0; i < cart.length(); i++) {
            JSONObject item = cart.getJSONObject(i);
            String name = item.getString("name");
            double price = item.getDouble("price");
            int quantity = item.getInt("quantity");
            double itemTotal = price * quantity;

            cell = new PdfPCell(new Phrase(name, normalFont));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Phrase(String.format("%.2f", price), normalFont));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Phrase(String.valueOf(quantity), normalFont));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            cell = new PdfPCell(new Phrase(String.format("%.2f", itemTotal), normalFont));
            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell);

            total += itemTotal;
        }

        cell = new PdfPCell(new Phrase(""));
        cell.setColspan(2);
        cell.setBorder(Rectangle.NO_BORDER);
        table.addCell(cell);

        cell = new PdfPCell(new Phrase("Total", boldFont));
        cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        table.addCell(cell);

        cell = new PdfPCell(new Phrase(String.format("RM %.2f", total), boldFont));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(cell);

        document.add(table);
        document.close();

        // Send the PDF as response
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=receipt.pdf");
        response.setContentLength(baos.size());

        OutputStream os = response.getOutputStream();
        baos.writeTo(os);
        os.flush();
        os.close();

    } catch (Exception e) {
        errorMessage = "Error: " + e.getMessage();
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                if (errorMessage == null) {
                    errorMessage = "Error closing connection: " + e.getMessage();
                }
            }
        }
    }

    if (errorMessage != null) {
%>
    {"error": "<%= errorMessage %>"}
<%
    }
%>
