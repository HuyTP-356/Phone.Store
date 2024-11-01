package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpSession;
import model.Java_JDBC;

import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra xem người dùng đã đăng nhập chưa
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("username") != null) {
            // Nếu đã đăng nhập, điều hướng đến trang sách
            response.sendRedirect("productCtl.jps");
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
            if (Java_JDBC.validateUser(username, password)) {
                // Đăng nhập thành công, tạo session cho người dùng
                HttpSession session = request.getSession();
                session.setAttribute("username", username);

                // Tạo cookie nếu "Remember me" được chọn
                if (rememberMe) {
                    Cookie cookie = new Cookie("username", username);
                    cookie.setMaxAge(24 * 60 * 60); // 24 giờ
                    response.addCookie(cookie);
                }

                // Điều hướng người dùng đến trang danh sách sách
                response.sendRedirect(response.encodeURL("product"));
            } else {
                // Xử lý lỗi đăng nhập
                request.setAttribute("errorMessage", "Invalid username or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
        }
    }
}
