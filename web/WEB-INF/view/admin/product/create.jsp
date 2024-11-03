<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <meta name="description" content="Group 4 - Smartphone Shop" />
            <meta name="author" content="Group 4" />
            <title>Create Product</title>
            <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
            <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        </head>

        <body class="sb-nav-fixed">
            <jsp:include page="../layout/header.jsp" />
            <div id="layoutSidenav">
                <jsp:include page="../layout/sidebar.jsp" />
                <div id="layoutSidenav_content">
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Manage Products</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">
                                <a href="AdminServlet?action=dashboard">Dashboard</a>
                            </li>
                            <li class="breadcrumb-item active">Products</li>
                        </ol>
                        <div class="mt-5">
                            <div class="d-flex">
                                <div class="col-md-6 col-12 mx-auto">
                                    <h1>Create a Product</h1>
                                    <hr>
                                    <form method="post" action="AdminServlet?action=handleCreateProduct" class="row">

                                        <div class="col-12 col-md-6 mb-3">
                                            <label class="form-label">Name:</label>
                                            <input type="text"
                                                class="form-control ${not empty errorName ? 'is-invalid' : ''}"
                                                name="name" />
                                            ${errorName}
                                        </div>
                                        <div class="col-12 col-md-6 mb-3">
                                            <label class="form-label">Price:</label>
                                            <input type="text"
                                                class="form-control ${not empty errorPrice ? 'is-invalid' : ''}"
                                                name="price" aria-placeholder="0.0" />
                                            ${errorPrice}
                                        </div>

                                        <div class="col-12 col-md-6 mb-3">
                                            <label class="form-label">Quantity:</label>
                                            <input type="text"
                                                class="form-control ${not empty errorQuantity ? 'is-invalid' : ''}"
                                                name="quantity" />
                                            ${errorQuantity}
                                        </div>
                                        <div class="col-12 mb-3">
                                            <label class="form-label">Detail description:</label>
                                            <textarea type="text"
                                                class="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}"
                                                name="detailDesc"></textarea>
                                            ${errorDetailDesc}
                                        </div>
                                        <div class="col-12 col-md-6 mb-4">
                                            <label for="Role" class="form-label">Factory:</label>
                                            <select id="Role" class="form-select" name="factory">
                                                <option value="APPLE">Apple</option>
                                                <option value="SAMSUNG">Samsung</option>
                                                <option value="OPPO">OPPO</option>
                                                <option value="HUAWEI">Huawei</option>
                                                <option value="XIAOMI">Xiaomi</option>
                                            </select>
                                        </div>
                                        <div class="col-12 col-md-6 mb-3">
                                            <label for="avatarFile" class="form-label">URL Image:</label>
                                            <input class="form-control ${not empty errorImageUrl ? 'is-invalid' : ''}"
                                                type="text" id="avatarFile" name="productImageURL" />
                                            ${errorImageUrl}
                                        </div>

                                        <div class="col-12 mb-3">
                                            <img style="max-height: 250px; display: none;" alt="avatar preview"
                                                id="avatarPreview" />
                                        </div>
                                        <div class="col-12 mb-5">
                                            <button type="submit" class="btn btn-primary">Create</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../layout/footer.jsp" />
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                crossorigin="anonymous"></script>
            <script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
            <script src="${pageContext.request.contextPath}/resources/js/datatables-simple-demo.js"></script>
        </body>

        </html>