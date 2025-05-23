/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dbConnection.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Product;
import model.Raw;

/**
 *
 * @author ADMIN
 */
public class ProductRawDAO {
    // Link a Product with a Raw material and specify the quantity used
    public boolean addProductRaw(int productId, int rawId, int quantityUsed) {
    String query = "INSERT INTO ProductRaw (ProductId, RawId, Quantity) VALUES (?, ?, ?)";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        
        ps.setInt(1, productId);     // gán ProductId
        ps.setInt(2, rawId);          // gán RawId
        ps.setInt(3, quantityUsed);   // gán Quantity
        
        int affectedRows = ps.executeUpdate();
        return (affectedRows > 0);    // nếu thêm được ít nhất 1 dòng, trả về true
        
    } catch (SQLException e) {
        System.out.println("Error in addProductRaw: " + e.getMessage());
            e.printStackTrace();

        return false;
    }
}

    
    // Update the quantity of a Raw material used in a Product
    public boolean updateProductRawQuantity(int productId, int rawId, int quantityUsed) {
        String query = "UPDATE ProductRaw SET QuantityUsed = ? WHERE ProductId = ? AND RawId = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
             ps.setInt(1, quantityUsed);
            ps.setInt(2, productId);
            ps.setInt(3, rawId);
            
            int affectedRows = ps.executeUpdate();
            return (affectedRows > 0);
        } catch (SQLException e) {
            System.out.println("Error in updateProductRawQuantity: " + e.getMessage());
            return false;
        }
    }
    
  // Remove a Raw material from a Product
    public boolean removeProductRaw(int productId, int rawId) {
        String query = "DELETE FROM ProductRaw WHERE ProductId = ? AND RawId = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, productId);
            ps.setInt(2, rawId);
            
            int affectedRows = ps.executeUpdate();
            return (affectedRows > 0);
        } catch (SQLException e) {
            System.out.println("Error in removeProductRaw: " + e.getMessage());
            return false;
        }
    }
    
    // Get all Raw materials used in a Product with their quantities
