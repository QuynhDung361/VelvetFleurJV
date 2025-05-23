/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.OrderDAO;
import dao.OrderItemDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Order;
import model.OrderItem;

/**
 *
 * @author sunny
 */
public class ViewOrderDetailsServlet extends HttpServlet {

     @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect("view-order");
            return;
        }

        try {
             int orderId = Integer.parseInt(idParam);
//            OrderDAO dao = new OrderDAO();
            OrderItemDAO dao = new OrderItemDAO();
            List<OrderItem> orderItems = dao.getOrderItemsByOrderId1(orderId);

            request.setAttribute("orderId", orderId);
            request.setAttribute("orderItems", orderItems);
            request.getRequestDispatcher("/view/customer/orderdetails.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view-order");
        }
    }

    
}
