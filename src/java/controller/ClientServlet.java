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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;
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
                case "allProductsPage":
                    showProductPage(request, response);
                    break;
                case "filter":
                    filterProduct(request, response);
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

    private void filterProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String brands = request.getParameter("brands");
        String prices = request.getParameter("prices");
        String sort = request.getParameter("sort");

// Lấy các giá trị lọc trước đó từ Session
        String prevBrands = (String) session.getAttribute("prevBrands");
        String prevPrices = (String) session.getAttribute("prevPrices");
        String prevSort = (String) session.getAttribute("prevSort");

        List<Product> productsFiltered;

// Kiểm tra xem có thay đổi yêu cầu lọc không
        if (!Objects.equals(brands, prevBrands) || !Objects.equals(prices, prevPrices) || !Objects.equals(sort, prevSort)) {
            // Nếu có thay đổi, tiến hành lọc và lưu kết quả vào session
            List<String> brandList = brands != null && !brands.isEmpty() ? Arrays.asList(brands.split(",")) : new ArrayList<>();
            List<String> priceList = prices != null && !prices.isEmpty() ? Arrays.asList(prices.split(",")) : new ArrayList<>();

            productsFiltered = Java_JDBC.getFilteredProducts(brandList, priceList, sort);

            // Cập nhật danh sách đã lọc và giá trị lọc hiện tại vào Session
            session.setAttribute("productsFiltered", productsFiltered);
            session.setAttribute("prevBrands", brands);
            session.setAttribute("prevPrices", prices);
            session.setAttribute("prevSort", sort);
        } else {
            // Nếu không có thay đổi, sử dụng productsFiltered từ session
            productsFiltered = (List<Product>) session.getAttribute("productsFiltered");
            if (productsFiltered == null) {
                productsFiltered = Java_JDBC.getAllProducts();  // Lấy tất cả sản phẩm nếu chưa có lọc
                session.setAttribute("productsFiltered", productsFiltered);
            }
        }

        request.setAttribute("selectedBrands", brands);
        request.setAttribute("selectedPrices", prices);
        request.setAttribute("selectedSort", sort);

        // Phân trang lại sau khi filter
        int recordsPerPage = 9;
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        int totalRecords = productsFiltered.size();
        int offset = (page - 1) * recordsPerPage;
        List<Product> products = productsFiltered.stream()
                .skip(offset)
                .limit(recordsPerPage)
                .collect(Collectors.toList());

        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

        List<String> allBrands = Java_JDBC.getAllBrands();
        request.setAttribute("brands", allBrands);

        request.setAttribute("products", products);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("url", request.getContextPath() + "/client?action=filter&brands=" + brands + "&prices=" + prices + "&sort=" + sort);

        request.setAttribute("productsFiltered", productsFiltered);
        request.getRequestDispatcher(ResourcesHandler.ClientPath() + "/allProductsPage.jsp").forward(request, response);
    }

    private void showProductPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int recordsPerPage = 9;
        int page = 1;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        int offset = (page - 1) * recordsPerPage;

        List<Product> products = Java_JDBC.getProductsByPage(offset, recordsPerPage);

        int totalRecords = Java_JDBC.getProductCount();
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

        List<String> brands = Java_JDBC.getAllBrands();
        request.setAttribute("brands", brands);

        request.setAttribute("products", products);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("url", request.getContextPath() + "/client?action=allProductsPage");

        request.getRequestDispatcher(ResourcesHandler.ClientPath() + "/allProductsPage.jsp").forward(request, response);
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
