/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.util.Date;

public class OrderItem {

    private int id;
    private int orderId;
    private int productId;
    private int quantity;
    private Date createAt;
    private double price;
    private String productName;

    private String imageUrl;

public String getImageUrl() {
    return imageUrl;
}



    public OrderItem() {
    }

    public OrderItem(int id, int orderId, int productId, int quantity, Date createAt, double price) {
        this.id = id;
        this.orderId = orderId;
        this.productId = productId;
        this.quantity = quantity;
        this.createAt = createAt;
        this.price = price;
    }
public void setImageUrl(String imageUrl) {
    this.imageUrl = imageUrl;
}
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    // Override phương thức toString để dễ dàng kiểm tra đối tượng
    @Override
    public String toString() {
        return "OrderItem [id=" + id + ", orderId=" + orderId + ", productId=" + productId
                + ", quantity=" + quantity + ", createAt=" + createAt + ", price=" + price + "]";
    }
}
