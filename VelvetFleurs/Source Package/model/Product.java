/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
<<<<<<< HEAD
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Dung
 */



import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;



public class Product implements Serializable {
    private int id;
    private String name;
    private double price;
    private String image;
    private int categoryId;
    private Category category;
    private String description;
    private Date createAt;
    private int quantity;
    
    
    

    private List<ProductRaw> productRaws;
    
    public Product() {
        this.productRaws = new ArrayList<>();
    }
    
    public Product(int id, String name, double price, String image, int categoryId, 
                   String description, Date createAt, int quantity) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.categoryId = categoryId;
        this.description = description;
        this.createAt = createAt;
        this.quantity = quantity;
        this.productRaws = new ArrayList<>();
    }
    
    public Product(int id, String name, double price, String image, Category category, 
                   String description, Date createAt, int quantity) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.image = image;
        this.category = category;
        this.categoryId = category.getId();
        this.description = description;
        this.createAt = createAt;
        this.quantity = quantity;
        this.productRaws = new ArrayList<>();
    }
    
    public int getTotalSold() { return totalSold; }

    private int totalSold;
public void setTotalSold(int totalSold) { this.totalSold = totalSold; }
 
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
    
  
    public double getPrice() {
        return price;
    }
    

    public void setPrice(double price) {
        this.price = price;
    }
    
  
    public String getImage() {
        return image;
    }
    
 
    public void setImage(String image) {
        this.image = image;
    }
    
  
    public int getCategoryId() {
        return categoryId;
    }
    
 
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
  
    public Category getCategory() {
        return category;
    }
    
 
    public void setCategory(Category category) {
        this.category = category;
        if (category != null) {
            this.categoryId = category.getId();
        }
    }
    
   
    public String getDescription() {
        return description;
    }
    
 
    public void setDescription(String description) {
        this.description = description;
    }
    
   
    public Date getCreateAt() {
        return createAt;
    }
    
   
 
    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }
    
  
    public int getQuantity() {
        return quantity;
    }
    
   
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    // Cập nhật cho productRaws
    public List<ProductRaw> getProductRaws() {
        return productRaws;
    }
    
    public void setProductRaws(List<ProductRaw> productRaws) {
        this.productRaws = productRaws;
    }
    
    public void addProductRaw(ProductRaw productRaw) {
        if (this.productRaws == null) {
            this.productRaws = new ArrayList<>();
        }
        this.productRaws.add(productRaw);
    }
    
 
    public List<Raw> getRawMaterials() {
        List<Raw> rawList = new ArrayList<>();
        if (productRaws != null) {
            for (ProductRaw pr : productRaws) {
                if (pr.getRaw() != null) {
                    rawList.add(pr.getRaw());
                }
            }
        }
        return rawList;
    }
    
    
    public boolean hasEnoughRawMaterials() {
        if (productRaws == null || productRaws.isEmpty()) {
            return false;
        }
        
        for (ProductRaw pr : productRaws) {
            Raw raw = pr.getRaw();
            if (raw == null || raw.getQuantity() < pr.getQuantity()) {
                return false;
            }
        }
        
        return true;
    }
    
    // Check ExpiredRaw
    public List<Raw> getExpiredRawMaterials() {
        List<Raw> expiredRaws = new ArrayList<>();
        Date currentDate = new Date();
        
        if (productRaws != null) {
            for (ProductRaw pr : productRaws) {
                Raw raw = pr.getRaw();
                if (raw != null && raw.getExpriseDate() != null && 
                    raw.getExpriseDate().before(currentDate)) {
                    expiredRaws.add(raw);
                }
            }
        }
        
        return expiredRaws;
    }
    
//date of product
public Date getExpiryDate() {
    Date earliest = null;
    for (ProductRaw pr : productRaws) {
        Raw raw = pr.getRaw();
        if (raw != null && raw.getExpriseDate() != null) {
            if (earliest == null || raw.getExpriseDate().before(earliest)) {
                earliest = raw.getExpriseDate();
            }
        }
    }
    return earliest;
}

  
    
    @Override
    public String toString() {
        return "Product{" + "id=" + id + ", name=" + name + ", price=" + price + 
               ", categoryId=" + categoryId + ", description=" + description + 
               ", createAt=" + createAt + ", quantity=" + quantity + '}';
    }

    public void setRawMaterials(List<Raw> rawsByProductId) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void setUpdateAt(Date date) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void setRawQuantities(Map<Raw, Integer> productRawQuantities) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
