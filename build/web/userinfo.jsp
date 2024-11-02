<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thông Tin Tài Khoản - Phone Store</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        <header class="bg-primary text-white py-3">
            <div class="container d-flex justify-content-between align-items-center">
                <a href="productCtl.jsp" class="text-white">
                    <h1>Phone Store</h1>
                </a>
                <div>
                    <a href="cart.jsp" class="btn btn-outline-light">Giỏ hàng</a>
                    <a href="LogoutServlet" class="btn btn-outline-light">Đăng xuất</a>
                </div>
            </div>
        </header>

        <div class="container mt-4">
            <h2>Thông Tin Tài Khoản</h2>
            <c:if test="${not empty sessionScope.user}">
                <c:set var="user" value="${sessionScope.user}" />
                <ul class="list-group mt-3">
                    <li class="list-group-item">
                        <strong>Tên người dùng:</strong> ${user.username}
                    </li>
                    <li class="list-group-item">
                        <strong>Email:</strong> ${user.email}
                    </li>
                    <li class="list-group-item">
                        <strong>Số điện thoại:</strong> ${user.phone}
                    </li>
                    <li class="list-group-item">
                        <strong>Địa chỉ:</strong> ${user.address}
                    </li>
                </ul>
            </c:if>
            <c:if test="${empty sessionScope.user}">
                <p class="text-danger">Bạn chưa đăng nhập. Vui lòng đăng nhập để xem thông tin tài khoản.</p>
            </c:if>
        </div>

        <footer class="bg-light py-3 text-center">
            <p>&copy; 2024 Phone Store. All rights reserved.</p>
        </footer>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>