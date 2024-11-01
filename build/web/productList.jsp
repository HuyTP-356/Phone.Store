<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product List</title>
    <link rel="stylesheet" type="text/css" href="styles.css"> <!-- Link to your CSS file -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> <!-- Bootstrap for styling -->
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4">Product List</h1>

        <!-- Product Listing -->
        <div class="row">
            <c:if test="${not empty products}">
                <c:forEach var="product" items="${products}">
                    <div class="col-md-3 mb-4">
                        <div class="card h-100 text-center">
                            <c:choose>
                                <c:when test="${product.imageUrl != null && !product.imageUrl.isEmpty()}">
                                    <img src="${product.imageUrl}" class="card-img-top product-image" alt="${product.name}">
                                </c:when>
                                <c:otherwise>
                                    <img src="default-image.jpg" class="card-img-top product-image" alt="Default Image"> <!-- Fallback image -->
                                </c:otherwise>
                            </c:choose>
                            <div class="card-body">
                                <h5 class="card-title">${product.name}</h5>
                                <p class="card-text"><strong>${product.price} VND</strong></p>
                                <a href="order.jsp?productId=${product.id}" class="btn btn-success">Order</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty products}">
                <p>No products available.</p>
            </c:if>
        </div>
    </div>
    
    <!-- Bootstrap JS for responsive design -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
