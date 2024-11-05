/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
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
import java.util.Optional;
import java.util.OptionalInt;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import model.Cart;
import model.CartDetail;
import model.Java_JDBC;
import model.Product;
import model.User;

@WebServlet(name = "ClientServlet", urlPatterns = { "/client" })
public class ClientServlet extends HttpServlet {

    private class ResponseMessage {

        private boolean success;
        private String message;
        private double totalPrice;
        private int cartItemCount;
        private int newQuantity;
        private double newTotalPrice;

        public ResponseMessage(boolean success, String message) {
            this.success = success;
            this.message = message;
        }

        public ResponseMessage(boolean success, String message, double totalPrice, int cartItemCount) {
            this.success = success;
            this.message = message;
            this.totalPrice = totalPrice;
            this.cartItemCount = cartItemCount;
        }

        public ResponseMessage(boolean success, String message, double totalPrice, int cartItemCount, int newQuantity,
                double newTotalPrice) {
            this.success = success;
            this.message = message;
            this.totalPrice = totalPrice;
            this.cartItemCount = cartItemCount;
            this.newQuantity = newQuantity;
            this.newTotalPrice = newTotalPrice;
        }

        // Getters và Setters nếu cần
        public boolean isSuccess() {
            return success;
        }

        public void setSuccess(boolean success) {
            this.success = success;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }

        public double getTotalPrice() {
            return totalPrice;
        }

        public void setTotalPrice(double totalPrice) {
            this.totalPrice = totalPrice;
        }

        public int getCartItemCount() {
            return cartItemCount;
        }

        public void setCartItemCount(int cartItemCount) {
            this.cartItemCount = cartItemCount;
        }

        public int getNewQuantity() {
            return newQuantity;
        }

        public void setNewQuantity(int newQuantity) {
            this.newQuantity = newQuantity;
        }

        public double getNewTotalPrice() {
            return newTotalPrice;
        }

