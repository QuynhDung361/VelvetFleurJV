/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dbConnection.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
public class CommentDAO {
    public boolean deleteCommentsByProductId(int productId) {
    String query = "DELETE FROM Comment WHERE ProductId = ?";
    try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
        ps.setInt(1, productId);
        return ps.executeUpdate() > 0;
     } catch (SQLException e) {
        System.out.println("Error deleting comments: " + e.getMessage());
        return false;
    }
}

}
