<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("username") == null) {
        response.sendRedirect("LoginServlet");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="Group 4 - Smartphone Shop" />
        <meta name="author" content="Group 4" />
        <title>Dashboard - Group 4</title>
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
                                        <h1>Table Product</h1>
                                        <a href="AdminServlet?action=viewAllProducts" class="btn btn-info">View All Products</a>
                                        <a href="AdminServlet?action=createProduct" class="btn btn-primary">Create a Product</a>
                                    </div>
                                    <hr />
                                    <table class="table table-hover table-bordered">
                                        <thead>
                                            <tr>
                                                <th scope="col">ID</th>
                                                <th scope="col">Name</th>
                                                <th scope="col">Price</th>
                                                <th scope="col">Factory</th>
                                                <th scope="col">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="product" items="${products}">
                                                <tr>
                                                    <th scope="row">${product.id}</th>
                                                    <td>${product.name}</td>
                                                    <td><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VND" /></td>

                                                    <td>${product.brand}</td>
                                                    <td>
                                                        <a href="AdminServlet?action=viewDetailProduct&id=${product.id}" class="btn btn-success">View</a>
                                                        <a href="AdminServlet?action=updateProduct&id=${product.id}" class="btn btn-warning mx-2">Update</a>
                                                        <a href="AdminServlet?action=deleteProduct&id=${product.id}" class="btn btn-danger">Delete</a>
                                                    </td>

                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
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