<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="model.User" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Đăng nhập - Smart Phone Shop</title>
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
                <style>
                    body {
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        min-height: 100vh;
                        background: linear-gradient(135deg, #ece9e6, #ffffff);
                        font-family: Arial, sans-serif;
                    }

                    .login-container {
                        width: 100%;
                        max-width: 400px;
                        padding: 40px;
                        background-color: #ffffff;
                        border-radius: 8px;
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                    }

                    .login-header {
                        font-size: 24px;
                        font-weight: 600;
                        text-align: center;
                        color: #343a40;
                        margin-bottom: 24px;
                    }

                    .form-group label {
                        font-size: 14px;
                        font-weight: 500;
                        color: #495057;
                    }

                    .form-control {
                        border-radius: 4px;
                        height: 45px;
                        padding: 10px;
                    }

                    .btn-primary {
                        background-color: #007bff;
                        border-color: #007bff;
                        font-size: 16px;
                        padding: 12px;
                        border-radius: 4px;
                    }

                    .btn-secondary {
                        background-color: #6c757d;
                        border-color: #6c757d;
                        font-size: 16px;
                        padding: 12px;
                        border-radius: 4px;
                    }

                    .text-center a {
                        font-size: 14px;
                        color: #007bff;
                    }

                    .text-center a:hover {
                        text-decoration: underline;
                    }
                </style>
            </head>

            <body>
                <div class="login-container">
                    <h3 class="login-header">Đăng nhập</h3>
                    <form action="LoginServlet" method="post">
                        <div class="form-group">
                            <label for="username">Tên người dùng</label>
                            <input type="text" class="form-control" id="username" name="username"
                                placeholder="Nhập tên người dùng" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Mật khẩu</label>
                            <input type="password" class="form-control" id="password" name="password"
                                placeholder="Nhập mật khẩu" required>
                        </div>
                        <div class="form-group form-check">
                            <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                            <label class="form-check-label" for="rememberMe">Nhớ mật khẩu</label>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">Đăng nhập</button>
                    </form>
                    <c:if test="${not empty errorMessage}">
                        <div class="text-danger mt-3">${errorMessage}</div>
                    </c:if>
                    <div class="text-center mt-4">
                        <a href="register.jsp">Chưa có tài khoản? Đăng ký ngay!</a>
                    </div>
                    <div class="text-center mt-3">
                        <a href="homepage.jsp" class="btn btn-secondary btn-block text-white">Quay lại Trang Chủ</a>
                    </div>
                </div>

                <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>