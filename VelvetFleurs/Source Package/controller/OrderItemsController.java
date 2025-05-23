/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CustomerDAO;
import dao.OrderItemDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import static java.lang.System.out;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;
import model.OrderItem;

/**
 *
 * @author sunny
 */
@WebServlet(name = "OrderItemsController", urlPatterns = {"/OrderItems"})
public class OrderItemsController extends HttpServlet {

 
    @Override


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdParam = request.getParameter("orderId");

        if (orderIdParam == null || orderIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing orderId parameter.");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdParam);

            OrderItemDAO orderitemdao = new OrderItemDAO();
            List<OrderItem> orderItems = orderitemdao.getOrderItemsByOrderId(orderId);

            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();

            for (OrderItem item : orderItems) {
                out.println("<tr>");
                out.println("<td>" + item.getProductName() + "</td>");
                out.println("<td>" + item.getProductId() + "</td>");
                out.println("<td>" + item.getQuantity() + "</td>");
                out.println("<td>" + item.getPrice() + " đ</td>");
                out.println("<td>" + (item.getQuantity() * item.getPrice()) + " đ</td>");
                out.println("</tr>");
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid orderId parameter.");
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }
}
//    
//    CustomerDAO customerDAO = new CustomerDAO();
//    Customer customer = customerDAO.getCustomerByOrderId(orderId);
//
//   if (customer != null) {
//    out.println("<script>");
//    out.println("document.getElementById('customerName').innerText = '" + customer.getFullName() + "';");
//    out.println("document.getElementById('customerPhone').innerText = '" + customer.getPhone() + "';");
//    out.println("document.getElementById('customerAddress').innerText = '" + customer.getAddress() + "';");
//    out.println("document.getElementById('customerInfoSection').style.display = 'block';");
//    out.println("</script>");
//}
//
//    }
    
//@Override
//protected void doGet(HttpServletRequest request, HttpServletResponse response)
//        throws ServletException, IOException {
//
//    String orderIdParam = request.getParameter("orderId");
//
//    if (orderIdParam == null || orderIdParam.isEmpty()) {
//        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing orderId parameter.");
//        return;
//    }
//
//    try {
//        int orderId = Integer.parseInt(orderIdParam);
//
//        OrderItemDAO orderitemdao = new OrderItemDAO();
//        List<OrderItem> orderItems = orderitemdao.getOrderItemsByOrderId(orderId);
//
//        CustomerDAO customerDAO = new CustomerDAO();
//        Customer customer = customerDAO.getCustomerByOrderId(orderId);
//
//        response.setContentType("text/html;charset=UTF-8");
//        PrintWriter out = response.getWriter();
//
//        for (OrderItem item : orderItems) {
//            out.println("<tr>");
//            out.println("<td>" + item.getProductName() + "</td>");
//            out.println("<td>" + item.getProductId() + "</td>");
//            out.println("<td>" + item.getQuantity() + "</td>");
//            out.println("<td>" + item.getPrice() + " đ</td>");
//            out.println("<td>" + (item.getQuantity() * item.getPrice()) + " đ</td>");
//            out.println("</tr>");
//        }
//
//       // Output customer info
//            if (customer != null) {
//                out.println("<tr><td colspan='5'><strong>Thông tin người nhận</strong></td></tr>");
//                out.println("<tr><td colspan='5'>");
//                out.println("Họ tên: <span id='customerName'>" + customer.getFullName() + "</span><br>");
//                out.println("SĐT: <span id='customerPhone'>" + customer.getPhone() + "</span><br>");
//                out.println("Địa chỉ: <span id='customerAddress'>" + customer.getAddress() + "</span>");
//                out.println("</td></tr>");
//            } else {
//                out.println("<tr><td colspan='5'>Không tìm thấy thông tin khách hàng cho đơn hàng này.</td></tr>");
//            }
//
//
//      } catch (NumberFormatException e) {
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid orderId parameter.");
//        } catch (SQLException e) {
//            // Log the exception for debugging
//            e.printStackTrace();
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
//        } catch (Exception e) {
//            // Catch any unexpected errors
//            e.printStackTrace();
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unexpected error: " + e.getMessage());
//        }
//    }
//}
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        String orderIdParam = request.getParameter("orderId");
//
//        if (orderIdParam == null || orderIdParam.isEmpty()) {
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing orderId parameter.");
//            return;
//        }
//
//        try {
//            int orderId = Integer.parseInt(orderIdParam);
//
//            // Fetch order items
//            OrderItemDAO orderItemDAO = new OrderItemDAO();
//            List<OrderItem> orderItems = orderItemDAO.getOrderItemsByOrderId(orderId);
//
//            // Fetch customer info
//            CustomerDAO customerDAO = new CustomerDAO();
//            Customer customer = customerDAO.getCustomerByOrderId(orderId);
//
//            response.setContentType("text/html;charset=UTF-8");
//            PrintWriter out = response.getWriter();
//
//            // Output order items
//            for (OrderItem item : orderItems) {
//                out.println("<tr>");
//                out.println("<td>" + item.getProductName() + "</td>");
//                out.println("<td>" + item.getProductId() + "</td>");
//                out.println("<td>" + item.getQuantity() + "</td>");
//                out.println("<td>" + item.getPrice() + " đ</td>");
//                out.println("<td>" + (item.getQuantity() * item.getPrice()) + " đ</td>");
//                out.println("</tr>");
//            }
//
//            // Output customer info
//            if (customer != null) {
//                out.println("<tr><td colspan='5'><strong>Thông tin người nhận</strong></td></tr>");
//                out.println("<tr><td colspan='5'>");
//                out.println("Họ tên: <span id='customerName'>" + customer.getFullName() + "</span><br>");
//                out.println("SĐT: <span id='customerPhone'>" + customer.getPhone() + "</span><br>");
//                out.println("Địa chỉ: <span id='customerAddress'>" + customer.getAddress() + "</span>");
//                out.println("</td></tr>");
//            } else {
//                out.println("<tr><td colspan='5'>Không tìm thấy thông tin khách hàng cho đơn hàng này.</td></tr>");
//            }
//
//        } catch (NumberFormatException e) {
//            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid orderId parameter.");
//        } catch (SQLException e) {
//            // Log the exception for debugging
//            e.printStackTrace();
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
//        } catch (Exception e) {
//            // Catch any unexpected errors
//            e.printStackTrace();
//            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unexpected error: " + e.getMessage());
//        }
//    }
//}