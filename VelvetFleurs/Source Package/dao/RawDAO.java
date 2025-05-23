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
import model.Raw;


public class RawDAO {
    
    
    public List<Raw> getAllRaws() {
        List<Raw> list = new ArrayList<>();
        String query = "SELECT * FROM Raw";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Raw raw = new Raw();
                raw.setId(rs.getInt("Id"));
                raw.setName(rs.getString("Name"));
                raw.setQuantity(rs.getInt("quantity"));
                raw.setImage(rs.getString("Image"));
                raw.setExpriseDate(rs.getTimestamp("ExpriseDate"));
                raw.setCreateAt(rs.getTimestamp("CreateAt"));
                
                list.add(raw);
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllRaws: " + e.getMessage());
        }
        
        return list;
    }
    
  
    public Raw getRawById(int id) {
        String query = "SELECT * FROM Raw WHERE Id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Raw raw = new Raw();
                raw.setId(rs.getInt("Id"));
                raw.setName(rs.getString("Name"));
                raw.setQuantity(rs.getInt("quantity"));
                raw.setImage(rs.getString("Image"));
                raw.setExpriseDate(rs.getTimestamp("ExpriseDate"));
                raw.setCreateAt(rs.getTimestamp("CreateAt"));
                
                return raw;
            }
        } catch (SQLException e) {
            System.out.println("Error in getRawById: " + e.getMessage());
        }
        
        return null;
    }
    
 
    public List<Raw> getRawsByProductId(int productId) {
        List<Raw> list = new ArrayList<>();
        String query = "SELECT r.* FROM Raw r " +
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
                raw.setQuantity(rs.getInt("quantity"));
                raw.setImage(rs.getString("Image"));
                raw.setExpriseDate(rs.getTimestamp("ExpriseDate"));
                raw.setCreateAt(rs.getTimestamp("CreateAt"));
                
                list.add(raw);
            }
        } catch (SQLException e) {
            System.out.println("Error in getRawsByProductId: " + e.getMessage());
        }
        
        return list;
    }
  
    public List<Raw> searchRawsByName(String keyword) {
        List<Raw> list = new ArrayList<>();
        String query = "SELECT * FROM Raw WHERE Name LIKE ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Raw raw = new Raw();
                raw.setId(rs.getInt("Id"));
                raw.setName(rs.getString("Name"));
                raw.setQuantity(rs.getInt("quantity"));
                raw.setImage(rs.getString("Image"));
                raw.setExpriseDate(rs.getTimestamp("ExpriseDate"));
                raw.setCreateAt(rs.getTimestamp("CreateAt"));
                
                list.add(raw);
            }
        } catch (SQLException e) {
            System.out.println("Error in searchRawsByName: " + e.getMessage());
        }
        
        return list;
    }
    
   
    public boolean addRaw(Raw raw) {
        String query = "INSERT INTO Raw (Name, quantity, Image, ExpriseDate, CreateAt) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, raw.getName());
            ps.setInt(2, raw.getQuantity());
            ps.setString(3, raw.getImage());
            ps.setTimestamp(4, new java.sql.Timestamp(raw.getExpriseDate().getTime()));
            ps.setTimestamp(5, new java.sql.Timestamp(raw.getCreateAt().getTime()));
            
            int affectedRows = ps.executeUpdate();
            return (affectedRows > 0);
        } catch (SQLException e) {
            System.out.println("Error in addRaw: " + e.getMessage());
            return false;
        }
    }
    
  
    public boolean updateRaw(Raw raw) {
        String query = "UPDATE Raw SET Name = ?, quantity = ?, Image = ?, ExpriseDate = ? WHERE Id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, raw.getName());
            ps.setInt(2, raw.getQuantity());
            ps.setString(3, raw.getImage());
            ps.setTimestamp(4, new java.sql.Timestamp(raw.getExpriseDate().getTime()));
            ps.setInt(5, raw.getId());
            
            int affectedRows = ps.executeUpdate();
            return (affectedRows > 0);
        } catch (SQLException e) {
            System.out.println("Error in updateRaw: " + e.getMessage());
            return false;
        }
    }
    
    
    public boolean deleteRaw(int id) {
        // Xóa các liên kết trong bảng ProductRaw trước
        String deleteProductRawQuery = "DELETE FROM ProductRaw WHERE RawId = ?";
        String deleteRawQuery = "DELETE FROM Raw WHERE Id = ?";
        
        try (Connection conn = DBConnection.getConnection()) {
            // Tắt auto-commit để sử dụng transaction
            conn.setAutoCommit(false);
            
            try (PreparedStatement ps1 = conn.prepareStatement(deleteProductRawQuery)) {
                ps1.setInt(1, id);
                ps1.executeUpdate();
                
                try (PreparedStatement ps2 = conn.prepareStatement(deleteRawQuery)) {
                    ps2.setInt(1, id);
                    int affectedRows = ps2.executeUpdate();
                    
                    if (affectedRows > 0) {
                        conn.commit();
                        return true;
                    } else {
                        conn.rollback();
                        return false;
                    }
                }
            } catch (SQLException e) {
                conn.rollback();
                System.out.println("Error in deleteRaw: " + e.getMessage());
                return false;
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            System.out.println("Error in deleteRaw (connection): " + e.getMessage());
            return false;
        }
    }
    
   
    public boolean addProductRaw(int productId, int rawId) {
        String query = "INSERT INTO ProductRaw (ProductId, RawId) VALUES (?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, productId);
            ps.setInt(2, rawId);
            
            int affectedRows = ps.executeUpdate();
            return (affectedRows > 0);
        } catch (SQLException e) {
            System.out.println("Error in addProductRaw: " + e.getMessage());
            return false;
        }
    }
    
 
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
    
    // Check if a Raw material has sufficient quantity
