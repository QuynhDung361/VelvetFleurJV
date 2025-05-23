/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dbConnection.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Account;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Customer;
/**
 *
 * @author trung
 */
public class AccountDAO {

    public void insertAccount(Account acc) {
    String sql = "INSERT INTO Account (username, password, role, status,isCustomer) VALUES (?, ?, ?, ?,0)";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, acc.getUsername());
        ps.setString(2, acc.getPassword()); // Hash nếu cần
        ps.setString(3, acc.getRole());
        ps.setInt(4, acc.getStatus());
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
    public void updateAccountStatus(int accountID, int status) {
    String sql = "UPDATE Account SET status = ? WHERE Id = ?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, status);
        ps.setInt(2, accountID);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
 public List<Account> getAllAccount() {
    List<Account> list = new ArrayList<>();
    String query = "SELECT * FROM Account";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Account account = new Account();
            account.setAccountID(rs.getInt("ID"));
            account.setUsername(rs.getString("username"));
            account.setPassword(rs.getString("password"));
            account.setRole(rs.getString("role"));
            account.setStatus(rs.getInt("status"));
            account.setIsCustomer(rs.getInt("isCustomer"));
            
            list.add(account);
        }
    } catch (SQLException e) {
        System.out.println("Error in getAllAccount: " + e.getMessage());
    }
    
