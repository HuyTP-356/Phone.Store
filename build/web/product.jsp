<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Java_JDBC" %>
<%@ page import="model.Product" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sản phẩm</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <header class="bg-primary text-white py-3">
        <div class="container">
            <h1>Chi tiết sản phẩm</h1>
        </div>
    </header>

    <div class="container my-4">
        <%
            int productId = Integer.parseInt(request.getParameter("id")); // Get product ID from query parameter
            Product product = Java_JDBC.getProductById(productId); // Fetch product details

            if (product != null) {
        %>
        <div class="card">
            <img src="<%= product.getImageUrl() %>" class="card-img-top" alt="<%= product.getName() %>">
            <div class="card-body">
                <h5 class="card-title"><%= product.getName() %></h5>
                <p class="card-text">Thương hiệu: <%= product.getBrand() %></p>
                <p class="card-text">Giá: <%= product.getPrice() %> VND</p>
                <p class="card-text">Mô tả: <%= product.getDescription() %></p>
                <a href="cart.jsp" class="btn btn-warning">Thêm vào giỏ</a>
            </div>
        </div>
        <%
            } else {
        %>
        <div class="alert alert-danger" role="alert">
            Sản phẩm không tồn tại!
        </div>
        <%
            }
        %>
    </div>

    <footer class="bg-light py-3 text-center">
        <p>&copy; 2024 Phone Store. All rights reserved.</p>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
