///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package controller;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.IOException;
//
//@WebServlet(name = "DashboardController", urlPatterns = {"/dashboard"})
//public class DashboardController extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        HttpSession session = request.getSession(false);
//
//        // Nếu chưa login hoặc không phải Manager/Admin/Seller thì chặn
//        if (session == null || session.getAttribute("account") == null) {
//            response.sendRedirect("login");
//            return;
//        }
//
//        String role = (String) session.getAttribute("role");
//        if (role == null || role.equalsIgnoreCase("Customer")) {
//            response.sendRedirect("home");
//            return;
//        }
//
//        // Nếu hợp lệ thì forward tới dashboard.jsp
//        request.getRequestDispatcher("/view/dashboard/dashboard.jsp").forward(request, response);
//    }
//    {        try (Connection conn = DBConnection.getConnection()) {
//            OrderDAO orderDAO = new OrderDAO(conn);
//            ProductDAO productDAO = new ProductDAO(conn);
//            CustomerDAO customerDAO = new CustomerDAO(conn);
//
//            int totalOrders = orderDAO.getTotalOrders();
//            int pendingOrders = orderDAO.getPendingOrders();
//            double totalRevenue = orderDAO.getTotalRevenue();
//            int totalProduct = productDAO.getTotalProduct();
//            int totalCustomers = customerDAO.getTotalCustomers();
//
//            request.setAttribute("totalOrders", totalOrders);
//            request.setAttribute("pendingOrders", pendingOrders);
//            request.setAttribute("totalRevenue", totalRevenue);
//            request.setAttribute("totalProduct", totalProduct);
//            request.setAttribute("totalCustomers", totalCustomers);
//
//            request.getRequestDispatcher("/view/dashboard/dashboard.jsp").forward(request, response);
//        } catch (Exception e) {
//            throw new ServletException("Error fetching summary data", e);
//        }
//    }
//
//    @Override
//    public String getServletInfo() {
//        return "DashboardController for Manager/Admin/Seller.";
//    }
//}

package controller;

import dao.CustomerDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Product;

@WebServlet(name = "DashboardController", urlPatterns = {"/dashboard"})
public class DashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Nếu chưa login hoặc không phải Manager/Admin/Seller thì chặn
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect("login");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (role == null || role.equalsIgnoreCase("Customer")) {
            response.sendRedirect("home");
            return;
        }

        try {
            OrderDAO orderDAO = new OrderDAO();
            ProductDAO productDAO = new ProductDAO();
            CustomerDAO customerDAO = new CustomerDAO();

            int totalOrders = orderDAO.getTotalOrders().get(0);     
            int pendingOrders = orderDAO.getPendingOrders().get(0);
            double totalRevenue = orderDAO.getTotalRevenue().get(0);
            int totalProduct = productDAO.getTotalProduct().get(0);
            int totalCustomers = customerDAO.getTotalCustomers().get(0);

              List<Product> bestSellers = productDAO.getBestSellingProducts(5);
              
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("totalProduct", totalProduct);
            request.setAttribute("totalCustomers", totalCustomers);
    request.setAttribute("bestSellers", bestSellers); 

    
            request.getRequestDispatcher("/view/dashboard/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
    System.err.println("DashboardController error: " + e.getMessage());
    e.printStackTrace();
    throw new ServletException("Error fetching summary data", e);
}
    }

    @Override
    public String getServletInfo() {
        return "DashboardController for Manager/Admin/Seller.";
    }
}
