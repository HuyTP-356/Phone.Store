package model;

public class Product {
    private int id;
    private String name;
    private String brand;
    private double price;
    private String description;
    private String imageUrl;
    private int stockQuantity; 
    // Constructor

    public Product(String name, String brand, double price, String description, String imageUrl,
            int stockQuantity) {
        this.name = name;
        this.brand = brand;
        this.price = price;
        this.description = description;
        this.imageUrl = imageUrl;
        this.stockQuantity = stockQuantity;
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

    // Default constructor (optional, if needed)
    public Product() {
    }

    // Getters and Setters
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
        return stockQuantity; // Getter for stockQuantity
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity; // Setter for stockQuantity
    }
}