public boolean hasEnoughQuantity(int rawId, int requiredQuantity) {
    Raw raw = getRawById(rawId);
    return raw != null && raw.getQuantity() >= requiredQuantity;
}

// Check if a Raw material is expired
public boolean isExpired(int rawId) {
    Raw raw = getRawById(rawId);
    if (raw != null && raw.getExpriseDate() != null) {
        return raw.getExpriseDate().before(new java.util.Date());
    }
    return false; // If no expiration date set, assume not expired
}

// Update Raw quantity after use
public boolean updateRawQuantity(int rawId, int usedQuantity) {
    Raw raw = getRawById(rawId);
    if (raw == null || raw.getQuantity() < usedQuantity) {
        return false;
    }
    
    String query = "UPDATE Raw SET quantity = quantity - ? WHERE Id = ?";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        
        ps.setInt(1, usedQuantity);
        ps.setInt(2, rawId);
        
        int affectedRows = ps.executeUpdate();
        return (affectedRows > 0);
    } catch (SQLException e) {
        System.out.println("Error in updateRawQuantity: " + e.getMessage());
        return false;
    }
}

// Get all soon-to-expire Raw materials (within specified days)
public List<Raw> getSoonToExpireRaws(int days) {
    List<Raw> list = new ArrayList<>();
    String query = "SELECT * FROM Raw WHERE ExpriseDate BETWEEN CURRENT_TIMESTAMP AND DATE_ADD(CURRENT_TIMESTAMP, INTERVAL ? DAY)";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        
        ps.setInt(1, days);
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            Raw raw = new Raw();
            raw.setId(rs.getInt("Id"));
            raw.setName(rs.getString("Name"));
            raw.setQuantity(rs.getInt("quantity"));
            raw.setImage(rs.getString("Image"));
            raw.setExpriseDate(rs.getTimestamp("ExpriseDate"));
            raw.setCreateAt(rs.getTimestamp("CreateAt"));
            
            list.add(raw);
        }
    } catch (SQLException e) {
        System.out.println("Error in getSoonToExpireRaws: " + e.getMessage());
    }
    
    return list;
}

