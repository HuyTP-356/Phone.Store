package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpSession;
import model.Java_JDBC;
import model.User; // Import User class

import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user != null) {
            // Nếu đã đăng nhập, điều hướng đến trang sản phẩm
            response.sendRedirect("productCtl.jsp");
        } else {
            // Nếu chưa đăng nhập, hiển thị trang login
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean rememberMe = "on".equals(request.getParameter("rememberMe"));

        try {
            User user = Java_JDBC.validateUser(username, password);

            if (user != null) {
                // Đăng nhập thành công, lưu đối tượng User vào session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // Tạo cookie nếu "Remember me" được chọn
                if (rememberMe) {
                    Cookie cookie = new Cookie("username", username);
                    cookie.setMaxAge(24 * 60 * 60); // 24 giờ
                    response.addCookie(cookie);
                }

                // Điều hướng người dùng đến trang danh sách sản phẩm
                response.sendRedirect(response.encodeURL("productCtl.jsp"));
            } else {
                // Xử lý lỗi đăng nhập
                request.setAttribute("errorMessage", "Invalid username or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException("Error during login", e);
        }
    }
}
