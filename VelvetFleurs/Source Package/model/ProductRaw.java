/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.io.Serializable;

public class ProductRaw implements Serializable {
    private int id;
    private int productId;
    private int rawId;
    private int quantity; // Số lượng Raw Materials cần cho 1 Product
    private Product product;
    private Raw raw;

    public ProductRaw() {
    }

    public ProductRaw(int id, int productId, int rawId, int quantity) {
        this.id = id;
        this.productId = productId;
        this.rawId = rawId;
        this.quantity = quantity;
    }

    public ProductRaw(int id, Product product, Raw raw, int quantity) {
        this.id = id;
        this.product = product;
        this.raw = raw;
        this.quantity = quantity;
        this.productId = product.getId();
        this.rawId = raw.getId();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getRawId() {
        return rawId;
    }

    public void setRawId(int rawId) {
        this.rawId = rawId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
        if (product != null) {
            this.productId = product.getId();
        }
    }

    public Raw getRaw() {
        return raw;
    }

    public void setRaw(Raw raw) {
        this.raw = raw;
        if (raw != null) {
            this.rawId = raw.getId();
        }
    }

    @Override
    public String toString() {
        return "ProductRaw{" + "id=" + id + ", productId=" + productId + ", rawId=" + rawId + ", quantity=" + quantity + '}';
    }
}