/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CustomerDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.CartItem;
import model.Customer;
import model.Order;
import model.OrderItem;

/**
 *
 * @author trung
 */
public class CodOrderController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");

        if (cartItems == null || cartItems.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cart is empty");
            return;
        }

        long totalAmount = 0;
        for (CartItem item : cartItems) {
            totalAmount += item.getProduct().getPrice() * item.getQuantity();
        }
        OrderDAO orderDAO = new OrderDAO();
        Customer customer = (Customer) session.getAttribute("customer");

        CustomerDAO dao = new CustomerDAO();
        ProductDAO product = new ProductDAO();
        if (customer == null) {
            customer = new Customer();
            customer.setFullName(request.getParameter("fullname"));
            customer.setAddress(request.getParameter("address"));
            customer.setPhone(request.getParameter("phone"));
            int customerId = dao.insertCustomer(customer);
            customer.setId(customerId);
        } else {
            customer.setFullName(request.getParameter("fullname"));
            customer.setAddress(request.getParameter("address"));
            customer.setPhone(request.getParameter("phone"));
            dao.updateCustomer(customer);
        }
        String note = request.getParameter("note"); // nếu có

        Order order = new Order();
        order.setCustomerId(customer.getId());
        order.setTotalPrice(totalAmount);
        order.setStatus(0); // Chưa thanh toán
        order.setDeliveryStatus("Not Delivered");
        order.setCreateAt(new Date());
        order.setNote(note);

        int orderId = orderDAO.createOrder(order); // lưu và lấy ID
        order.setId(orderId);

// Tạo OrderItems từ cart
        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem item : cartItems) {
            OrderItem orderItem = new OrderItem();
            product.updateQuantity(item.getProduct().getId(), (-1)*item.getQuantity());
            orderItem.setOrderId(orderId);
            orderItem.setProductId(item.getProduct().getId());
            orderItem.setQuantity(item.getQuantity());
            orderItem.setPrice(item.getProduct().getPrice());
            orderItem.setCreateAt(new Date());
            orderItems.add(orderItem);
        }
        orderDAO.createOrderItems(orderItems);

// Xóa giỏ hàng
        session.removeAttribute("cart");

// Lưu orderId để xử lý sau
        session.setAttribute("orderId", orderId);

        // Chuyển đến trang cảm ơn
        response.sendRedirect("view/common/ThankYou.jsp");
    }

}
