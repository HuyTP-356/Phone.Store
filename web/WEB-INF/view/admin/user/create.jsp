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
            <title>Create User</title>
            <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
            <link href="/css/styles.css" rel="stylesheet" />
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        </head>

        <body class="sb-nav-fixed">
            <jsp:include page="../layout/header.jsp" />
            <div id="layoutSidenav">
                <jsp:include page="../layout/sidebar.jsp" />
                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid px-4">
                            <h1 class="mt-4">Manage Users</h1>
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item">
                                    <a href="/admin">Dashboard</a>
                                </li>
                                <li class="breadcrumb-item active">Users</li>
                            </ol>
                            <div class="mt-5">
                                <div class="d-flex">
                                    <div class="col-md-6 col-12 mx-auto">
                                        <h1>Create a user</h1>
                                        <hr>
                                        <form method="post" action="/admin/user/create" modelAttribute="newUser"
                                            class="row" enctype="multipart/form-data">

                                            <div class="col-12 col-md-6 mb-3">
                                                <label class="form-label">Email:</label>
                                                <input type="email"
                                                    class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                                    path="email" />
                                                ${errorEmail}
                                            </div>
                                            <div class="col-12 col-md-6 mb-3">
                                                <label class="form-label">Password:</label>
                                                <input type="password"
                                                    class="form-control ${not empty errorPassword ? 'is-invalid' : ''}"
                                                    path="password" />
                                                ${errorPassword}
                                            </div>
                                            <div class="col-12 col-md-6 mb-3">
                                                <label class="form-label">Phone:</label>
                                                <input type="text" class="form-control" path="phone" />
                                            </div>
                                            <div class="col-12 col-md-6 mb-3">
                                                <label class="form-label">Full Name:</label>
                                                <input type="text"
                                                    class="form-control ${not empty errorFullName ? 'is-invalid' : ''}"
                                                    path="fullName" />
                                                ${errorFullName}
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label">Address:</label>
                                                <input type="text" class="form-control" path="address" />
                                            </div>
                                            <div class="col-12 col-md-6 mb-4">
                                                <label for="Role" class="form-label">Role:</label>
                                                <select id="Role" class="form-select" path="role.name">
                                                    <option value="ADMIN">ADMIN</option>
                                                    <option value="USER">USER</option>
                                                </select>
                                            </div>
                                            <div class="col-12 mb-5">
                                                <button type="submit" class="btn btn-primary">Create</button>
                                            </div>
                                    </div>
                                </div>

                                <!-- <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">Check me out</label>
                            </div> -->

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
            <script src="/js/scripts.js"></script>
            <script src="/js/datatables-simple-demo.js"></script>
        </body>

        </html>