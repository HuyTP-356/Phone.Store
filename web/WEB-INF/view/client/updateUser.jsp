<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // Kiểm tra trạng thái đăng nhập; nếu chưa đăng nhập, chuyển hướng tới trang đăng nhập
    if (session.getAttribute("username") == null) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }

    // Lấy thông tin người dùng từ session
    User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <title>Cập Nhật Thông Tin - Smartphone Shop</title>
        <style>
            /* Original CSS styles */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                display: flex;
                min-height: 100vh;
                background-color: #f8f9fa;
                color: #333;
            }

            /* Header styling */
            header {
                background-color: #222;
                color: #fff;
                width: 100%;
                padding: 10px 15px;
                text-align: left;
                font-size: 1.2em;
                position: fixed;
                top: 0;
                left: 0;
                z-index: 1000;
                display: flex;
                justify-content: space-between;
                align-items: center;
                height: 55px; /* Tăng thêm 1px */
            }

            .header-left,
            .header-right {
                display: flex;
                align-items: center;
            }

            .header-left a {
                color: #fff;
                text-decoration: none;
                font-size: 1em;
            }

            .header-right {
                font-size: 1em;
            }

            /* Sidebar styling */
            .sidebar ul li a i {
                margin-right: 8px; /* Space between icon and text */
            }

            .sidebar {
                width: 225px; /* Giảm 2px */
                background-color: #222;
                color: #fff;
                padding: 20px;
                position: fixed;
                top: 51px; /* Adjusted to match header height */
                left: 0;
                height: calc(100% - 51px);
                transition: transform 0.3s ease;
                z-index: 999;
            }

            .sidebar.collapsed {
                transform: translateX(-248px);
            }

            .sidebar h3 {
                color: #007bff;
                margin-bottom: 15px;
            }

            .sidebar ul {
                list-style-type: none;
            }

            .sidebar ul li {
                padding: 10px;
                font-size: 1.1em;
            }

            .sidebar ul li a {
                color: #fff;
                text-decoration: none;
                display: block;
            }

            .sidebar ul li a:hover {
                background-color: #007bff;
                padding-left: 10px;
                border-radius: 4px;
            }

            /* Main content styling */
            .content {
                margin-left: 270px;
                padding: 80px 20px 20px 20px;
                width: calc(100% - 290px);
                transition: margin-left 0.3s ease;
                margin-top: 51px;
            }

            /* Adjust content when sidebar is open */
            .content.shifted {
                margin-left: 270px;
            }

            .card {
                background-color: #fff;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .card-header {
                font-size: 1.5em;
                font-weight: bold;
                color: #007bff;
                padding-bottom: 10px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                display: block;
                font-weight: bold;
            }

            .form-group input {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 1em;
            }

            .btn-update {
                background-color: #28a745;
                color: #fff;
                padding: 10px 20px;
                font-size: 1em;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .btn-update:hover {
                background-color: #218838;
            }

            /* Toggle button styling */
            .menu-toggle {
                background-color: transparent;
                color: #fff;
                border: none;
                font-size: 1.5em;
                cursor: pointer;
                margin-right: 10px;
            }
        </style>
    </head>

    <body>

        <!-- Header -->
        <header>
            <div class="header-left">
                <button class="menu-toggle" onclick="toggleSidebar()">☰</button>
                <a href="homepage">Smartphone Shop</a>
            </div>
            <div class="header-right">
                <span>Welcome, ${user.fullName}</span>
            </div>
        </header>

        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <ul>
                <li><a href="user?action=showUserInfo"><i class="fas fa-user"></i> Hồ sơ</a></li>
                <li><a href="user?action=editUser"><i class="fas fa-edit"></i> Cập nhật hồ sơ</a></li>
                <li><a href="orderHistory.jsp"><i class="fas fa-history"></i> Lịch sử mua hàng</a></li>
                <li><a href="AuthServlet?action=logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="content" id="content">
            <div class="card">
                <form action="user?action=updateUser" method="post">
                    <div class="form-group">
                        <label>Tên đăng nhập:</label>
                        <input type="text" name="username" value="${user.username}" required />
                    </div>
                    <div class="form-group">
                        <label>Tên người dùng:</label>
                        <input type="text" name="fullName" value="${user.fullName}" required />
                    </div>
                    <div class="form-group">
                        <label>Email:</label>
                        <input type="email" name="email" value="${user.email}" required />
                    </div>
                    <div class="form-group">
                        <label>Số điện thoại:</label>
                        <input type="text" name="phoneNumber" value="${user.phoneNumber}" required />
                    </div>
                    <div class="form-group">
                        <label>Địa chỉ:</label>
                        <input type="text" name="address" value="${user.address}" required />
                    </div>
                    <button type="submit" class="btn-update">Lưu Cập Nhật</button>
                </form>
            </div>
        </div>

        <script>
            function toggleSidebar() {
                document.getElementById("sidebar").classList.toggle("collapsed");
                document.getElementById("content").classList.toggle("shifted");
            }
        </script>
    </body>

</html>
