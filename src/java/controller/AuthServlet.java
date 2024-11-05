package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Java_JDBC;
import model.User;
import java.io.IOException;
import java.util.List;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.Product;

@WebServlet(name = "AuthServlet", urlPatterns = { "/AuthServlet" })
public class AuthServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "login":
                    checkLoginStatus(request, response);
                    break;
                case "logout":
                    handleLogout(request, response);
                    break;
                default:
                    break;
            }
        }
    }

    private void checkLoginStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("username") != null) {
            try {
                User user = Java_JDBC.getUserByUserName((String) session.getAttribute("username"));
                if (user != null) {
                    if ("User".equals(user.getRole().getName())) {
                        ResourcesHandler.forwardToClientPage(request, response, "/homepage");
                    } else {
                        ResourcesHandler.forwardToAdminPage(request, response, "/dashboard/show");
                    }
                    return;
                }
            } catch (Exception ex) {
                Logger.getLogger(AuthServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        ResourcesHandler.forwardToClientPage(request, response, "/login");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();

        try {
            if (Java_JDBC.validateUser(username, password)) {
                User user = Java_JDBC.getUserByUserName(username);
                session.setAttribute("role", user.getRole().getName());
                session.setAttribute("role", user.getRole().getName());
                session.setAttribute("username", username);

                // Lấy giỏ hàng và gán vào User
                Cart cart = Java_JDBC.getCartForUser(user);

                // Đặt User đã cập nhật vào session
                session.setAttribute("user", user);
                session.setAttribute("cart", cart);
                List<Product> products = Java_JDBC.getFirst16Products();
                request.setAttribute("products", products);
                if ("User".equals(user.getRole().getName())) {
                    ResourcesHandler.forwardToClientPage(request, response, "/homepage");
                } else {
                    ResourcesHandler.forwardToAdminPage(request, response, "/dashboard/show");
                }
            } else {
                request.setAttribute("errorMessage", "Tài khoản hoặc mật khẩu không hợp lệ.");
                ResourcesHandler.forwardToClientPage(request, response, "/login");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("username".equals(cookie.getName())) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        }
        ResourcesHandler.forwardToClientPage(request, response, "/login");
    }
}
