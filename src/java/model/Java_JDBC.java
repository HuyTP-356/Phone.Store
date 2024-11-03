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
                product.setId(resultSet.getInt("product_id"));
                product.setName(resultSet.getString("product_name"));
                product.setBrand(resultSet.getString("brand"));
                product.setPrice(resultSet.getDouble("price"));
                product.setDescription(resultSet.getString("description"));
                product.setImageUrl(resultSet.getString("image_url"));
                product.setStockQuantity(resultSet.getInt("stock_quantity"));
                productList.add(product);
            }
            System.out.println("Number of products retrieved: " + productList.size());
        } catch (SQLException e) {
            e.getErrorCode();
        }
        return productList;
    }

    public static Role getRoleById(int roleId) throws Exception {
        Role role = null;

        String query = "SELECT name, description FROM Role WHERE role_id = ?";

        try (Connection con = getConnectionWithSqlJdbc(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, roleId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String roleName = rs.getString("name");
                String description = rs.getString("description");

                role = new Role(roleName, description);
            }
        } catch (SQLException e) {
            throw new Exception("Error retrieving role", e);
        }

        return role;
    }

    public static User getUserByUserName(String username) throws Exception {
        User user = null;

        String query = "SELECT user_id, username, email, password_hash, full_name, role_id, created_at, phone_number FROM Users WHERE username = ?";

        try (Connection con = getConnectionWithSqlJdbc(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
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
            stmt.setString(2, password);

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
            stmt.setInt(1, productId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("product_name"));
                product.setBrand(rs.getString("brand"));
                product.setPrice(rs.getDouble("price"));
                product.setDescription(rs.getString("description"));
                product.setImageUrl(rs.getString("image_url"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving product by ID: " + e.getMessage());
        }

        return product;
    }

    public static boolean updateProduct(Product updatedProduct) {
        String sql = "UPDATE Products SET product_name = ?, brand = ?, price = ?, description = ?, image_url = ?, stock_quantity = ? WHERE product_id = ?";

        try (Connection conn = getConnectionWithSqlJdbc(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, updatedProduct.getName());
            pstmt.setString(2, updatedProduct.getBrand());
            pstmt.setDouble(3, updatedProduct.getPrice());
            pstmt.setString(4, updatedProduct.getDescription());
            pstmt.setString(5, updatedProduct.getImageUrl());
            pstmt.setInt(6, updatedProduct.getStockQuantity());
            pstmt.setInt(7, updatedProduct.getId());

            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean deleteProductById(int productId) {
        String sql = "DELETE FROM Products WHERE product_id = ?";

        try (Connection conn = getConnectionWithSqlJdbc(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, productId);

            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<Product> getProductsByPage(int offset, int recordsPerPage) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products ORDER BY product_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";

        try (Connection conn = getConnectionWithSqlJdbc(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, offset);
            pstmt.setInt(2, recordsPerPage);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt("product_id"));
                    product.setName(rs.getString("product_name"));
                    product.setBrand(rs.getString("brand"));
                    product.setPrice(rs.getDouble("price"));
                    product.setImageUrl(rs.getString("image_url"));
                    product.setDescription(rs.getString("description"));
                    product.setStockQuantity(rs.getInt("stock_quantity"));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public static int getProductCount() {
        String sql = "SELECT COUNT(*) FROM Products";
        int count = 0;

        try (Connection conn = getConnectionWithSqlJdbc(); PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    public static List<Product> getFirst16Products() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT TOP 16 * FROM Products ORDER BY product_id";

        try (Connection conn = getConnectionWithSqlJdbc(); PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("product_name"));
                product.setBrand(rs.getString("brand"));
                product.setPrice(rs.getDouble("price"));
                product.setImageUrl(rs.getString("image_url"));
                product.setDescription(rs.getString("description"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public static List<String> getAllBrands() {
        List<String> brands = new ArrayList<>();
        String sql = "SELECT DISTINCT brand FROM Products";

        try (Connection con = getConnectionWithSqlJdbc(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                brands.add(rs.getString("brand"));
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return brands;
    }

    public static List<Product> searchProducts(String query) {
        return new ArrayList<>();
    }

    public static List<Product> getFilteredProducts(List<String> brands, List<String> prices, String sort) {
        List<Product> products = new ArrayList<>();
        Connection con = getConnectionWithSqlJdbc();
        try {
            StringBuilder query = new StringBuilder("SELECT * FROM Products WHERE 1=1");

            if (!brands.isEmpty()) {
                query.append(" AND brand IN (");
                for (int i = 0; i < brands.size(); i++) {
                    query.append("?");
                    if (i < brands.size() - 1) {
                        query.append(", ");
                    }
                }
                query.append(")");
            }

            if (!prices.isEmpty()) {
                int pricesLeft = prices.size();
                for (String price : prices) {            
                    switch (price) {
                        case "duoi-10-trieu":
                            if (pricesLeft == prices.size())
                                query.append(" AND price < 10000000");
                            else if (pricesLeft < prices.size())
                                query.append(" OR price < 10000000");                             
                            pricesLeft--;
                            break;
                        case "10-15-trieu":
                            if (pricesLeft == prices.size())
                                query.append(" AND price BETWEEN 10000000 AND 15000000");
                            else if (pricesLeft < prices.size())
                                query.append(" OR price BETWEEN 10000000 AND 15000000");
                            pricesLeft--;
                            break;
                        case "15-20-trieu":
                            if (pricesLeft == prices.size())
                                query.append(" AND price BETWEEN 15000000 AND 20000000");
                            else if (pricesLeft < prices.size())
                                query.append(" OR price BETWEEN 15000000 AND 20000000");
                            pricesLeft--;                          
                            break;
                        case "tren-20-trieu":
                            if (pricesLeft == prices.size())
                                query.append(" AND price > 20000000");
                            else if (pricesLeft < prices.size())
                                query.append(" OR price > 20000000");
                            pricesLeft--;
                            break;
                        default:
                            break;
                    }
                }
            }

            if ("gia-tang-dan".equals(sort)) {
                query.append(" ORDER BY price ASC");
            } else if ("gia-giam-dan".equals(sort)) {
                query.append(" ORDER BY price DESC");
            }

            PreparedStatement ps = con.prepareStatement(query.toString());

            int index = 1;
            for (String brand : brands) {
                ps.setString(index++, brand);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("product_id"));
                product.setName(rs.getString("product_name"));
                product.setBrand(rs.getString("brand"));
                product.setPrice(rs.getDouble("price"));
                product.setImageUrl(rs.getString("image_url"));
                product.setDescription(rs.getString("description"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

}
