package model;

import java.sql.*;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
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
//        String ServerName = "DESKTOP-UKLNCAK";
//        String DBName = "PhoneStore";
//        String driverClass = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
//
//        String dbURL = "jdbc:sqlserver://" + ServerName + ":" + port
//                + ";databaseName=" + DBName
//                + ";encrypt=false;trustServerCertificate=false;loginTimeout=30";
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

        try (Connection connection = getConnectionWithSqlJdbc();
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery(query)) {

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

        String query = "SELECT username, email, password_hash, full_name, role_id, created_at, phonenumber, address FROM Users WHERE username = ?";

        try (Connection con = getConnectionWithSqlJdbc(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String email = rs.getString("email");
                String passwordHash = rs.getString("password_hash");
                String fullName = rs.getString("full_name");
                String phoneNumber = rs.getString("phonenumber");
                Role role = getRoleById(rs.getInt("role_id"));
                String address = rs.getString("address");

                user = new User(username, email, passwordHash, fullName, phoneNumber, address);
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

    public static void insertUser(User user) {
        String insertQuery = "INSERT INTO Users (username, email, password_hash, full_name, role_id, phonenumber, created_at, address) VALUES (?, ?, ?, ?, 1, ?, ?, ?)";

        try (Connection con = getConnectionWithSqlJdbc(); PreparedStatement stmt = con.prepareStatement(insertQuery)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPasswordHash());
            stmt.setString(4, user.getFullName());
            stmt.setString(5, user.getPhoneNumber());
            stmt.setDate(6, new java.sql.Date(Date.from(Instant.now()).getTime()));
            stmt.setString(7, user.getAddress());

            int rowsAffected = stmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected); // In ra số hàng bị ảnh hưởng

            if (rowsAffected == 0) {
                throw new SQLException("Inserting user failed, no rows affected.");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // In ra chi tiết lỗi
        }
    }

    public static boolean updateUser(String username, String email, String fullName, String phoneNumber,
            String passwordHash, String address) {
        // Retrieve the current user
        User currentUser;
        try {
            currentUser = getUserByUserName(username);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        // Build the update query
        StringBuilder sql = new StringBuilder("UPDATE Users SET ");
        boolean isFirst = true;

        if (email != null) {
            sql.append("email = ?");
            isFirst = false;
        }
        if (fullName != null) {
            if (!isFirst) {
                sql.append(", ");
            }
            sql.append("full_name = ?");
            isFirst = false;
        }
        if (phoneNumber != null) {
            if (!isFirst) {
                sql.append(", ");
            }
            sql.append("phonenumber = ?");
            isFirst = false;
        }
        if (passwordHash != null) {
            if (!isFirst) {
                sql.append(", ");
            }
            sql.append("password_hash = ?");
            isFirst = false;
        }
        if (address != null) {
            if (!isFirst) {
                sql.append(", ");
            }
            sql.append("address = ?");
        }
        sql.append(" WHERE username = ?");

        try (Connection conn = getConnectionWithSqlJdbc();
                PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            if (email != null) {
                pstmt.setString(paramIndex++, email);
            }
            if (fullName != null) {
                pstmt.setString(paramIndex++, fullName);
            }
            if (phoneNumber != null) {
                pstmt.setString(paramIndex++, phoneNumber);
            }
            if (passwordHash != null) {
                pstmt.setString(paramIndex++, passwordHash);
            }
            if (address != null) {
                pstmt.setString(paramIndex++, address);
            }
            pstmt.setString(paramIndex, username);

            System.out.println("Executing update with query: " + sql);
            System.out.println("Parameters - username: " + username);

            int rowsUpdated = pstmt.executeUpdate();
            System.out.println("Rows updated: " + rowsUpdated);
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
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

        try (Connection conn = getConnectionWithSqlJdbc();
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery()) {
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

        try (Connection conn = getConnectionWithSqlJdbc();
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery()) {

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

        try (Connection con = getConnectionWithSqlJdbc();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

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
                            if (pricesLeft == prices.size()) {
                                query.append(" AND price < 10000000");
                            } else if (pricesLeft < prices.size()) {
                                query.append(" OR price < 10000000");
                            }
                            pricesLeft--;
                            break;
                        case "10-15-trieu":
                            if (pricesLeft == prices.size()) {
                                query.append(" AND price BETWEEN 10000000 AND 15000000");
                            } else if (pricesLeft < prices.size()) {
                                query.append(" OR price BETWEEN 10000000 AND 15000000");
                            }
                            pricesLeft--;
                            break;
                        case "15-20-trieu":
                            if (pricesLeft == prices.size()) {
                                query.append(" AND price BETWEEN 15000000 AND 20000000");
                            } else if (pricesLeft < prices.size()) {
                                query.append(" OR price BETWEEN 15000000 AND 20000000");
                            }
                            pricesLeft--;
                            break;
                        case "tren-20-trieu":
                            if (pricesLeft == prices.size()) {
                                query.append(" AND price > 20000000");
                            } else if (pricesLeft < prices.size()) {
                                query.append(" OR price > 20000000");
                            }
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

    public static Cart getCartForUser(User user) {
        Cart cart = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = getConnectionWithSqlJdbc();

            // Nếu giỏ hàng tồn tại, lấy thông tin cart_id và các sản phẩm
            String checkItemQuery = "SELECT cart_id, user_id FROM Cart WHERE user_id = ?";
            stmt = conn.prepareStatement(checkItemQuery);
            stmt.setInt(1, user.getUserId());
            rs = stmt.executeQuery();
            if (rs.next()) {
                int cartId = rs.getInt("cart_id");

                cart = new Cart(cartId, user);

                List<CartDetail> cartDetails = new ArrayList<>();
                String sql = "SELECT product_id, quantity FROM CartItem WHERE cart_id = ?";
                PreparedStatement detailStmt = conn.prepareStatement(sql);
                detailStmt.setInt(1, cartId);
                ResultSet detailRs = detailStmt.executeQuery();

                while (detailRs.next()) {
                    int productId = detailRs.getInt("product_id");
                    int quantity = detailRs.getInt("quantity");

                    Product product = getProductById(productId);
                    if (product != null) {
                        CartDetail cartDetail = new CartDetail(product, quantity);
                        cartDetails.add(cartDetail);
                    }
                }
                cart.setCartDetails(cartDetails);
                user.setCart(cart); // Gắn giỏ hàng vào user
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cart;
    }

    public static Cart updateCartForUser(User user, int productId, String action) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        conn = getConnectionWithSqlJdbc();
        Cart cart = getCartForUser(user);

        switch (action) {
            case "addToCart":
                try {
                    int cartId = cart.getCartId(); // Lấy cart_id từ đối tượng Cart

                    // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
                    String checkItemQuery = "SELECT quantity FROM CartItem WHERE cart_id = ? AND product_id = ?";
                    ps = conn.prepareStatement(checkItemQuery);
                    ps.setInt(1, cartId);
                    ps.setInt(2, productId);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        // Nếu sản phẩm đã có trong giỏ hàng, tăng số lượng thêm 1
                        String updateItemQuery = "UPDATE CartItem SET quantity = quantity + 1 WHERE cart_id = ? AND product_id = ?";
                        ps = conn.prepareStatement(updateItemQuery);
                        ps.setInt(1, cartId);
                        ps.setInt(2, productId);
                        ps.executeUpdate();
                    } else {
                        // Nếu sản phẩm chưa có trong giỏ hàng, thêm sản phẩm mới với số lượng là 1
                        String addItemQuery = "INSERT INTO CartItem (cart_id, product_id, quantity) VALUES (?, ?, ?)";
                        ps = conn.prepareStatement(addItemQuery);
                        ps.setInt(1, cartId);
                        ps.setInt(2, productId);
                        ps.setInt(3, 1); // Số lượng ban đầu là 1
                        CartDetail newCartDetail = new CartDetail(getProductById(productId), 1);
                        cart.getCartDetails().add(newCartDetail);
                        ps.executeUpdate();
                    }

                    // Cập nhật chi tiết giỏ hàng sau khi thay đổi
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                break;
            case "removeFromCart":
                try {
                    int cartId = user.getCart().getCartId(); // Lấy cart_id từ đối tượng Cart

                    String deleteItemQuery = "DELETE FROM CartItem WHERE cart_id = ? AND product_id = ?";
                    ps = conn.prepareStatement(deleteItemQuery);
                    ps.setInt(1, cartId);
                    ps.setInt(2, productId);
                    ps.executeUpdate();
                    cart.getCartDetails().removeIf(cartDetail -> cartDetail.getProduct().getId() == productId);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                break;
            case "increase":
                String increaseItemQuery = "UPDATE CartItem SET quantity = quantity + 1 WHERE product_id = ?"; {
                try {
                    ps = conn.prepareStatement(increaseItemQuery);
                    ps.setInt(1, productId);
                    ps.executeUpdate();
                } catch (SQLException ex) {
                    Logger.getLogger(Java_JDBC.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                break;

            case "decrease":
                String decreaseItemQuery = "UPDATE CartItem SET quantity = quantity - 1 WHERE product_id = ?"; {
                try {
                    ps = conn.prepareStatement(decreaseItemQuery);
                    ps.setInt(1, productId);
                    ps.executeUpdate();

                } catch (SQLException ex) {
                    Logger.getLogger(Java_JDBC.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
                break;
            default:
                break;
        }

        return cart;
    }

}
