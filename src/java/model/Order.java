package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Order {

    private int orderId;
    private User user;
    private Date orderDate;
    private double totalAmount;
    private String status;
    private String shippingAddress;
    private String receiver;
    private String receiverPhoneNumber;
    private List<OrderItem> orderItems;
    // Mỗi đơn hàng có nhiều sản phẩm, và OrderItem ghi lại chi tiết cho từng sản phẩm trong đơn hàng
    
    public Order(int orderId, User user, Date orderDate, double totalAmount, String status, String shippingAddress, String receiver, String receiverPhoneNumber) {
        this.orderId = orderId;
        this.user = user;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.status = status;
        this.shippingAddress = shippingAddress;
        this.orderItems = new ArrayList<>();
        this.receiver = receiver;
        this.receiverPhoneNumber = receiverPhoneNumber;
    }
    
    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }
    
    
}
