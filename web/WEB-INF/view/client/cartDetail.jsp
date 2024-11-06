<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("username") == null) {
        response.sendRedirect("AuthServlet?action=login");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Giỏ hàng - Smartphone shop</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
            rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
              rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="${pageContext.request.contextPath}/resources/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/resources/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="${pageContext.request.contextPath}/resources/client/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="${pageContext.request.contextPath}/resources/client/css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css">
        

    </head>

    <body>

        <!-- Spinner Start -->
        <div id="spinner"
             class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
            <div class="spinner-grow text-primary" role="status"></div>
        </div>
        <!-- Spinner End -->

        <jsp:include page="../../layout/header.jsp" />

        <!-- Cart Page Start -->
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div class="mb-3">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Chi Tiết Giỏ Hàng</li>
                        </ol>
                    </nav>
                </div>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Sản phẩm</th>
                                <th scope="col">Tên</th>
                                <th scope="col">Giá cả</th>
                                <th scope="col">Số lượng</th>
                                <th scope="col">Thành tiền</th>
                                <th scope="col">Xử lý</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty cart.getCartDetails()}">
                                <tr>
                                    <td colspan="6">
                                        Không có sản phẩm trong giỏ hàng
                                    </td>
                                </tr>
                            </c:if>
                            <c:forEach var="cartDetail" items="${cart.getCartDetails()}">
                                <tr>
                                    <th scope="row">
                                        <div class="d-flex align-items-center">
                                            <img src="${cartDetail.product.imageUrl}"
                                                 class="img-fluid me-5 rounded-circle"
                                                 style="width: 80px; height: 80px;" alt="">
                                        </div>
                                    </th>
                                    <td>
                                        <p class="mb-0 mt-4">
                                            <a href="${pageContext.request.contextPath}/client?action=showProductInfor&id=${cartDetail.product.id}" target="_blank">
                                                ${cartDetail.product.name}
                                            </a>
                                        </p>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4">
                                            <fmt:formatNumber type="number"
                                                              value="${cartDetail.product.price}" /> đ
                                        </p>
                                    </td>
                                    <td>
                                        <div class="input-group quantity mt-4" style="width: 150px;">
                                            <div class="input-group-btn">
                                                <button
                                                    class="btn btn-sm btn-minus rounded-circle bg-light border" data-context="${pageContext.request.contextPath}" data-product-id="${cartDetail.product.id}">
                                                    <i class="fa fa-minus"></i>
                                                </button>
                                            </div>
                                            <input type="text"
                                                   class="form-control form-control-sm text-center border-0 mx-3" data-context="${pageContext.request.contextPath}"
                                                   data-product-id="${cartDetail.product.id}"
                                                   value="${cartDetail.quantity}"
                                                   readonly />
                                            <div class="input-group-btn">
                                                <button
                                                    class="btn btn-sm btn-plus rounded-circle bg-light border" data-context="${pageContext.request.contextPath}" data-product-id="${cartDetail.product.id}">
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <p class="mb-0 mt-4" data-cart-detail-id="${cartDetail.product.id}">
                                            <fmt:formatNumber type="number"
                                                              value="${cartDetail.product.price * cartDetail.quantity}" /> đ
                                        </p>

                                    </td>
                                    <td id="cart-item-${cartDetail.product.id}">
                                        <input type="hidden" name="id" value="${cartDetail.product.id}" />
                                        <button class="btn btn-md rounded-circle bg-light border mt-4 delete-out-of-cart-btn" data-context="${pageContext.request.contextPath}" data-product-id="${cartDetail.product.id}">
                                            <i class="fa fa-times text-danger"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>

                        </tbody>
                    </table>
                </div>
                <c:if test="${not empty cart.getCartDetails()}">
                    <div class="mt-5 row g-4 justify-content-start">
                        <div class="col-12 col-md-8">
                            <div class="bg-light rounded">
                                <div class="p-4">
                                    <h1 class="display-6 mb-4">Thông Tin <span class="fw-normal">Đơn
                                            Hàng</span>
                                    </h1>
                                    <div class="d-flex justify-content-between mb-4">
                                        <h5 class="mb-0 me-4">Tạm tính:</h5>
                                        <p class="mb-0" data-cart-total-price="${totalPrice}">
                                            <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                        </p>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <h5 class="mb-0 me-4">Phí vận chuyển</h5>
                                        <div class="">
                                            <p class="mb-0">0 đ</p>
                                        </div>
                                    </div>
                                </div>
                                <div
                                    class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                    <h5 class="mb-0 ps-4 me-4">Tổng số tiền</h5>
                                    <p class="mb-0 pe-4" data-cart-total-price="${totalPrice}">
                                        <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                    </p>
                                </div>
                                <form action="${pageContext.request.contextPath}/client?action=showCheckOut" method="post">
                                    <div style="display: none;">
                                        <c:forEach var="cartDetail" items="${cart.cartDetails}"
                                                   varStatus="status">
                                            <div class="mb-3">
                                                <div class="form-group">
                                                    <label>Id:</label>
                                                    <input class="form-control" type="text"
                                                           value="${cartDetail.product.id}"
                                                           name="cartDetails[${status.index}].productId" />
                                                </div>
                                                <div class="form-group">
                                                    <label>Quantity:</label>
                                                    <input class="form-control" type="text"
                                                           value="${cartDetail.quantity}"
                                                           name="cartDetails[${status.index}].quantity" />
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <button
                                        class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4">Xác
                                        nhận thanh toán
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
        <!-- Cart Page End -->


        <jsp:include page="../../layout/footer.jsp" />


        <!-- Back to Top -->
        <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                class="fa fa-arrow-up"></i></a>


        <!-- JavaScript Libraries -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/client/lib/easing/easing.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/client/lib/waypoints/waypoints.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/client/lib/lightbox/js/lightbox.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/client/lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="${pageContext.request.contextPath}/resources/client/js/main.js"></script>
    </body>

</html>