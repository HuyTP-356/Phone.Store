package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Java_JDBC;
import static model.Java_JDBC.getUserByUserName;

@WebServlet("/user")
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String action = request.getParameter("action");

        if ("addUser".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/view/client/register.jsp").forward(request, response);
            return;
        }

        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("AuthServlet?action=login");
            return;
        }

        String username = (String) session.getAttribute("username");

        if ("showUserInfo".equals(action)) {
            try {
                User user = getUserByUserName(username);
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/view/client/userinfo.jsp").forward(request, response);
            } catch (Exception ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, "Error retrieving user info", ex);
                response.sendRedirect("error.jsp");
            }
        } else if ("editUser".equals(action)) {
            try {
                User user = getUserByUserName(username);
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/view/client/updateUser.jsp").forward(request, response);
            } catch (Exception ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, "Error editing user", ex);
                response.sendRedirect("error.jsp");
            }
        } else {
            request.getRequestDispatcher("/header.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Đảm bảo mã hóa UTF-8 cho các ký tự tiếng Việt
        HttpSession session = request.getSession(false);
        String action = request.getParameter("action");

        if ("addUser".equals(action)) {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("passwordHash"); // Assuming it's plain text
            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");

            System.out.println("Registering user with username: " + username);

            // Tạo một đối tượng User từ các thông tin nhận được từ form
            User newUser = new User(username, email, password, fullName, phoneNumber, address);
            newUser.setUsername(username);
            newUser.setEmail(email);
            newUser.setPasswordHash(password); // Lưu ý: Xử lý mật khẩu trước khi lưu vào DB nếu cần thiết
            newUser.setFullName(fullName);
            newUser.setPhoneNumber(phoneNumber);
            newUser.setAddress(address);

            try {
                // Chèn người dùng mới vào cơ sở dữ liệu
                Java_JDBC.insertUser(newUser);
                response.sendRedirect("AuthServlet?action=login"); // Chuyển hướng về trang đăng nhập sau khi đăng ký thành công
            } catch (Exception ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, "Error in user registration", ex);
                request.setAttribute("errorMessage", "An error occurred during registration. Please try again.");
                request.getRequestDispatcher("/WEB-INF/view/client/register.jsp").forward(request, response);
            }
        } else if ("updateUser".equals(action)) {
            if (session == null || session.getAttribute("username") == null) {
                response.sendRedirect("AuthServlet?action=login");
                return;
            }

            String username = (String) session.getAttribute("username");
            String email = request.getParameter("email");
            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneNumber");
            String passwordHash = request.getParameter("passwordHash");
            String address = request.getParameter("address");

            try {
                boolean isUpdated = Java_JDBC.updateUser(username, email, fullName, phoneNumber, passwordHash, address);
                if (isUpdated) {
                    response.sendRedirect("user?action=showUserInfo");
                } else {
                    request.setAttribute("errorMessage", "Failed to update user information.");
                    request.getRequestDispatcher("/WEB-INF/view/client/updateUser.jsp").forward(request, response);
                }
            } catch (Exception ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
                response.sendRedirect("error.jsp");
            }
        }
    }
}