        public void setNewTotalPrice(double newTotalPrice) {
            this.newTotalPrice = newTotalPrice;
        }

    }

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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (null != action) {
            switch (action) {
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
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (null != action) {
            switch (action) {
                case "addToCart":
                    handleAddToCart(request, response);
                    break;
                case "updateCart":
                    handleUpdateCart(request, response);
                    break;
                case "removeFromCart":
                    handleRemoveFromCart(request, response);
                    break;
                default:
                    break;
            }
        }
    }

    private void handleAddToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");

            Gson gson = new Gson();
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();

            if (currentUser == null) {
                // Người dùng chưa đăng nhập
                ResponseMessage msg = new ResponseMessage(false, "Bạn cần đăng nhập trước khi thêm vào giỏ hàng.");
                out.print(gson.toJson(msg));
                out.flush();
                return;
            }

            // Lấy tham số productId từ yêu cầu
            String productIdStr = request.getParameter("id");
            if (productIdStr == null) {
                ResponseMessage msg = new ResponseMessage(false, "Không tìm thấy sản phẩm.");
                out.print(gson.toJson(msg));
                out.flush();
                return;
            }

            int productId;
            try {
                productId = Integer.parseInt(productIdStr);
            } catch (NumberFormatException e) {
                ResponseMessage msg = new ResponseMessage(false, "ID sản phẩm không hợp lệ.");
                out.print(gson.toJson(msg));
                out.flush();
                return;
            }

            Cart cart = Java_JDBC.updateCartForUser(currentUser, productId, request.getParameter("action"));

            // Tính tổng giá
            double totalPrice = 0.0;
            for (CartDetail cartDetail : cart.getCartDetails()) {
                totalPrice += cartDetail.getProduct().getPrice() * cartDetail.getQuantity();
            }

            session.setAttribute("cart", cart);

            // Gửi phản hồi thành công
            ResponseMessage msg = new ResponseMessage(true, "Đã thêm vào giỏ hàng thành công!", totalPrice,
                    cart.getCartDetails().size());
            out.print(gson.toJson(msg));
            out.flush();
            response.flushBuffer();
        } catch (Exception ex) {
            Logger.getLogger(ClientServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void handleUpdateCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");

            Gson gson = new Gson();
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();

            String productIdStr = request.getParameter("id");
            String actionType = request.getParameter("actionUpdate"); // "increase" hoặc "decrease"

            if (productIdStr == null || actionType == null) {
                ResponseMessage msg = new ResponseMessage(false, "Thông tin không hợp lệ.");
                out.print(gson.toJson(msg));
                out.flush();
                return;
            }

            int productId;
            try {
                productId = Integer.parseInt(productIdStr);
            } catch (NumberFormatException e) {
                ResponseMessage msg = new ResponseMessage(false, "ID sản phẩm không hợp lệ.");
                out.print(gson.toJson(msg));
                out.flush();
                return;
            }

            final Cart cart = (Cart) session.getAttribute("cart");

            CartDetail targetDetail = null;
            for (CartDetail detail : cart.getCartDetails()) {
                if (detail.getProduct().getId() == productId) {
                    targetDetail = detail;
                    break;
                }
            }

            if (targetDetail == null) {
                ResponseMessage msg = new ResponseMessage(false, "Sản phẩm không có trong giỏ hàng.");
                out.print(gson.toJson(msg));
                out.flush();
                return;
            }

            OptionalInt indexOpt = IntStream.range(0, cart.getCartDetails().size())
                    .filter(i -> cart.getCartDetails().get(i).getProduct().getId() == productId)
                    .findFirst();
            int index = indexOpt.getAsInt();
            CartDetail updateCartDetail = cart.getCartDetails().get(index);
            switch (actionType) {
                case "increase":
                    Java_JDBC.updateCartForUser(currentUser, productId, actionType);
                    updateCartDetail.setQuantity(updateCartDetail.getQuantity() + 1);
                    cart.getCartDetails().set(index, updateCartDetail);
                    break;
                case "decrease":
                    Java_JDBC.updateCartForUser(currentUser, productId, actionType);
                    if (updateCartDetail.getQuantity() <= 1) {
                        ResponseMessage msg = new ResponseMessage(false, "Số lượng sản phẩm đang là 1. Không thể bớt");
                        out.print(gson.toJson(msg));
                        out.flush();
                        return;
                    } else {
                        updateCartDetail.setQuantity(updateCartDetail.getQuantity() - 1);
                        cart.getCartDetails().set(index, updateCartDetail);
                    }
                    break;
                default:
                    ResponseMessage msg = new ResponseMessage(false, "Hành động không hợp lệ.");
                    out.print(gson.toJson(msg));
                    out.flush();
                    return;
            }

            // Tính tổng giá trị giỏ hàng
            double totalPrice = 0.0;
            for (CartDetail cartDetail : cart.getCartDetails()) {
                totalPrice += cartDetail.getProduct().getPrice() * cartDetail.getQuantity();
            }

            // Cập nhật giỏ hàng trong session
            session.setAttribute("cart", cart);

            // Gửi phản hồi thành công với số lượng mới và tổng giá
            ResponseMessage msg = new ResponseMessage(
                    true,
                    "Cập nhật giỏ hàng thành công!",
                    totalPrice, // Tổng giá của giỏ hàng
                    cart.getCartDetails().size(), // Số lượng mặt hàng trong giỏ hàng
                    targetDetail.getQuantity(), // Số lượng mới của sản phẩm
                    targetDetail.getProduct().getPrice() * targetDetail.getQuantity() // Thành tiền mới của sản phẩm
            );
            out.print(gson.toJson(msg));
            out.flush();
            response.flushBuffer();
        } catch (Exception ex) {
            Logger.getLogger(ClientServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void handleRemoveFromCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");

            Gson gson = new Gson();
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();

            String productIdStr = request.getParameter("id");

            if (productIdStr == null) {
                ResponseMessage msg = new ResponseMessage(false, "Không tìm thấy sản phẩm.");
                out.print(gson.toJson(msg));
                out.flush();
                return;
            }

            int productId;
            try {
                productId = Integer.parseInt(productIdStr);
            } catch (NumberFormatException e) {
                ResponseMessage msg = new ResponseMessage(false, "ID sản phẩm không hợp lệ.");
                out.print(gson.toJson(msg));
                out.flush();
                return;
            }

            Cart cart = (Cart) session.getAttribute("cart");

            for (CartDetail cartDetail : cart.getCartDetails()) {
                if (cartDetail.getProduct().getId() == productId) {
                    cart = Java_JDBC.updateCartForUser(currentUser, productId, request.getParameter("action"));
                    break;
                }
            }

            // Tính tổng giá trị giỏ hàng
            double totalPrice = 0.0;
            for (CartDetail cartDetail : cart.getCartDetails()) {
                totalPrice += cartDetail.getProduct().getPrice() * cartDetail.getQuantity();
            }

            // Cập nhật giỏ hàng trong session
            session.setAttribute("cart", cart);

            // Gửi phản hồi thành công
            ResponseMessage msg = new ResponseMessage(true, "Đã xóa sản phẩm khỏi giỏ hàng.", totalPrice,
                    cart.getCartDetails().size());
            out.print(gson.toJson(msg));
            out.flush();
            response.flushBuffer();
        } catch (Exception ex) {
            Logger.getLogger(ClientServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void showCart(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("username") == null) {
                response.sendRedirect("AuthServlet?action=login");
                return;
            }

            User user = (User) session.getAttribute("user");
            Cart cart = Java_JDBC.getCartForUser(user);

            double totalPrice = 0.0;
            for (CartDetail cartDetail : cart.getCartDetails()) {
                totalPrice += cartDetail.getProduct().getPrice() * cartDetail.getQuantity();
            }

            request.setAttribute("cart", cart);
            request.setAttribute("totalPrice", totalPrice);

            request.getRequestDispatcher(ResourcesHandler.ClientPath() + "/cartDetail.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ClientServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void filterProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
        if (!Objects.equals(brands, prevBrands) || !Objects.equals(prices, prevPrices)
                || !Objects.equals(sort, prevSort)) {
            // Nếu có thay đổi, tiến hành lọc và lưu kết quả vào session
            List<String> brandList = brands != null && !brands.isEmpty() ? Arrays.asList(brands.split(","))
                    : new ArrayList<>();
            List<String> priceList = prices != null && !prices.isEmpty() ? Arrays.asList(prices.split(","))
                    : new ArrayList<>();

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
                productsFiltered = Java_JDBC.getAllProducts(); // Lấy tất cả sản phẩm nếu chưa có lọc
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

        request.setAttribute("products", products);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("url", request.getContextPath() + "/client?action=filter&brands=" + brands + "&prices="
                + prices + "&sort=" + sort);

        request.setAttribute("productsFiltered", productsFiltered);
        request.getRequestDispatcher(ResourcesHandler.ClientPath() + "/allProductsPage.jsp").forward(request, response);
    }

    private void showProductPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

    private void showProductInformation(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
