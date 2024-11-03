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
        <title>Update Product</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
                                <div class="col-md-6 col-12 mx-auto">
                                    <h1>Update a product</h1>
                                    <hr>
                                    <form method="post" action="AdminServlet?action=handleUpdateProduct&id=${product.id}" class="row">
                                        <div class="mb-3" style="display: none;">
                                            <label class="form-label">Id: </label>
                                            <input type="text" class="form-control" name="id" />
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Name</label>
                                            <input type="name"
                                                   class="form-control ${not empty errorName ? 'is-invalid' : ''}"
                                                   name="name" value="${product.name}" />
                                            <span class="text-danger">${errorName}</span>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Price</label>
                                            <input type="text"
                                                   class="form-control ${not empty errorPrice ? 'is-invalid' : ''}"
                                                   name="price" value="<fmt:formatNumber value="${product.price}" />" />
                                            <span class="text-danger">${errorPrice}</span>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Detail description:</label>
                                            <input type="text"
                                                   class="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}"
                                                   name="detailDesc" value="${product.description}" />
                                            <span class="text-danger">${errorDetailDesc}</span>
                                        </div>  
                                        <div class=" mb-3">
                                            <label class="form-label">Quantity</label>
                                            <input type="text"
                                                   class="form-control ${not empty errorQuantity ? 'is-invalid' : ''}"
                                                   name="quantity" value="${product.stockQuantity}" />
                                            <span class="text-danger">${errorQuantity}</span>
                                        </div>
                                        <div class="col-12 col-md-6 mb-4">
                                            <label for="Role" class="form-label">Factory:</label>
                                            <select id="Role" class="form-select" name="factory">
                                                <option value="Apple" ${product.brand == 'Apple' ? 'selected' : '' }>
                                                    Apple</option>
                                                <option value="Samsung" ${product.brand == 'Samsung' ? 'selected' : ''
                                                        }>Samsung</option>
                                                <option value="Vivo" ${product.brand == 'Vivo' ? 'selected' : '' }>
                                                    Vivo</option>
                                                <option value="OPPO" ${product.brand == 'OPPO' ? 'selected' : '' }>
                                                    OPPO</option>
                                                <option value="Tecno" ${product.brand == 'Tecno' ? 'selected' : ''
                                                        }>Tecno</option>
                                                <option value="Xiaomi" ${product.brand == 'Xiaomi' ? 'selected' : ''
                                                        }>Xiaomi</option>
                                                <option value="Realme" ${product.brand == 'Realme' ? 'selected' : ''
                                                        }>Realme</option>
                                            </select>

                                        </div>
                                        <div class="col-12 col-md-6 mb-3">
                                            <label for="avatarFile" class="form-label">Avatar:</label>
                                            <input class="form-control ${not empty errorImageUrl ? 'is-invalid' : ''}" type="text" id="avatarFile"
                                                   value="${product.imageUrl}" name="productImageFile" />
                                            <span class="text-danger">${errorImageUrl}</span>
                                        </div>
                                        
                                        <div class="col-12 mb-5">
                                            <button type="submit" class="btn btn-warning">Update</button>
                                        </div>
                                    </form>

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