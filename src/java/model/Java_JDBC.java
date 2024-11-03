package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Java_JDBC {

    public static Connection getConnectionWithSqlJdbc() {
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
            try {
                Class.forName(driverClass);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(Java_JDBC.class.getName()).log(Level.SEVERE, null, ex);
            }
            con = DriverManager.getConnection(dbURL, dbUser, dbPassword);
            System.out.println("Connection established successfully.");
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return con;
    }

    public static List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        String query = "SELECT * FROM Products";

        try (Connection connection = getConnectionWithSqlJdbc(); Statement statement = connection.createStatement(); ResultSet resultSet = statement.executeQuery(query)) {

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
            e.getErrorCode();
        }
        return productList;
    }

    public static Role getRoleById(int roleId) throws Exception {
        Role role = null;

        String query = "SELECT name, description FROM Role WHERE role_id = ?";

        try (Connection con = getConnectionWithSqlJdbc(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, roleId); // Set the roleId parameter

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String roleName = rs.getString("name"); // Thay đổi từ "role_name" thành "name"
                String description = rs.getString("description");

                role = new Role(roleName, description); // Giả sử bạn đã cập nhật constructor cho Role
            }
        } catch (SQLException e) {
            throw new Exception("Error retrieving role", e);
        }

        return role; // Trả về đối tượng Role hoặc null nếu không tìm thấy
    }

    public static User getUserByUserName(String username) throws Exception {
        User user = null;

        String query = "SELECT user_id, username, email, password_hash, full_name, role_id, created_at, phone_number FROM Users WHERE username = ?";

        try (Connection con = getConnectionWithSqlJdbc(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Lấy thông tin từ ResultSet và tạo đối tượng User
                int userId = rs.getInt("user_id");
                String email = rs.getString("email");
                String passwordHash = rs.getString("password_hash");
                String fullName = rs.getString("full_name");
                String phoneNumber = rs.getString("phone_number");
                Role role = getRoleById(rs.getInt("role_id"));

                user = new User(userId, username, email, passwordHash, fullName, phoneNumber);
                user.setRole(role);
            }
        } catch (SQLException e) {
            throw new Exception("Error retrieving user", e);
        }

        return user;
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

    public static void insertProduct(Product product) {
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
            e.getErrorCode();
        }
    }

    public static Product getProductById(int productId) {
        Product product = null;
        String query = "SELECT * FROM Products WHERE product_id = ?";

        try (Connection con = getConnectionWithSqlJdbc(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, productId); // Set the product ID parameter

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Retrieve values from ResultSet and set them in a Product object
                product = new Product();
                product.setId(rs.getInt("product_id")); // Assuming column name is product_id
                product.setName(rs.getString("product_name")); // Assuming column name is product_name
                product.setBrand(rs.getString("brand"));
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description"));
                product.setImageUrl(rs.getString("image_url")); // Assuming column name is image_url
                product.setStockQuantity(rs.getInt("stock_quantity")); // Assuming column name is stock_quantity
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving product by ID: " + e.getMessage());
        }

        return product; // Return the product object or null if not found
    }

    public static List<Product> searchProducts(String query) {
        return new ArrayList<>();
    }

}
