package model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private int cartId;
    private User user;
    private List<CartDetail> cartDetails;

    public Cart(int cartId, User user) {
        this.cartId = cartId;
        this.user = user;
        this.cartDetails = new ArrayList<>();
    }

    public Cart() {
        
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<CartDetail> getCartDetails() {
        return cartDetails;
    }

    public void setCartDetails(List<CartDetail> cartDetails) {
        this.cartDetails = cartDetails;
    }
    
    public void addProduct(Product product, int quantity) {
        // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
        for (CartDetail cartDetail : cartDetails) {
            if (cartDetail.getProduct().getId() == product.getId()) {
                // Nếu có, chỉ cần cập nhật số lượng
                cartDetail.setQuantity(cartDetail.getQuantity() + quantity);
                return;
            }
        }
        
        // Nếu không có, thêm sản phẩm mới
        CartDetail newCartDetail = new CartDetail();
        newCartDetail.setProduct(product);
        newCartDetail.setQuantity(quantity);
        cartDetails.add(newCartDetail);
    }

    public void removeCartDetail(Product product) {
        cartDetails.removeIf(cartDetail -> cartDetail.getProduct().equals(product));
    }
}
