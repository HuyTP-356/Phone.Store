package model;

import java.time.Instant;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class User {

    private int userId;
    private String username;
    private String email;
    private String passwordHash;
    private String fullName;
    private String phoneNumber;
    private Date createdAt;
    
    // Relationship
    private Role role; // Một người dùng chỉ có 1 vai trò
    private List<Order> orders; // Một người dùng có nhiều đơn đặt hàng
    private Cart cart; // Mỗi người dùng chỉ có 1 giỏ hàng

    // Constructor
    public User(int userId, String username, String email, String passwordHash, String fullName,
            String phoneNumber) {
        this.userId = userId;
        this.username = username;
        this.email = email;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.createdAt = Date.from(Instant.now());
        this.orders = new ArrayList<>();
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public Date getCreatedAt() {
        return createdAt;
    }
    
    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    // toString method for debugging
    @Override
    public String toString() {
        return "User{"
                + "userId=" + userId
                + ", username='" + username + '\''
                + ", email='" + email + '\''
                + ", fullName='" + fullName + '\''
                + ", role=" + role.getName() + '\''
                + ", createdAt=" + createdAt
                + '}';
    }
}
