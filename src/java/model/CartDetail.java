package model;

public class CartDetail {
    private static int cartDetailId;
    private Product product; 
    private int quantity;
    private double price;
    
    public CartDetail(Product product, int quantity) {
        ++cartDetailId;
        this.product = product;
        this.quantity = quantity;
    }

    public CartDetail() {
        
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getCartDetailId() {
        return cartDetailId;
    }

}

