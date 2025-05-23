/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Customer;
import model.Order;

/**
 *
 * @author sunny
 */

public class ViewOrdersServlet extends HttpServlet {

//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        HttpSession session = request.getSession();
//        Customer loggedInUser = (Customer) session.getAttribute("customer");
//
//        if (loggedInUser == null) {
//            response.sendRedirect("login");
//            return;
//        }
//
//        try {
//            OrderDAO orderDAO = new OrderDAO();
//            List<Order> orders = orderDAO.getOrdersByCustomerId(loggedInUser.getId());
//
//            request.setAttribute("orders", orders);
//            request.getRequestDispatcher("/view/customer/view_orders.jsp").forward(request, response);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            request.setAttribute("errorMessage", "Could not load your orders. Please try again later.");
//            request.getRequestDispatcher("error.jsp").forward(request, response);
//        }
//    }
//}
    
  @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer loggedInUser = (Customer) session.getAttribute("customer");

        if (loggedInUser == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            String search = request.getParameter("search");
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

            OrderDAO orderDAO = new OrderDAO();
            List<Order> orders = orderDAO.searchOrders(loggedInUser.getId(), search, status, deliveryStatus);

            request.setAttribute("orders", orders);
            request.setAttribute("search", search);
            request.setAttribute("status", statusParam);
            request.setAttribute("deliveryStatus", deliveryStatus);
            request.getRequestDispatcher("/view/customer/view_orders.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Could not load your orders. Please try again later.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
