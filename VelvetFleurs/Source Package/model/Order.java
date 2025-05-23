///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */

package model;

import java.util.Date;

public class Order {
    private int id;
    private double totalPrice;
    private int status;           
    private Date createAt;
    private int customerId;
    private String deliveryStatus;
    private String note;
    
    private boolean paid;

    // Constructors
    public Order() {
    }

    public Order(int id, double totalPrice, int status, Date createAt, int customerId, String deliveryStatus, String note) {
        this.id = id;
        this.totalPrice = totalPrice;
        this.status = status;
        this.createAt = createAt;
        this.customerId = customerId;
        this.deliveryStatus = deliveryStatus;
        this.note = note;
    }
    
    

    // Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
        this.paid = (status == 1);
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getDeliveryStatus() {
        return deliveryStatus;
    }

    public void setDeliveryStatus(String deliveryStatus) {
        this.deliveryStatus = deliveryStatus;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
     public boolean isPaid() {
        return status == 1;
    }
}
