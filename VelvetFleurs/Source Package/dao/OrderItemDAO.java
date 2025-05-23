/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dbConnection.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.ResultSet;

import java.util.List;
import model.OrderItem;

/**
 *
 * @author Admin
 */
public class OrderItemDAO {
      // Lấy danh sách OrderItem theo OrderId
//    public List<OrderItem> getOrderItemsByOrderId(int orderId) throws SQLException {
//        List<OrderItem> orderItems = new ArrayList<>();
//        String query = "SELECT * FROM OrderItem WHERE OrderId = ?";
//        
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(query)) {
//            
//            ps.setInt(1, orderId);
//        ResultSet rs = ps.executeQuery();
//            
//            while (rs.next()) {
//                OrderItem item = new OrderItem();
//                item.setId(rs.getInt("Id"));
//                item.setOrderId(rs.getInt("OrderId"));
//                item.setProductId(rs.getInt("ProductId"));
//                item.setQuantity(rs.getInt("Quantity"));
//                item.setCreateAt(rs.getDate("CreateAt"));
//                item.setPrice(rs.getDouble("Price"));
//                 orderItems.add(item);
//        }
//    } catch (SQLException e) {
//        System.out.println("Error fetching order items: " + e.getMessage());
//        throw e; // Re-throw the exception if necessary
//    }
//        
//        return orderItems;
//    }
public List<OrderItem> getOrderItemsByOrderId(int orderId) throws SQLException {
    List<OrderItem> orderItems = new ArrayList<>();
    String query = "SELECT oi.*, p.Name AS ProductName " +
                   "FROM OrderItem oi " +
                   "JOIN Product p ON oi.ProductId = p.Id " +
                   "WHERE oi.OrderId = ?";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {

        ps.setInt(1, orderId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            OrderItem item = new OrderItem();
            item.setId(rs.getInt("Id"));
            item.setOrderId(rs.getInt("OrderId"));
            item.setProductId(rs.getInt("ProductId"));
            item.setQuantity(rs.getInt("Quantity"));
            item.setCreateAt(rs.getDate("CreateAt"));
            item.setPrice(rs.getDouble("Price"));
            item.setProductName(rs.getString("ProductName")); // Gán tên sản phẩm

            orderItems.add(item);
        }
    } catch (SQLException e) {
        System.out.println("Error fetching order items: " + e.getMessage());
        throw e;
    }

    return orderItems;
}

public List<OrderItem> getOrderItemsByOrderId1(int orderId) {
    List<OrderItem> items = new ArrayList<>();
    String sql = "SELECT oi.Id, p.Name, oi.Quantity, oi.Price, oi.CreateAt, p.Image " +
                 "FROM OrderItem oi " +
                 "JOIN Product p ON oi.ProductId = p.Id " +
                 "WHERE oi.OrderId = ?";

    try (Connection conn =  DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, orderId);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setId(rs.getInt("Id"));
                item.setProductName(rs.getString("Name"));  // từ bảng Product
                item.setQuantity(rs.getInt("Quantity"));
                item.setPrice(rs.getDouble("Price"));
                item.setCreateAt(rs.getTimestamp("CreateAt"));
                item.setImageUrl(rs.getString("Image")); // mới thêm

                items.add(item);
            }
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return items;
}

    public boolean deleteOrderItemsByProductId(int productId) {
    String query = "DELETE FROM OrderItem WHERE ProductId = ?";
    try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

        ps.setInt(1, productId);
        int rowsDeleted = ps.executeUpdate();
        System.out.println("Order items deleted: " + rowsDeleted);
        return rowsDeleted > 0;

    } catch (SQLException e) {
        System.out.println("Error deleting order items: " + e.getMessage());
        return false;
    }
}

  

}