// Kiểm tra xem số lượng nguyên liệu có đủ hay không (nếu cần thiết)
// public boolean checkRawAvailability(int productId, int addedQuantity) {
//        String query = "SELECT r.quantity AS raw_quantity " +
//                       "FROM ProductRaw pr " +
//                       "JOIN Raw r ON pr.RawId = r.Id " +
//                       "WHERE pr.ProductId = ?";
//        
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(query)) {
//            
//            ps.setInt(1, productId);
//            
//            try (ResultSet rs = ps.executeQuery()) {
//                while (rs.next()) {
//                    // Số lượng nguyên liệu trong bảng Raw
//                    int rawQuantity = rs.getInt("raw_quantity");
//                    
//                    // Kiểm tra nếu số lượng nguyên liệu có đủ không
//                    if (rawQuantity < addedQuantity) {
//                        return false;  // Không đủ nguyên liệu
//                    }
//                }
//                return true;  // Đủ nguyên liệu
//            }
//        } catch (Exception e) {
//            System.out.println("Error in checkRawAvailability: " + e.getMessage());
//            return false;
//        }
//    }

 
 

    // Phương thức kiểm tra số lượng nguyên liệu và trừ số lượng nếu đủ cho thêm hàng
//    public boolean updateRawQuantity2(int productId, int addedQuantity) {
//        String query = "SELECT pr.RawId, pr.Quantity AS productRawQuantity, r.Quantity AS rawQuantity " +
//                       "FROM ProductRaw pr " +
//                       "JOIN Raw r ON pr.RawId = r.Id " +
//                       "WHERE pr.ProductId = ?";
//        
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(query)) {
//            
//            ps.setInt(1, productId);
//            
//            try (ResultSet rs = ps.executeQuery()) {
//                while (rs.next()) {
//                    int rawQuantity = rs.getInt("rawQuantity");
//                    int productRawQuantity = rs.getInt("productRawQuantity");
//                    
//                    // Kiểm tra số lượng nguyên liệu có đủ không
//                    if (rawQuantity < addedQuantity) {
//                        return false;  // Không đủ nguyên liệu
//                    }
//
//                    // Cập nhật lại số lượng nguyên liệu trong bảng Raw
//                    String updateQuery = "UPDATE Raw SET Quantity = Quantity - ? WHERE Id = ?";
//                    try (PreparedStatement updatePs = conn.prepareStatement(updateQuery)) {
//                        updatePs.setInt(1, addedQuantity);
//                        updatePs.setInt(2, rs.getInt("RawId"));
//                        updatePs.executeUpdate();
//                    }
//                }
//                return true;  // Đủ nguyên liệu, đã trừ
//            }
//        } catch (Exception e) {
//            System.out.println("Error in updateRawQuantity: " + e.getMessage());
//            return false;
//        }
//    }

    
//}

public boolean updateRawQuantity2(int productId, int addedQuantity) {
    String query = "SELECT pr.RawId, pr.Quantity AS productRawQuantity, r.Quantity AS rawQuantity " +
                   "FROM ProductRaw pr " +
                   "JOIN Raw r ON pr.RawId = r.Id " +
                   "WHERE pr.ProductId = ?";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        
        ps.setInt(1, productId);
        
        try (ResultSet rs = ps.executeQuery()) {
            Map<Integer, Integer> rawUsageMap = new HashMap<>();

            while (rs.next()) {
                int rawId = rs.getInt("RawId");
                int rawQuantity = rs.getInt("rawQuantity");
                int productRawQuantity = rs.getInt("productRawQuantity");

                int totalRequiredRaw = productRawQuantity * addedQuantity;

                if (rawQuantity < totalRequiredRaw) {
                    return false; // Không đủ nguyên liệu
                }

                // Lưu lại để update sau
                rawUsageMap.put(rawId, totalRequiredRaw);
            }

            // Nếu đủ hết thì bắt đầu update
            for (Map.Entry<Integer, Integer> entry : rawUsageMap.entrySet()) {
                int rawId = entry.getKey();
                int totalUsed = entry.getValue();

                String updateQuery = "UPDATE Raw SET Quantity = Quantity - ? WHERE Id = ?";
                try (PreparedStatement updatePs = conn.prepareStatement(updateQuery)) {
                    updatePs.setInt(1, totalUsed);
                    updatePs.setInt(2, rawId);
                    updatePs.executeUpdate();
                }
            }

            return true; // Thành công
        }
    } catch (Exception e) {
        System.out.println("Error in updateRawQuantity2: " + e.getMessage());
        return false;
    }
}
}
