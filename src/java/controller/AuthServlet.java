package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Java_JDBC;
import model.User;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "AuthServlet", urlPatterns = {"/AuthServlet"})
public class AuthServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            handleLogout(request, response);
        } else {
            checkLoginStatus(request, response);
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
        boolean rememberMe = "on".equals(request.getParameter("rememberMe"));

        try {
            if (Java_JDBC.validateUser(username, password)) {
                User user = Java_JDBC.getUserByUserName(username);
                HttpSession session = request.getSession();
                session.setAttribute("username", username);

                if (rememberMe) {
                    Cookie cookie = new Cookie("username", username);
                    cookie.setMaxAge(24 * 60 * 60); // 24 giờ
                    response.addCookie(cookie);
                }

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