//    public Map<Raw, Integer> getRawQuantitiesForProduct(int productId) {
//        Map<Raw, Integer> rawQuantities = new HashMap<>();
//        String query = "SELECT r.*, pr.QuantityUsed FROM Raw r " +
//                       "JOIN ProductRaw pr ON r.Id = pr.RawId " +
//                       "WHERE pr.ProductId = ?";
//        
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(query)) {
//            
//            ps.setInt(1, productId);
//            ResultSet rs = ps.executeQuery();
//            
//            while (rs.next()) {
//                Raw raw = new Raw();
//                raw.setId(rs.getInt("Id"));
//                raw.setName(rs.getString("Name"));
//                raw.setQuantity(rs.getInt("quantity"));
//                raw.setImage(rs.getString("Image"));
//                raw.setExpriseDate(rs.getTimestamp("ExpriseDate"));
//                raw.setCreateAt(rs.getTimestamp("CreateAt"));
//                
//                int quantityUsed = rs.getInt("QuantityUsed");
//                rawQuantities.put(raw, quantityUsed);
//            }
//        } catch (SQLException e) {
//            System.out.println("Error in getRawQuantitiesForProduct: " + e.getMessage());
//        }
//        
//        return rawQuantities;
//    }
    public Map<Raw, Integer> getRawQuantitiesForProduct(int productId) {
    Map<Raw, Integer> productRawQuantities = new HashMap<>();
    String query = "SELECT r.Id, r.Name, pr.Quantity " +
                   "FROM Raw r " +
                   "JOIN ProductRaw pr ON r.Id = pr.RawId " +
                   "WHERE pr.ProductId = ?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setInt(1, productId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Raw raw = new Raw();
            raw.setId(rs.getInt("Id"));
            raw.setName(rs.getString("Name"));
            int quantity = rs.getInt("Quantity");
            productRawQuantities.put(raw, quantity);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return productRawQuantities;
}

    // Check if there are enough raw materials to make a certain quantity of a product
    public boolean canMakeProduct(int productId, int productQuantity) {
        Map<Raw, Integer> rawQuantities = getRawQuantitiesForProduct(productId);
        RawDAO rawDAO = new RawDAO();
        
        for (Map.Entry<Raw, Integer> entry : rawQuantities.entrySet()) {
            Raw raw = entry.getKey();
            int quantityNeeded = entry.getValue() * productQuantity;
            
            // Check if there's enough quantity and not expired
            if (!rawDAO.hasEnoughQuantity(raw.getId(), quantityNeeded) || 
                rawDAO.isExpired(raw.getId())) {
                return false;
            }
        }
        
        return true;
    }
    
    // Calculate the maximum number of products that can be made with available raw materials
    public int getMaxProductQuantityPossible(int productId) {
        Map<Raw, Integer> rawQuantities = getRawQuantitiesForProduct(productId);
        RawDAO rawDAO = new RawDAO();
        int maxQuantity = Integer.MAX_VALUE;
        
        for (Map.Entry<Raw, Integer> entry : rawQuantities.entrySet()) {
            Raw raw = entry.getKey();
            int quantityPerProduct = entry.getValue();
            
            // Skip expired raw materials
            if (rawDAO.isExpired(raw.getId())) {
                return 0; // Can't make any if a raw material is expired
            }
            
            // Get the actual raw material with current quantity
            Raw currentRaw = rawDAO.getRawById(raw.getId());
            if (currentRaw != null && quantityPerProduct > 0) {
                int possibleQuantity = currentRaw.getQuantity() / quantityPerProduct;
                maxQuantity = Math.min(maxQuantity, possibleQuantity);
            }
        }
        
        return maxQuantity == Integer.MAX_VALUE ? 0 : maxQuantity;
    }
    
    // Process production - reduce raw materials when making products
    public boolean processProduction(int productId, int productQuantity) {
        // First check if we can make this many products
        if (!canMakeProduct(productId, productQuantity)) {
            return false;
        }
        
        Connection conn = null;
        boolean success = false;
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction
            
            Map<Raw, Integer> rawQuantities = getRawQuantitiesForProduct(productId);
            RawDAO rawDAO = new RawDAO();
            
            // Reduce each raw material
            for (Map.Entry<Raw, Integer> entry : rawQuantities.entrySet()) {
                Raw raw = entry.getKey();
                int quantityToUse = entry.getValue() * productQuantity;
                
                // Update raw material quantity
                String updateQuery = "UPDATE Raw SET quantity = quantity - ? WHERE Id = ?";
                try (PreparedStatement ps = conn.prepareStatement(updateQuery)) {
                    ps.setInt(1, quantityToUse);
                    ps.setInt(2, raw.getId());
                    ps.executeUpdate();
                }
            }
            
            // Increase product quantity if needed
            String updateProductQuery = "UPDATE Product SET Quantity = Quantity + ? WHERE Id = ?";
            try (PreparedStatement ps = conn.prepareStatement(updateProductQuery)) {
                ps.setInt(1, productQuantity);
                ps.setInt(2, productId);
                ps.executeUpdate();
            }
            
            conn.commit(); // Commit transaction
            success = true;
        } catch (SQLException e) {
            System.out.println("Error in processProduction: " + e.getMessage());
            try {
                if (conn != null) {
                    conn.rollback(); // Rollback on error
                }
            } catch (SQLException rollbackEx) {
                System.out.println("Error during rollback: " + rollbackEx.getMessage());
            }
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException closeEx) {
                System.out.println("Error closing connection: " + closeEx.getMessage());
            }
        }
        
        return success;
    }

    public boolean updateProductRaw(int productId, int rawId, int rawQuantityPerProduct) {
    Connection conn = null;
    PreparedStatement stmt = null;
    String sql = "UPDATE product_raw SET quantity_per_product = ? WHERE product_id = ? AND raw_id = ?";

    try {
        conn = DBConnection.getConnection(); // Assuming you have a method to get DB connection
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, rawQuantityPerProduct);
        stmt.setInt(2, productId);
        stmt.setInt(3, rawId);

        int rowsUpdated = stmt.executeUpdate();
        return rowsUpdated > 0; // If at least one row was updated, return true
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

}
