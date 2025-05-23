/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

public class Comment {
    private int id;            
    private String content;    
    private int point;         
    private int customerId;    
    private int blogId;        
    private int productId;     
    private Date createAt;     

    // Constructor
    public Comment(int id, String content, int point, int customerId, int blogId, int productId, Date createAt) {
        this.id = id;
        this.content = content;
        this.point = point;
        this.customerId = customerId;
        this.blogId = blogId;
        this.productId = productId;
        this.createAt = createAt;
    }

   
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getBlogId() {
        return blogId;
    }

    public void setBlogId(int blogId) {
        this.blogId = blogId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    // Override phương thức toString để dễ dàng kiểm tra đối tượng
    @Override
    public String toString() {
        return "Comment [id=" + id + ", content=" + content + ", point=" + point + ", customerId=" + customerId 
               + ", blogId=" + blogId + ", productId=" + productId + ", createAt=" + createAt + "]";
    }
}
