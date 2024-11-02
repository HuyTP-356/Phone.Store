package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Java_JDBC {

    public static Connection getConnectionWithSqlJdbc() throws Exception {
        Connection con = null;
        String dbUser = "sa";
        String dbPassword = "123";
        String port = "1433";
        String IP = "127.0.0.1";
        String ServerName = "DESKTOP-B26N793\\HOANGCHAU";
        String DBName = "PhoneStore";
        String driverClass = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

        String dbURL = "jdbc:sqlserver://" + ServerName + ";databaseName=" + DBName
                + ";encrypt=false;trustServerCertificate=false;loginTimeout=30";
        // String ServerName = "DESKTOP-UKLNCAK";
        // String DBName = "PhoneStore";
        // String driverClass = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

        // String dbURL = "jdbc:sqlserver://" + ServerName + ":" + port +
        // ";databaseName=" + DBName +
        // ";encrypt=false;trustServerCertificate=false;loginTimeout=30";

        try {
            Class.forName(driverClass);
            con = DriverManager.getConnection(dbURL, dbUser, dbPassword);
            System.out.println("Connection established successfully.");
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return con;
    }

    public static List<Product> getAllProducts() throws Exception {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM Products";

        try (Connection connection = getConnectionWithSqlJdbc();
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery(query)) {

            while (resultSet.next()) {
                Product product = new Product();
                product.setId(resultSet.getInt("product_id")); // Assuming the column name is product_id
                product.setName(resultSet.getString("product_name")); // Assuming the column name is product_name
                product.setBrand(resultSet.getString("brand"));
                product.setPrice(resultSet.getDouble("price"));
                product.setDescription(resultSet.getString("description"));
                product.setImageUrl(resultSet.getString("image_url")); // Assuming the column name is image_url
                product.setStockQuantity(resultSet.getInt("stock_quantity")); // Assuming the column name is
                                                                              // stock_quantity
                productList.add(product);
            }
            System.out.println("Number of products retrieved: " + productList.size()); // Debug statement
        } catch (SQLException e) {
            throw new Exception("Error retrieving products", e);
        }
        return productList;
    }

    public static boolean validateUser(String username, String password) throws Exception {
        User user = null;

        try (Connection con = getConnectionWithSqlJdbc()) {
            String query = "SELECT * FROM Users WHERE username = ? AND password_hash = ?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, password); // Plain password check for now

            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (Exception e) {
            throw new Exception("Error validating user", e);
        }
    }

    public static void insertProduct(Product product) throws Exception {
        String insertQuery = "INSERT INTO Products (product_name, brand, price, description, image_url, stock_quantity) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = getConnectionWithSqlJdbc(); PreparedStatement stmt = con.prepareStatement(insertQuery)) {
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getBrand());
            stmt.setDouble(3, product.getPrice());
            stmt.setString(4, product.getDescription());
            stmt.setString(5, product.getImageUrl());
            stmt.setInt(6, product.getStockQuantity());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Inserting product failed, no rows affected.");
            }
        } catch (SQLException e) {
            throw new Exception("Error inserting product: " + e.getMessage(), e);
        }
    }

    public static Product getProductById(int productId) {
        return new Product();
    }

    public static List<Product> searchProducts(String query) {
        return new ArrayList<>();
    }

}
