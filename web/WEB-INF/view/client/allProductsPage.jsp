<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri = "/WEB-INF/tlds/PaginationTag.tld" prefix="pg" %>



<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title> Sản Phẩm - Laptopshop</title>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css">



        <!-- Customized Bootstrap Stylesheet -->
        <link href="${pageContext.request.contextPath}/resources/client/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="${pageContext.request.contextPath}/resources/client/css/style.css" rel="stylesheet">
    </head>

    <body>

        <!-- Spinner Start -->
        <div id="spinner"
             class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
            <div class="spinner-grow text-primary" role="status"></div>
        </div>
        <!-- Spinner End -->

        <jsp:include page="../../layout/header.jsp" />

        <!-- Single Product Start -->
        <div class="container-fluid py-5 mt-5">
            <div class="container py-5">
                <div class="row g-4 mb-5">
                    <div>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Danh Sách Sản Phẩm
                                </li>
                            </ol>
                        </nav>
                    </div>

                    <div class="row g-4 fruite">
                        <div class="col-12 col-md-4">
                            <div class="row g-4">
                                <c:set var="selectedBrands" value="${selectedBrands}" />
                                <c:set var="selectedPrices" value="${selectedPrices}" />
                                <c:set var="selectedSort" value="${selectedSort}" />
                                <div class="col-12" id="factoryFilter">
                                    <div class="mb-2"><b>Hãng sản xuất</b></div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox"
                                               value="Apple" <c:if test="${selectedBrands.contains('Apple')}">checked</c:if>>
                                               <label class="form-check-label">Apple</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox"
                                                   value="OPPO" <c:if test="${selectedBrands.contains('OPPO')}">checked</c:if>>
                                            <label class="form-check-label">OPPO</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox"
                                                   value="Realme" <c:if test="${selectedBrands.contains('Realme')}">checked</c:if>>
                                            <label class="form-check-label">Realme</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox"
                                                   value="Samsung" <c:if test="${selectedBrands.contains('Samsung')}">checked</c:if>>
                                            <label class="form-check-label">Samsung</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox"
                                                   value="Tecno" <c:if test="${selectedBrands.contains('Tecno')}">checked</c:if>>
                                            <label class="form-check-label">Tecno</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox"
                                                   value="Vivo" <c:if test="${selectedBrands.contains('Vivo')}">checked</c:if>>
                                            <label class="form-check-label">Vivo</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox"
                                                   value="Xiaomi" <c:if test="${selectedBrands.contains('Xiaomi')}">checked</c:if>>
                                            <label class="form-check-label">Xiaomi</label>
                                        </div>
                                    </div>
                                    <div class="col-12" id="priceFilter">
                                        <div class="mb-2"><b>Mức giá</b></div>

                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox" id="price-2"
                                                   value="duoi-10-trieu" <c:if test="${selectedPrices.contains('duoi-10-trieu')}">checked</c:if>>
                                            <label class="form-check-label" for="price-2">Dưới 10 triệu</label>
                                        </div>

                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox" id="price-3"
                                                   value="10-15-trieu" <c:if test="${selectedPrices.contains('10-15-trieu')}">checked</c:if>>
                                            <label class="form-check-label" for="price-3">Từ 10 - 15
                                                triệu</label>
                                        </div>

                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox" id="price-4"
                                                   value="15-20-trieu" <c:if test="${selectedPrices.contains('15-20-trieu')}">checked</c:if>>
                                            <label class="form-check-label" for="price-4">Từ 15 - 20
                                                triệu</label>
                                        </div>

                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="checkbox" id="price-5"
                                                   value="tren-20-trieu" <c:if test="${selectedPrices.contains('tren-20-trieu')}">checked</c:if>>
                                            <label class="form-check-label" for="price-5">Trên 20 triệu</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="mb-2"><b>Sắp xếp</b></div>

                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" id="sort-1"
                                                   value="gia-tang-dan" name="radio-sort" <c:if test="${selectedSort.contains('gia-tang-dan')}">checked</c:if>>
                                            <label class="form-check-label" for="sort-1">Giá tăng dần</label>
                                        </div>

                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" id="sort-2"
                                                   value="gia-giam-dan" name="radio-sort" <c:if test="${selectedSort.contains('gia-giam-dan')}">checked</c:if>>
                                            <label class="form-check-label" for="sort-2">Giá giảm dần</label>
                                        </div>

                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" id="sort-3"
                                                   value="gia-nothing" name="radio-sort" <c:if test="${selectedSort.contains('gia-nothing')}">checked</c:if>>
                                            <label class="form-check-label" for="sort-3">Không sắp xếp</label>
                                        </div>

                                    </div>
                                    <div class="col-12">
                                        <button
                                            class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4"
                                            id="btnFilter" onclick="filterProduct()">
                                            Lọc Sản Phẩm
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-md-8 text-center">
                                <div class="row g-4">
                                <c:if test="${totalPages ==  0}">
                                    <div>Không tìm thấy sản phẩm</div>
                                </c:if>
                                <c:forEach var="product" items="${products}">
                                    <div class="col-md-6 col-lg-4">
                                        <div class="rounded position-relative fruite-item">
                                            <div class="fruite-img">
                                                <img src="${product.imageUrl}"
                                                     class="img-fluid w-100 rounded-top" alt="">
                                            </div>
                                            <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                 style="top: 10px; left: 10px;">Smartphone
                                            </div>
                                            <div
                                                class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                <h4 style="font-size: 15px;">
                                                    <a href="${pageContext.request.contextPath}/client?action=showProductInfor&id=${product.id}">
                                                        ${product.name}
                                                    </a>

                                                </h4>
                                                <p style="font-size: 13px;">
                                                    ${product.description}</p>
                                                <div
                                                    class="d-flex  flex-lg-wrap justify-content-center flex-column">
                                                    <p style="font-size: 15px; text-align: center; width: 100%;"
                                                       class="text-dark  fw-bold mb-3">
                                                        <fmt:formatNumber type="number"
                                                                          value="${product.price}" />
                                                        đ
                                                    </p>
                                                    <button
                                                        class="mx-auto btn border border-secondary rounded-pill px-3 text-primary add-to-cart-btn"
                                                        data-id="${product.id}"
                                                        data-context="${pageContext.request.contextPath}">
                                                        <i
                                                            class="fa fa-shopping-bag me-2 text-primary"></i>
                                                        Add to cart
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>                            </div>
                            <div class="mt-4">
                                <pg:Pagination totalPages="${totalPages}" currentPage="${currentPage}" url="${url}" />
                            </div>
                        </div>                       
                    </div>
                </div>
            </div>
        </div>
        <!-- Single Product End -->

        <jsp:include page="../../layout/footer.jsp" />


        <!-- Back to Top -->
        <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                class="fa fa-arrow-up"></i></a>


        <!-- JavaScript Libraries -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/client/lib/easing/easing.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/client/lib/waypoints/waypoints.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/client/lib/lightbox/js/lightbox.min.js"></script>
        <script src="${pageContext.request.contextPath}/resources/client/lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="${pageContext.request.contextPath}/resources/client/js/main.js"></script>


    </body>

</html>