    return list;
}

 public List<Account> getAllAccount1() {
    List<Account> list = new ArrayList<>();
    String query = "SELECT * FROM Account WHERE role = 'Seller'";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Account account = new Account();
            account.setAccountID(rs.getInt("ID"));
            account.setUsername(rs.getString("username"));
            account.setPassword(rs.getString("password"));
            account.setRole(rs.getString("role"));
            account.setStatus(rs.getInt("status"));
            account.setIsCustomer(rs.getInt("isCustomer"));
            
            list.add(account);
        }
    } catch (SQLException e) {
        System.out.println("Error in getAllAccount: " + e.getMessage());
    }
    
    return list;
}  
  public List<Account> getAllAccount2() {
    List<Account> list = new ArrayList<>();
    String query = "SELECT * FROM Account WHERE role = 'Manager'";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Account account = new Account();
            account.setAccountID(rs.getInt("ID"));
            account.setUsername(rs.getString("username"));
            account.setPassword(rs.getString("password"));
            account.setRole(rs.getString("role"));
            account.setStatus(rs.getInt("status"));
            account.setIsCustomer(rs.getInt("isCustomer"));
            
            list.add(account);
        }
    } catch (SQLException e) {
        System.out.println("Error in getAllAccount: " + e.getMessage());
    }
    
    return list;
}
  public boolean registerCustomer(String username, String password, String email, String fullName) {
        String insertAccountSQL = "INSERT INTO Account (Username, Password, Role, Status, isCustomer) VALUES (?, ?, ?, ?,1)";
        String insertCustomerSQL = "INSERT INTO Customer (Email ,FullName ,Avatar ,Account_ID ,Phone,isGuest ) VALUES (?, ?, ?, ?,?,0)";

        try (Connection conn = new DBConnection().getConnection()) {
            conn.setAutoCommit(false);

            // 1. Tạo account
            PreparedStatement psAcc = conn.prepareStatement(insertAccountSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            psAcc.setString(1, username);
            psAcc.setString(2, password); 
            psAcc.setString(3, "CUSTOMER"); 
            psAcc.setInt(4, 1); 
            psAcc.executeUpdate();

            ResultSet rs = psAcc.getGeneratedKeys();
            int accId = -1;
            if (rs.next()) {
                accId = rs.getInt(1);
            } else {
                conn.rollback();
                return false;
            }

            // 2. Tạo customer
            PreparedStatement psCus = conn.prepareStatement(insertCustomerSQL);
            psCus.setString(1, email);
            psCus.setString(2, fullName);
            psCus.setString(3, "default.jpg"); // Avatar mặc định
            psCus.setInt(4, accId);
            psCus.setString(5, username);
            psCus.executeUpdate();

            conn.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
   public boolean isEmailExists( String email) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT COUNT(*) FROM Customer WHERE  email = ? ";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Nếu số lượng > 0 thì user/email đã tồn tại
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

  public Account login(String username, String password) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Account account = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM Account WHERE username = ? AND password = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            rs = stmt.executeQuery();

            if (rs.next()) {
                account = new Account();
                account.setAccountID(rs.getInt("id"));
                account.setUsername(rs.getString("username"));
                account.setStatus(rs.getInt("status"));
                account.setPassword(rs.getString("password"));
                account.setRole(rs.getString("role"));
            }
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }

        return account;
    }
 public boolean isPhoneExists(String username) {
       try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT COUNT(*) FROM Account WHERE  username = ? ";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Nếu số lượng > 0 thì user/email đã tồn tại
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
//public List<Account> getCustomers() {
//    List<Account> list = new ArrayList<>();
//    String sql = "SELECT Account_id, Username, Role, Status FROM Account WHERE Role = 'Customer'";
//
//    try (Connection conn = DBConnection.getConnection();
//         PreparedStatement ps = conn.prepareStatement(sql);
//         ResultSet rs = ps.executeQuery()) {
//
//        while (rs.next()) {
//            Account acc = new Account();
//            acc.setAccountID(rs.getInt("Account_id"));   // đúng với tên trong DB
//            acc.setUsername(rs.getString("Username"));
//            acc.setRole(rs.getString("Role"));
//            acc.setStatus(rs.getInt("Status"));
//            list.add(acc);
//        }
//    } catch (SQLException e) {
//        e.printStackTrace();
//    }
//    return list;
//}

 // Phương thức để cập nhật trạng thái tài khoản
//    public boolean updateAccountStatusCustomer(int accountID, int status) {
//        String query = "UPDATE Account SET Status = ? WHERE AccountId = ?";
//
//        try (Connection conn = DBConnection.getConnection();
//             PreparedStatement ps = conn.prepareStatement(query)) {
//
//            ps.setInt(1, status); // Cập nhật status
//            ps.setInt(2, accountID); // Chọn accountID cần cập nhật
//
//            int result = ps.executeUpdate();
//            return result > 0; // Trả về true nếu cập nhật thành công
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return false; // Trả về false nếu có lỗi
//        }
//    }
    
public List<Account> getCustomers() {
        List<Account> customers = new ArrayList<>();
//        String query = "SELECT c.Id AS CustomerId, a.Username, a.Role, a.Status " +
//                       "FROM Account a " +
//                       "JOIN Customer c ON a.Id = c.Account_id " +
//                       "WHERE a.Role = 'Customer'";
String query = "SELECT c.Id AS CustomerId, a.Username, a.Role, a.Status, " +
               "c.FullName, c.Email, c.Phone, c.Address " +
               "FROM Account a " +
               "JOIN Customer c ON a.Id = c.Account_id " +
               "WHERE a.Role = 'Customer'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Account account = new Account();
                account.setAccountID(rs.getInt("CustomerId"));
                account.setUsername(rs.getString("Username"));
                account.setRole(rs.getString("Role"));
                account.setStatus(rs.getInt("Status"));
                customers.add(account);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return customers;
    }

public Map<Customer, Integer> getCustomersWithStatus() {
    Map<Customer, Integer> customerStatusMap = new LinkedHashMap<>();
    String query = "SELECT c.Id AS CustomerId, c.FullName, c.Email, c.Phone, c.Address, c.Gender, c.Avatar, c.Account_id, " +
                   "a.Status " +
                   "FROM Customer c " +
                   "JOIN Account a ON c.Account_id = a.Id " +
                   "WHERE a.Role = 'Customer'";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(query);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Customer customer = new Customer();
            customer.setId(rs.getInt("CustomerId"));
            customer.setFullName(rs.getString("FullName"));
            customer.setEmail(rs.getString("Email"));
            customer.setPhone(rs.getString("Phone"));
            customer.setAddress(rs.getString("Address"));
            customer.setGender(rs.getString("Gender"));
            customer.setAvatar(rs.getString("Avatar"));
            customer.setAccountId(rs.getInt("Account_id"));

            int status = rs.getInt("Status");
            customerStatusMap.put(customer, status);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return customerStatusMap;
}

 public static void main(String[] args) throws SQLException {
       AccountDAO dao=new AccountDAO();
       HashUtilDAO hash=new HashUtilDAO();
      Account acc =dao.login("0323456789", hash.md5("123abcABC@"));
      System.out.println(acc.getUsername());
      System.out.println("what");}
}
