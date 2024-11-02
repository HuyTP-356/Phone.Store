package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import model.Java_JDBC;
import model.Product;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            
            if (null == action) {
                try {
                    listProducts(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else
                switch (action) {
                    case "view" -> viewProduct(request, response);
                    case "search" -> searchProduct(request, response);
                    // } else if ("category".equals(action)) {
                    // getProductsByCategory(request, response);
                    default -> listProducts(request, response);
                }
        } catch (Exception ex) {
            Logger.getLogger(ProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<Product> products = Java_JDBC.getAllProducts(); // Assuming this method exists
        request.setAttribute("products", products);
        request.getRequestDispatcher("/homepage.jsp").forward(request, response);
    }

    private void viewProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = Java_JDBC.getProductById(productId); // Assuming this method exists
        request.setAttribute("product", product);
        request.getRequestDispatcher("/productDetails.jsp").forward(request, response);
    }

    private void searchProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = request.getParameter("query");
        List<Product> products = Java_JDBC.searchProducts(query); // Assuming this method exists
        request.setAttribute("products", products);
        request.getRequestDispatcher("/homepage.jsp").forward(request, response);
    }

}
