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
                <title>Delete Product</title>
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
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h1>Delete product ${product.id}</h1>
                                            <hr>
                                            <div class="alert alert-danger mb-3" role="alert">
                                                Are you sure you want to delete this product?
                                            </div>
                                            <form method="post" action="AdminServlet?action=handleDeleteProduct&id=${product.id}">
                                                <div style="display: none;">
                                                    <label class="form-label">Id: </label>
                                                    <input type="text" class="form-control" path="id"
                                                        value="${product.id}" />
                                                </div>
                                                <button type="submit" class="btn btn-danger mt-1">Confirm</button>
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