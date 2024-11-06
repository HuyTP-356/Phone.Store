<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


        <!-- Navbar start -->
        <div class="container-fluid fixed-top">
            <!-- <div class="container topbar bg-primary d-none d-lg-block">
<div class="d-flex justify-content-between">
    <div class="top-info ps-2">
        <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#"
                class="text-white">123 Street, New York</a></small>
        <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#"
                class="text-white">Email@Example.com</a></small>
    </div>
    <div class="top-link pe-2">
        <a href="#" class="text-white"><small class="text-white mx-2">Privacy Policy</small>/</a>
        <a href="#" class="text-white"><small class="text-white mx-2">Terms of Use</small>/</a>
        <a href="#" class="text-white"><small class="text-white ms-2">Sales and Refunds</small></a>
    </div>
</div>
</div> -->
            <div class="container px-0">
                <nav class="navbar navbar-light bg-white navbar-expand-xl">
                    <a href="${pageContext.request.contextPath}" class="navbar-brand">
                        <h1 class="text-primary display-6">Smartphone Shop</h1>
                    </a>
                    <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars text-primary"></span>
                    </button>
                    <div class="collapse navbar-collapse bg-white justify-content-between mx-5" id="navbarCollapse">
                        <div class="navbar-nav">
                            <a href="${pageContext.request.contextPath}" class="nav-item nav-link active">Trang chủ</a>
                            <a href="${pageContext.request.contextPath}/client?action=allProductsPage"
                                class="nav-item nav-link">Sản phẩm</a>
                        </div>
                        <div class="d-flex m-3 me-0">
                            <c:if test="${not empty sessionScope.username}">
                                <a href="${pageContext.request.contextPath}/client?action=showCart"
                                    class="position-relative me-4 my-auto">
                                    <i class="fa fa-shopping-bag fa-2x"></i>
                                    <span id="cart-count"
                                        class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                        style="top: -5px; left: 15px; height: 20px; min-width: 20px;">${sessionScope.cart.getCartDetails()
                                        != null ? sessionScope.cart.getCartDetails().size() : 0}</span>
                                </a>
                                <div class="dropdown my-auto">
                                    <a href="#" class="dropdown" role="button" id="dropdownMenuLink"
                                        data-bs-toggle="dropdown" aria-expanded="false" data-bs-toggle="dropdown"
                                        aria-expanded="false">
                                        <i class="fas fa-user fa-2x"></i>
                                    </a>

                                    <ul class="dropdown-menu dropdown-menu-end p-4" aria-labelledby="dropdownMenuLink">
                                        <li class="d-flex align-items-center flex-column" style="min-width: 300px;">
                                            <!-- <img style="width: 150px; height: 150px; border-radius: 50%; overflow: hidden;"
                                        src="/images/avatar/${sessionScope.avatar}" /> -->
                                            <div class="text-center my-3">
                                                <c:out value="${sessionScope.username}" />
                                            </div>
                                        </li>

                                        <li><a class="dropdown-item" href="#">Quản lý tài khoản</a></li>

                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/client?action=showOrderHistory">Lịch sử mua hàng</a></li>
                                        <c:if test="${sessionScope.role == 'Admin'}">
                                            <li><a class="dropdown-item" href="AuthServlet?action=login">Quản lý trang
                                                    web</a></li>
                                        </c:if>
                                        <li>
                                            <hr class="dropdown-divider">
                                        </li>
                                        <li>
                                            <a href="AuthServlet?action=logout" class="dropdown-item">Đăng xuất</a>
                                        </li>
                                    </ul>
                                </div>
                            </c:if>
                            <c:if test="${empty sessionScope.username}">
                                <a href="AuthServlet?action=login" class="position-relative me-4 my-auto">
                                    Đăng nhập
                                </a>
                            </c:if>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <!-- Navbar End -->