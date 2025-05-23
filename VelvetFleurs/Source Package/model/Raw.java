/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
import java.io.Serializable;
import java.util.Date;

public class Raw implements Serializable {

    private int id;
    private String name;
    private int quantity;
    private String image;
    private Date expriseDate;
    private Date createAt;

    public Raw() {
    }

    public Raw(int id, String name, int quantity, String image, Date expriseDate, Date createAt) {
        this.id = id;
        this.name = name;
        this.quantity = quantity;
        this.image = image;
        this.expriseDate = expriseDate;
        this.createAt = createAt;
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

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getExpriseDate() {
        return expriseDate;
    }

    public void setExpriseDate(Date expriseDate) {
        this.expriseDate = expriseDate;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    @Override
    public String toString() {
        return "Raw{" + "id=" + id + ", name=" + name + ", quantity=" + quantity
                + ", expriseDate=" + expriseDate + ", createAt=" + createAt + '}';
    } 
}
