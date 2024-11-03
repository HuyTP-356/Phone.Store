/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Java_JDBC;
import model.Product;

/**
 *
 * @author Ngo Duong Hoang Chau
 */
@WebServlet(name = "ClientServlet", urlPatterns = {"/client"})
public class ClientServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ClientServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ClientServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (null != action) {
            switch (action) {
                case "addToCart":
                    handleAddToCart(request, response);
                    break;
                case "showCart":
                    showCart(request, response);
                    break;
                case "showProductInfor":
                    showProductInformation(request, response);
                    break;
                default:
                    break;
            }
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void handleAddToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false); // Lấy session hiện tại
        if (session == null || session.getAttribute("user") == null) {
            // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect(ResourcesHandler.ClientPath() + "/login.jsp");
            return;
        }

        // Người dùng đã đăng nhập, thực hiện thêm vào giỏ hàng
        int productId = Integer.parseInt(request.getParameter("id"));
        // Logic để thêm sản phẩm vào giỏ hàng
        // ...

        // Chuyển hướng lại trang chính (hoặc hiển thị thông báo thành công)
        response.sendRedirect("homepage.jsp?message=Product added to cart!");
    }

    private void showCart(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    private void showProductInformation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = Java_JDBC.getProductById(productId);
        request.setAttribute("product", product);

        List<Product> productList = Java_JDBC.getAllProducts();
        Map<String, Integer> categoryCount = new HashMap<>();
        for (Product p : productList) {
            String brand = p.getBrand();
            categoryCount.put(brand, categoryCount.getOrDefault(brand, 0) + 1);
        }
        request.setAttribute("categoryCount", categoryCount);
        request.getRequestDispatcher(ResourcesHandler.ClientPath() + "/productDetail.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
