<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="Group 4 - Smartphone Shop" />
        <meta name="author" content="Group 4" />
        <title>View Product</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>

    <body class="sb-nav-fixed">
        <jsp:include page="../layout/header.jsp" />
        <div id="layoutSidenav">
            <jsp:include page="../layout/sidebar.jsp" />
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Manage Products</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">
                                <a href="AdminServlet?action=dashboard">Dashboard</a>
                            </li>
                            <li class="breadcrumb-item active">Products</li>
                        </ol>
                        <div class="mt-5">
                            <div class="row">
                                <div class="col-12 mx-auto">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h1>Product detail with id = ${product.id}</h1>
                                    </div>
                                    <hr />

                                    <div class="card" style="width: 60%">
                                        <div class="card-img-top">
                                            <img src="${product.imageUrl}" alt="">
                                        </div>
                                        <div class="card-header">
                                            Product information
                                        </div>
                                        <ul class="list-group list-group-flush">
                                            <li class="list-group-item">ID: ${product.id}</li>
                                            <li class="list-group-item">Name: ${product.name}</li>
                                            <li class="list-group-item">Description: ${product.description}</li>
                                            <li class="list-group-item">Price: <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VND"/></li>
                                            <li class="list-group-item">Description: ${product.stockQuantity}</li>
                                        </ul>
                                    </div>
                                    <a href="AdminServlet?action=viewAllProducts" class="btn btn-success mt-3">Back</a>
                                </div>

                            </div>

                        </div>
                    </div>
                </main>
                <jsp:include page="../layout/footer.jsp" />
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
        <script src="${pageContext.request.contextPath}/resources/js/datatables-simple-demo.js"></script>
    </body>

</html>