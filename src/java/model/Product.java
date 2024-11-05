package model;

import java.util.ArrayList;
import java.util.List;

public class Product {
    private int id;
    private String name;
    private String brand;
    private double price;
    private String description;
    private String imageUrl;
    private int stockQuantity; 
    
    // Relationship
    private List<OrderItem> orderItems; // Một sản phẩm có thể có trong nhiều đơn hàng
    private List<Cart> carts; // Một sản phẩm có thể nằm trong nhiều giỏ hàng, và một giỏ hàng có thể có nhiều sản phẩm

    public Product(String name, String brand, double price, String description, String imageUrl,
            int stockQuantity) {
        this.name = name;
        this.brand = brand;
        this.price = price;
        this.description = description;
        this.imageUrl = imageUrl;
        this.stockQuantity = stockQuantity;
        this.orderItems = new ArrayList<>();
        this.carts = new ArrayList<>();
    }
    
    public Product(int id, String name, String brand, double price, String description, String imageUrl,
            int stockQuantity) {
        this.id = id;
        this.name = name;
        this.brand = brand;
        this.price = price;
        this.description = description;
        this.imageUrl = imageUrl;
        this.stockQuantity = stockQuantity;
    }

    public Product() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }
    
    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    public List<Cart> getCarts() {
        return carts;
    }

    public void setCarts(List<Cart> carts) {
        this.carts = carts;
    }
}
