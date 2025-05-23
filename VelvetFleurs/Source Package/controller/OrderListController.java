/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.OrderDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Order;

/**
 *
 * @author sunny
 */

public class OrderListController extends HttpServlet {

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
//        OrderDAO dao = new OrderDAO();
//        List<Order> orders = dao.getAllOrders();
//        request.setAttribute("orders", orders);
//
//        request.getRequestDispatcher("/view/ordermanagement/orderList.jsp").forward(request, response);
//    }

        try {
            String statusParam = request.getParameter("status");
            String deliveryStatus = request.getParameter("deliveryStatus");

            Integer status = null;
            if (statusParam != null && !statusParam.isEmpty()) {
                try {
                    status = Integer.parseInt(statusParam);
                } catch (NumberFormatException e) {
                    status = null;
                }
            }

            OrderDAO dao = new OrderDAO();
            List<Order> orders = dao.searchOrders1(status, deliveryStatus);

            request.setAttribute("orders", orders);
            request.setAttribute("status", statusParam);
            request.setAttribute("deliveryStatus", deliveryStatus);
            request.getRequestDispatcher("/view/ordermanagement/orderList.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Could not load the orders. Please try again later.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            int status = Integer.parseInt(request.getParameter("status"));
            String deliveryStatus = request.getParameter("deliveryStatus");

            OrderDAO dao = new OrderDAO();
            dao.updateOrderStatus(orderId, status, deliveryStatus);

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("{\"message\":\"Delivery status updated successfully.\"}");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid data.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
