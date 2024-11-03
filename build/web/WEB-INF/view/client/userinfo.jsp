<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
    // Check login status; redirect to login if not logged in
    if (session.getAttribute("username") == null) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }
%>

<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <title>Thông Tin Tài Khoản - Smartphone Shop</title>
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
                padding: 60px 40px;
                width: calc(100% - 290px);
                transition: margin-left 0.3s ease;
                margin-top: 51px;
                background-color: #f4f5f7;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            /* Adjust content when sidebar is hidden */
            .content.shifted {
                margin-left: 20px;
                width: calc(100% - 40px);
            }

            /* Card styling */
            .card {
                background-color: #ffffff;
                border-radius: 8px;
                padding: 30px;
                margin-bottom: 20px;
                box-shadow: 0 6px 18px rgba(0, 0, 0, 0.06);
            }

            /* List group styling for user info */
.list-group-item {
    display: grid;
    grid-template-columns: 1fr 2fr;
    align-items: center;
    padding: 15px 0;
    border-bottom: 1px solid #e0e0e0;
    font-size: 1.05em;
    color: #333;
}

.list-group-item:last-child {
    border-bottom: none;
}

/* Label and value styles */
.item-label {
    font-weight: bold;
    color: #555;
}

.item-value {
    color: #333;
    padding-left: 10px;
}


            /* Button styling for updates */
            .btn-update {
                background-color: #28a745;
                color: #ffffff;
                padding: 8px 16px;
                font-size: 0.95em;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .btn-update:hover {
                background-color: #218838;
            }


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
            <!-- Display User Information -->
            <div class="card">
                <ul class="list-group">
                    <li class="list-group-item">
                        <div class="item-label"><strong>Tên đăng nhập:</strong></div>
                        <div class="item-value">${user.username}</div>
                    </li>
                    <li class="list-group-item">
                        <div class="item-label"><strong>Tên người dùng:</strong></div>
                        <div class="item-value">${user.fullName}</div>
                    </li>
                    <li class="list-group-item">
                        <div class="item-label"><strong>Email:</strong></div>
                        <div class="item-value">${user.email}</div>
                    </li>
                    <li class="list-group-item">
                        <div class="item-label"><strong>Số điện thoại:</strong></div>
                        <div class="item-value">${user.phoneNumber}</div>
                    </li>
                    <li class="list-group-item">
                        <div class="item-label"><strong>Địa chỉ:</strong></div>
                        <div class="item-value">${user.address}</div>
                    </li>
                </ul>
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
