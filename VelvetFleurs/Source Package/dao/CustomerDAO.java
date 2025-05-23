package dao;

import dbConnection.DBConnection;
import java.sql.*;
import java.util.*;
import model.Customer;

public class CustomerDAO {

    public List<Customer> getAllCustomers() {
        List<Customer> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM Customer";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Customer c = new Customer();
                c.setId(rs.getInt("Id"));
                c.setFullName(rs.getString("FullName"));
                c.setEmail(rs.getString("Email"));
                c.setPhone(rs.getString("Phone"));
                c.setAddress(rs.getString("Address"));
                c.setGender(rs.getString("Gender"));
                c.setAvatar(rs.getString("Avatar"));
                c.setAccountId(rs.getInt("Account_id"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Customer getCustomerByAccountId(int accountId) {
        String sql = "SELECT * FROM Customer WHERE Account_id=?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Customer c = new Customer();
                c.setId(rs.getInt("Id"));
                c.setFullName(rs.getString("FullName"));
                c.setEmail(rs.getString("Email"));
                c.setPhone(rs.getString("Phone"));
                c.setAddress(rs.getString("Address"));
                c.setGender(rs.getString("Gender"));
                c.setAvatar(rs.getString("Avatar"));
                c.setAccountId(accountId);
                return c;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
public boolean updateCustomer(Customer c) {
    String sql = "UPDATE Customer SET FullName = ?, Email = ?, Phone = ?, Address = ?, Gender = ?, Avatar = ? WHERE Id = ?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, c.getFullName());
        ps.setString(2, c.getEmail());
        ps.setString(3, c.getPhone());
        ps.setString(4, c.getAddress());
        ps.setString(5, c.getGender());
        ps.setString(6, c.getAvatar());
        ps.setInt(7, c.getId());

        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
//
//    public boolean updateCustomer(Customer customer) {
//    String sql = "UPDATE Customer SET FullName=?, Email=?, Phone=?, Address=?, Gender=?, Avatar=? WHERE Id=?";
//    try (Connection conn = DBConnection.getConnection();
//         PreparedStatement ps = conn.prepareStatement(sql)) {
//
//        ps.setString(1, customer.getFullName());
//        ps.setString(2, customer.getEmail());
//        ps.setString(3, customer.getPhone());
//        ps.setString(4, customer.getAddress());
//        ps.setString(5, customer.getGender());
//        ps.setString(6, customer.getAvatar());
//        ps.setInt(7, customer.getId());
//
//        return ps.executeUpdate() > 0;
//
//    } catch (Exception e) {
//        e.printStackTrace();
//    }
//    return false;
//}


    public int insertCustomer(Customer customer) {
        String sql = "INSERT INTO Customer (FullName, Phone, Address, isGuest) VALUES (?, ?, ?, 1)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, customer.getFullName());
            stmt.setString(2, customer.getPhone());
            stmt.setString(3, customer.getAddress());
            int rows = stmt.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        int generatedId = rs.getInt(1);
                        customer.setId(generatedId); // Set lại ID cho customer
                        return generatedId;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public Customer getCustomerByOrderId(int orderId) throws SQLException {
        Customer customer = null;

        String sql = "SELECT c.Id AS CustomerId, c.FullName, c.Phone, c.Address "
                + "FROM [Order] o "
                + "JOIN Customer c ON o.CustomerId = c.Id "
                + "WHERE o.Id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                customer = new Customer();
                customer.setCustomerId(rs.getInt("CustomerId"));
                customer.setFullName(rs.getString("FullName"));
                customer.setPhone(rs.getString("Phone"));
                customer.setAddress(rs.getString("Address"));
            }
        }

        return customer;
    }

    public Customer getCustomerById(int id) {
        Customer customer = null;
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(
                "SELECT FullName, Phone, Address FROM Customer WHERE Id = ?")) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                customer = new Customer();
                customer.setFullName(rs.getString("FullName"));
                customer.setPhone(rs.getString("Phone"));
                customer.setAddress(rs.getString("Address"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customer;
    }

    public Map<Customer, Integer> getCustomersWithStatus() {
        Map<Customer, Integer> customerStatusMap = new LinkedHashMap<>();
        String query = "SELECT c.Id AS CustomerId, c.FullName, c.Email, c.Phone, c.Address, c.Gender, c.Avatar, c.Account_id, "
                + "a.Status "
                + "FROM Customer c "
                + "JOIN Account a ON c.Account_id = a.Id "
                + "WHERE a.Role = 'Customer'";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {

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

    public void updateAccountStatus(int accountId, int newStatus) {
        String query = "UPDATE Account SET Status = ? WHERE Id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, newStatus);
            ps.setInt(2, accountId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Integer> getTotalCustomers() {
        List<Integer> result = new ArrayList<>();
        String sql = "SELECT COUNT(*) FROM Customer";

        try (Connection conn = new DBConnection().getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                result.add(rs.getInt(1)); // Add the total count of customers to the result list
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    public void updateCustomer(String fullName, String email, String phone, String address, String gender, int accountId) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    public static void main(String[] args) throws SQLException {
        CustomerDAO dao = new CustomerDAO();
        Customer customer = new Customer();
        customer.setFullName("fullname");
        customer.setAddress("address");
        customer.setPhone("0352701270");
        dao.insertCustomer(customer);
    }
    
}
