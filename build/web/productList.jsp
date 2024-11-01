<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Java_JDBC" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.servlet.jsp.jstl.core.*" %>
<html>
<head>
    <title>Product List</title>
    <link rel="stylesheet" type="text/css" href="styles.css"> <!-- Link to your CSS -->
</head>
<body>
    <h1>Product List</h1>
    
    <%
        // Initialize the list of products
        List<Product> products = new ArrayList<>();
        
        String brand = request.getParameter("brand");
        
        try {
            // Check if brand parameter is provided
            if (brand != null && !brand.isEmpty()) {
                // Retrieve products by brand
                products = Java_JDBC.getProductsByBrand(brand);
            } else {
                // Retrieve all products
                products = Java_JDBC.getAllProducts();
            }
        } catch (Exception e) {
            out.println("<p>Error retrieving product list: " + e.getMessage() + "</p>");
        }

        // Check if the products list is not empty
        if (!products.isEmpty()) {
    %>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Brand</th>
                        <th>Price</th>
                        <th>Description</th>
                        <th>Image</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    // Iterate through the products and display them in the table
                    for (Product product : products) {
                %>
                    <tr>
                        <td><%= product.getId() %></td>
                        <td><%= product.getName() %></td>
                        <td><%= product.getBrand() %></td>
                        <td><%= product.getPrice() %></td>
                        <td><%= product.getDescription() %></td>
                        <td><img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>" width="100"></td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
    <%
        } else {
            out.println("<p>No products available.</p>");
        }
    %>
</body>
</html>
