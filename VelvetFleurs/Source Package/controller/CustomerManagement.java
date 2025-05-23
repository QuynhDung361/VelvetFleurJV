//package controller;
//
//import dao.AccountDAO;
//import java.io.IOException;
//import java.util.List;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import model.Account;
//
//@WebServlet(name = "CustomerManagement", urlPatterns = {"/customermanagement"})
//public class CustomerManagement extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        AccountDAO dao = new AccountDAO();
//
//        // Lấy danh sách account có role là "Customer"
//        List<Account> customers = dao.getCustomers();
//
//        // Đưa danh sách lên request scope
//        request.setAttribute("accountList", customers);
//
//        // Forward về trang JSP
//        request.getRequestDispatcher("view/accountmanagement/CustomerManagement.jsp").forward(request, response);
//    }
//@Override
//protected void doPost(HttpServletRequest request, HttpServletResponse response)
//        throws ServletException, IOException {
//    try {
//        int accountID = Integer.parseInt(request.getParameter("accountID"));
//        int newStatus = Integer.parseInt(request.getParameter("status"));
//
//        AccountDAO dao = new AccountDAO();
//        dao.updateAccountStatus(accountID, newStatus);
//
//        // Lấy lại danh sách sau khi cập nhật
//        List<Account> customers = dao.getCustomers();
//        request.setAttribute("accountList", customers);
//
//        // Forward lại trang JSP
//        request.getRequestDispatcher("view/accountmanagement/CustomerManagement.jsp").forward(request, response);
//    } catch (Exception e) {
//        e.printStackTrace(); // In lỗi để kiểm tra trong log
//        request.setAttribute("error", "Cập nhật trạng thái không thành công: " + e.getMessage());
//        request.getRequestDispatcher("view/accountmanagement/CustomerManagement.jsp").forward(request, response);
//    }
//}
//}
package controller;

import dao.CustomerDAO;
import java.io.IOException;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;

@WebServlet(name = "CustomerManagement", urlPatterns = {"/customermanagement"})
public class CustomerManagement extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect("login");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"Seller".equalsIgnoreCase(role) && !"Manager".equalsIgnoreCase(role)) {
            response.sendRedirect("home");
            return;
        }
        CustomerDAO dao = new CustomerDAO();

        // Lấy danh sách Customer và trạng thái Account tương ứng
        Map<Customer, Integer> customerMap = dao.getCustomersWithStatus();

        // Gửi map tới JSP
        request.setAttribute("customerMap", customerMap);

        // Forward tới JSP
        request.getRequestDispatcher("view/accountmanagement/CustomerManagement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int accountID = Integer.parseInt(request.getParameter("accountID"));
            int newStatus = Integer.parseInt(request.getParameter("status"));

            CustomerDAO dao = new CustomerDAO();
            dao.updateAccountStatus(accountID, newStatus);

            // Sau khi cập nhật, lấy lại danh sách
            Map<Customer, Integer> customerMap = dao.getCustomersWithStatus();
            request.setAttribute("customerMap", customerMap);

            request.getRequestDispatcher("view/accountmanagement/CustomerManagement.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // Ghi log lỗi
            request.setAttribute("error", "Cập nhật trạng thái không thành công: " + e.getMessage());
            request.getRequestDispatcher("view/accountmanagement/CustomerManagement.jsp").forward(request, response);
        }
    }
}
