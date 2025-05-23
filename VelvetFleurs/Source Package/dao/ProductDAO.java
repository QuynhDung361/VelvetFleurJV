/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license

 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dbConnection.DBConnection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import model.Category;
import model.Product;
import model.Raw;
import java.sql.*;

/**
 *
 * @author ADMIN
 */
public class ProductDAO {

    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Product";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("Id"));
                product.setName(rs.getString("Name"));
                product.setPrice(rs.getDouble("Price"));
                product.setImage(rs.getString("Image"));
                product.setCategoryId(rs.getInt("CategoryId"));
                product.setDescription(rs.getString("Description"));
                product.setCreateAt(rs.getDate("CreateAt"));
                product.setQuantity(rs.getInt("Quantity"));
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> getProductsByCategoryId(int categoryId) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Product WHERE CategoryId = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("Id"));
                product.setName(rs.getString("Name"));
                product.setPrice(rs.getDouble("Price"));
                product.setImage(rs.getString("Image"));
                product.setCategoryId(rs.getInt("CategoryId"));
                product.setDescription(rs.getString("Description"));
                product.setCreateAt(rs.getDate("CreateAt"));
                product.setQuantity(rs.getInt("Quantity"));
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

//    public Product getProductById(int id) {
//        String query = "SELECT * FROM Product WHERE Id = ?";
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(query)) {
//            ps.setInt(1, id);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                Product product = new Product();
//                product.setId(rs.getInt("Id"));
//                product.setName(rs.getString("Name"));
//                product.setPrice(rs.getDouble("Price"));
//                product.setImage(rs.getString("Image"));
//                product.setCategoryId(rs.getInt("CategoryId"));
//                product.setDescription(rs.getString("Description"));
//                product.setCreateAt(rs.getDate("CreateAt"));
//                product.setQuantity(rs.getInt("Quantity"));
//                
//                RawDAO rawDAO = new RawDAO();
//                product.setRawMaterials(rawDAO.getRawsByProductId(id));
//                
//                return product;
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
    public Product getProductById(int id) {
        String query = "SELECT * FROM Product WHERE Id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("Id"));
                product.setName(rs.getString("Name"));
                product.setPrice(rs.getDouble("Price"));
                product.setImage(rs.getString("Image"));
                product.setCategoryId(rs.getInt("CategoryId"));
                product.setDescription(rs.getString("Description"));
                product.setCreateAt(rs.getDate("CreateAt"));
                product.setQuantity(rs.getInt("Quantity"));

                // Lấy thông tin nguyên liệu thô và số lượng từ ProductRaw
                ProductRawDAO productRawDAO = new ProductRawDAO();
                Map<Raw, Integer> productRawQuantities = productRawDAO.getRawQuantitiesForProduct(id);
                product.setRawQuantities(productRawQuantities); // Giả sử bạn đã có phương thức để set nguyên liệu thô cho sản phẩm

                return product;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public Product getProductById2(int id) {
        String query = "SELECT * FROM Product WHERE Id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("Id"));
                product.setName(rs.getString("Name"));
                product.setPrice(rs.getDouble("Price"));
                product.setImage(rs.getString("Image"));
                product.setCategoryId(rs.getInt("CategoryId"));
                product.setDescription(rs.getString("Description"));
                product.setCreateAt(rs.getDate("CreateAt"));
                product.setQuantity(rs.getInt("Quantity"));
                return product;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<Product> getFeaturedProducts(int limit) {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM Product ORDER BY Id DESC LIMIT ?"; // Lấy sản phẩm mới nhất
        // Hoặc có thể dùng: "SELECT * FROM Product WHERE Featured = 1 LIMIT ?" nếu có trường Featured

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("Id"));
                product.setName(rs.getString("Name"));
                product.setPrice(rs.getDouble("Price"));
                product.setImage(rs.getString("Image"));
                product.setCategoryId(rs.getInt("CategoryId"));
                product.setQuantity(rs.getInt("Quantity"));
                product.setDescription(rs.getString("Description"));
                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> searchProductsByName(String keyword) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Product WHERE Name LIKE ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("Id"));
                product.setName(rs.getString("Name"));
                product.setPrice(rs.getDouble("Price"));
                product.setImage(rs.getString("Image"));
                product.setCategoryId(rs.getInt("CategoryId"));
                product.setDescription(rs.getString("Description"));
                product.setCreateAt(rs.getDate("CreateAt"));
                product.setQuantity(rs.getInt("Quantity"));
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Add a new Product
    public boolean addProduct(Product product) {
        String query = "INSERT INTO Product (Name, Price, Image, CategoryId, Description, CreateAt, Quantity) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setString(3, product.getImage());
            ps.setInt(4, product.getCategoryId());
            ps.setString(5, product.getDescription());
            ps.setDate(6, new java.sql.Date(product.getCreateAt().getTime()));
            ps.setInt(7, product.getQuantity());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                // Get the generated product ID for potential use with raw materials
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        product.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        } catch (Exception e) {
            System.out.println("Error in addProduct: " + e.getMessage());
            return false;
        }
    }

// Update an existing Product
    public boolean updateProduct(Product product) {
        String query = "UPDATE Product SET Name = ?, Price = ?, Image = ?, CategoryId = ?, Description = ?, Quantity = ? WHERE Id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, product.getName());
            ps.setDouble(2, product.getPrice());
            ps.setString(3, product.getImage());
            ps.setInt(4, product.getCategoryId());
            ps.setString(5, product.getDescription());
            ps.setInt(6, product.getQuantity());
            ps.setInt(7, product.getId());

            int affectedRows = ps.executeUpdate();
            return (affectedRows > 0);
        } catch (Exception e) {
            System.out.println("Error in updateProduct: " + e.getMessage());
            return false;
        }
    }

