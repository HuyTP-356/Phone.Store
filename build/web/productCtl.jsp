<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cửa Hàng Điện Thoại</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            .logo {
                width: 100px;
            }
            .search-container {
                display: flex;
                justify-content: center;
                flex-grow: 1;
            }
            .product-image {
                height: 200px;
                object-fit: cover;
            }
            .nav-item {
                margin-left: 50px;
            }
            .cart-btn {
                margin-right: 20px;
            }
            .banner-container {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 70%; /* Hoặc thay đổi thành kích thước mong muốn */
                height: auto; /* Chiều cao tự động để banner chỉ hiển thị kích thước cần thiết */
                margin: 20px auto; /* Tự động căn giữa theo chiều ngang */
            }

            .banner-image {
                max-width: 100%;
                height: auto;
                display: block;
            }

        </style>
    </head>
    <body>
        <!-- Header -->
        <header class="bg-primary text-white py-3">
            <div class="container d-flex justify-content-between align-items-center">
                <!-- Logo -->
                <a href="productCtl.jsp" class="text-white">
                    <img src="https://png.pngtree.com/png-clipart/20200727/original/pngtree-smartphone-shop-sale-logo-design-png-image_5069958.jpg" alt="HappyShop" class="logo">
                </a>

                <!-- Navbar -->
                <nav class="navbar navbar-expand-lg navbar-dark">
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    DANH MỤC SẢN PHẨM
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="productCtl.jsp">TRANG CHỦ</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="support.jsp">HỖ TRỢ</a>
                            </li>
                        </ul>
                    </div>
                </nav>

                <!-- Account and Cart -->
                <div>
                    <a href="cart.jsp" class="btn btn-outline-light cart-btn">
                        <i class="fas fa-shopping-cart"></i> Giỏ hàng
                    </a>
                    <% if (session.getAttribute("user") != null) { %>
                    <a href="userinfo.jsp" class="btn btn-outline-light">
                        <i class="fas fa-user"></i> Tài Khoản
                    </a>
                    <a href="LogoutServlet" class="btn btn-outline-light">
                        <i class="fas fa-sign-out-alt"></i> Đăng xuất
                    </a>
                    <% } else { %>
                    <a href="login.jsp" class="btn btn-outline-light">
                        <i class="fas fa-user"></i> Tài Khoản
                    </a>
                    <% } %>
                </div>
            </div>
        </header>

        <!-- Banner Section -->
        <div class="banner-container">
            <img src="https://www.xtsmart.vn/vnt_upload/news/11_2020/xtm-tt-sale-samsung-19-11.jpg" alt="Banner" class="banner-image">
        </div>

        <!-- Product Listing -->
        <div class="container mt-4">
            <div class="row">
                <c:forEach var="product" items="${products}">
                    <div class="col-md-3 mb-4">
                        <div class="card">
                            <img src="${product.imageUrl}" class="card-img-top product-image" alt="${product.name}">
                            <div class="card-body">
                                <h5 class="card-title">${product.name}</h5>
                                <p class="card-text">${product.price} VND</p>
                                <a href="product?id=${product.id}" class="btn btn-primary">Xem chi tiết</a>
                                <a href="cart.jsp" class="btn btn-warning">Thêm vào giỏ</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Footer -->
        <footer class="bg-light py-3 text-center">
            <p>&copy; 2024 Phone Store. All rights reserved.</p>
        </footer>

        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
