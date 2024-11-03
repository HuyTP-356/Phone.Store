package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.List;
import model.Java_JDBC;
import model.Product;

/**
 *
 * @author Ngo Duong Hoang Chau
 */
@WebServlet(name = "AdminServlet", urlPatterns = {"/AdminServlet"})
public class AdminServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminServlet at " + request.getContextPath() + "</h1>");
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
                case "product":
                    ResourcesHandler.forwardToAdminPage(request, response, "/product/show");
                    break;
                case "viewAllProducts":
                    viewAllProducts(request, response);
                    break;
                case "viewDetailProduct":
                    viewDetailProduct(request, response);
                    break;
                case "updateProduct":
                    viewDetailProduct(request, response);
                    break;  
                case "dashboard":
                    ResourcesHandler.forwardToAdminPage(request, response, "/dashboard/show");
                    break;
                case "user":
                    ResourcesHandler.forwardToAdminPage(request, response, "/user/show");
                    break;
                case "createProduct":
                    ResourcesHandler.forwardToAdminPage(request, response, "/product/create");
                    break;
                case "handleCreateProduct":
                    break;
                default:
                    break;
            }
        }
    }
    
    private void viewAllProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = Java_JDBC.getAllProducts(); // Assuming this method exists
        request.setAttribute("products", products);
        request.getRequestDispatcher(ResourcesHandler.AdminPath() + "/product/show.jsp").forward(request, response);
    }
    
    private void viewDetailProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        Product product = Java_JDBC.getProductById(Integer.parseInt(id));
        request.setAttribute("product", product);
        request.getRequestDispatcher(ResourcesHandler.AdminPath() + "/product/detail.jsp").forward(request, response);
        
    }

    private void handleCreateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin từ form
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String detailDesc = request.getParameter("detailDesc");
        String quantityStr = request.getParameter("quantity");
        String brand = request.getParameter("factory");
        String imageURL = request.getParameter("productImageFile");

        // Khởi tạo biến để kiểm tra lỗi
        boolean hasError = false;
        String errorPrice = "";
        String errorName = "";
        String errorDetailDesc = "";
        String errorQuantity = "";
        String errorImageUrl = "";

        // Kiểm tra tính hợp lệ của các thông tin
        if (name == null || name.trim().isEmpty()) {
            hasError = true;
            errorName = "Name cannot be empty. ";
        }
        
        if (detailDesc == null || detailDesc.trim().isEmpty()) {
            hasError = true;
            errorDetailDesc = "Description cannot be empty. ";
        }
        
        if (imageURL == null || imageURL.trim().isEmpty()) {
            hasError = true;
            errorImageUrl = "Image URL cannot be empty. ";
        }

        double price = 0.0;
        try {
            price = Double.parseDouble(priceStr);
            if (price < 0) {
                hasError = true;
                errorPrice += "Price must be a positive number. ";
            }
        } catch (NumberFormatException e) {
            hasError = true;
            errorPrice = "Invalid price format. ";
        }

        int quantity = 0;
        try {
            quantity = Integer.parseInt(quantityStr);
            if (quantity < 0) {
                hasError = true;
                errorQuantity = "Quantity must be a positive number. ";
            }
        } catch (NumberFormatException e) {
            hasError = true;
            errorQuantity += "Invalid quantity format. ";
        }

        // Xử lý tệp hình ảnh nếu không có lỗi
        if (!hasError) {
            // Tạo một sản phẩm mới
            Product newProduct = new Product(1, name, brand, price, detailDesc, imageURL, quantity);
            Java_JDBC.insertProduct(newProduct);

            // Chuyển hướng đến trang thành công
            response.sendRedirect(request.getContextPath() + "/admin/product/show");
        } else {
            // Nếu có lỗi, set thông báo lỗi và quay lại trang tạo sản phẩm
            request.setAttribute("errorName", errorName);
            request.setAttribute("errorPrice", errorPrice);
            request.setAttribute("errorDetailDesc", errorDetailDesc);
            request.setAttribute("errorQuantity", errorQuantity);
            request.setAttribute("errorImageUrl", errorImageUrl);

            ResourcesHandler.forwardToAdminPage(request, response, "/product/create");
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