//  public boolean updateQuantity(int productId, int addedQuantity) {
//    String query = "UPDATE Product SET Quantity = Quantity + ? WHERE Id = ?";
//    
//    try (Connection conn = DBConnection.getConnection();
//         PreparedStatement ps = conn.prepareStatement(query)) {
//        
//        ps.setInt(1, addedQuantity);
//        ps.setInt(2, productId);
//        
//        int affectedRows = ps.executeUpdate();
//        return (affectedRows > 0);
//    } catch (Exception e) {
//        System.out.println("Error in updateQuantity: " + e.getMessage());
//        return false;
//    }
//}
    public boolean updateQuantity(int productId, int addedQuantity) {
        String query = "UPDATE Product SET Quantity = Quantity + ? WHERE Id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, addedQuantity);  // Thêm số lượng vào
            ps.setInt(2, productId);      // ID sản phẩm cần cập nhật

            int affectedRows = ps.executeUpdate();
            return (affectedRows > 0);  // Nếu có ảnh hưởng dòng dữ liệu thì thành công
        } catch (Exception e) {
            System.out.println("Error in updateQuantity: " + e.getMessage());
            return false;
        }
    }

//Delete Product
    public boolean deleteProduct(int productId) {
        String deleteProductRawQuery = "DELETE FROM ProductRaw WHERE ProductId = ?";
        String deleteProductQuery = "DELETE FROM product WHERE id = ?";

        try (Connection conn = DBConnection.getConnection()) {
            // Tắt auto-commit để thực hiện transaction
            conn.setAutoCommit(false);

            try (PreparedStatement ps1 = conn.prepareStatement(deleteProductRawQuery); PreparedStatement ps2 = conn.prepareStatement(deleteProductQuery)) {

                // Xóa từ bảng productRaw trước
                ps1.setInt(1, productId);
                ps1.executeUpdate();

                // Sau đó xóa từ bảng product
                ps2.setInt(1, productId);
                int rowsAffected = ps2.executeUpdate();

                // Nếu xóa thành công ở bảng product, thì commit
                if (rowsAffected > 0) {
                    conn.commit();
                    return true;
                } else {
                    conn.rollback();
                    return false;
                }
            } catch (Exception e) {
                conn.rollback(); // Nếu có lỗi thì rollback
                e.printStackTrace();
                return false;
            } finally {
                conn.setAutoCommit(true); // Khôi phục trạng thái ban đầu
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getGeneratedProductId() {
        String query = "SELECT SCOPE_IDENTITY()"; // Dành cho SQL Server để lấy ID cuối cùng được chèn
        int lastInsertedId = -1; // Khởi tạo giá trị mặc định nếu không tìm thấy ID
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                lastInsertedId = rs.getInt(1);  // Lấy giá trị của ID mới được chèn
                System.out.println("Last inserted ID: " + lastInsertedId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return lastInsertedId; // Trả về ID của sản phẩm vừa được chèn
    }

    public List<Product> getAllProducts(int offset, int limit) throws SQLException {
        List<Product> products = new ArrayList<>();

        // Updated SQL query with OFFSET-FETCH
        String sql = "SELECT p.*, c.name as category_name "
                + "FROM product p "
                + "JOIN category c ON p.categoryId = c.id "
                + "ORDER BY p.id "
                + // It's important to have an ORDER BY clause when using OFFSET-FETCH
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = DBConnection.prepareStatement(sql)) {
            stmt.setInt(1, offset);  // Skip the first 'offset' rows
            stmt.setInt(2, limit);   // Limit to 'limit' rows

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = mapResultSetToProduct(rs);
                products.add(product);
            }
        }

        return products;
    }

    // Đếm tổng số sản phẩm
    public int countAllProducts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM product";
        try (PreparedStatement stmt = DBConnection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Tìm kiếm sản phẩm
    public List<Product> searchProducts(String searchTerm, int offset, int limit) throws SQLException {
        List<Product> products = new ArrayList<>();

        // Updated SQL query using OFFSET-FETCH for SQL Server
        String sql = "SELECT p.*, c.name as category_name "
                + "FROM product p "
                + "JOIN category c ON p.categoryId = c.id "
                + "WHERE p.name LIKE ? OR p.description LIKE ? "
                + "ORDER BY p.id "
                + // Ensure you have an ORDER BY clause when using OFFSET-FETCH
                "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = DBConnection.prepareStatement(sql)) {
            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setInt(3, offset);  // Skip the first 'offset' rows
            stmt.setInt(4, limit);   // Limit to 'limit' rows

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = mapResultSetToProduct(rs);
                products.add(product);
            }
        }

        return products;
    }

    // Đếm kết quả tìm kiếm
    public int countSearchResults(String searchTerm) throws SQLException {
        String sql = "SELECT COUNT(*) FROM product WHERE name LIKE ? OR description LIKE ?";
        try (PreparedStatement stmt = DBConnection.prepareStatement(sql)) {
            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Lọc theo category
    public List<Product> getProductsByCategory(int categoryId, int offset, int limit) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.name as category_name FROM product p "
                + "JOIN category c ON p.categoryId = c.id "
                + "WHERE p.categoryId = ? "
                + "ORDER BY p.id " // Ensure you have an ORDER BY clause
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = DBConnection.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            stmt.setInt(2, offset);
            stmt.setInt(3, limit);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = mapResultSetToProduct(rs);
                products.add(product);
            }
        }
        return products;
    }

    // Đếm sản phẩm theo category
    public int countProductsByCategory(int categoryId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM product WHERE categoryId = ?";
        try (PreparedStatement stmt = DBConnection.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Phương thức hỗ trợ chuyển ResultSet thành đối tượng Product
    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setPrice(rs.getDouble("price"));
        product.setImage(rs.getString("image"));
        product.setDescription(rs.getString("description"));
        product.setCreateAt(rs.getTimestamp("createAt"));
        product.setQuantity(rs.getInt("quantity"));

        // Thông tin category
        Category category = new Category();
        category.setId(rs.getInt("categoryId"));
        category.setName(rs.getString("category_name"));
        product.setCategory(category);

        return product;
    }

    public List<Integer> getTotalProduct() {
    List<Integer> result = new ArrayList<>();
    String sql = "SELECT COUNT(*) FROM Product";

    try (Connection conn = new DBConnection().getConnection(); 
         PreparedStatement stmt = conn.prepareStatement(sql); 
         ResultSet rs = stmt.executeQuery()) {

        if (rs.next()) {
            result.add(rs.getInt(1)); // Add the total count of flowers to the result list
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return result;
}
    
    
public List<Product> getBestSellingProducts(int limit) {
    List<Product> list = new ArrayList<>();
    String sql = "SELECT TOP (?) p.Id, p.Name, p.Price, p.Image, SUM(oi.Quantity) AS totalSold " +
                 "FROM Product p " +
                 "JOIN OrderItem oi ON p.Id = oi.ProductId " +
                 "JOIN [Order] o ON o.Id = oi.OrderId " +
                 "WHERE o.deliveryStatus = 'Delivered' " +
                 "GROUP BY p.Id, p.Name, p.Price, p.Image " +
                 "ORDER BY totalSold DESC";

    try (Connection conn = new DBConnection().getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, limit);
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("Id"));
                p.setName(rs.getString("Name"));
                p.setPrice(rs.getDouble("Price"));
                p.setImage(rs.getString("Image"));
                p.setTotalSold(rs.getInt("totalSold"));
                list.add(p);
            }
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return list;
}


    public static void main(String[] args) throws SQLException {
        ProductDAO dao = new ProductDAO();
        dao.updateQuantity(1, -2);
    }
    
}
