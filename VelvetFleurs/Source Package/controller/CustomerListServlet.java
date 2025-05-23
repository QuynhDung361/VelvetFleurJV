//package controller;
//import dao.CustomerDAO;
//import java.io.*;
//import jakarta.servlet.*;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//import java.util.*;
//import model.Customer;
//
//@WebServlet("/viewCustomer")
//public class CustomerListServlet extends HttpServlet {
//    private CustomerDAO customerDAO;
//
//    public void init() {
//        customerDAO = new CustomerDAO();
//    }
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        List<Customer> listCustomer = customerDAO.getAllCustomers();
//        request.setAttribute("listCustomer", listCustomer);
//        RequestDispatcher dispatcher = request.getRequestDispatcher("view/customer/listCustomer.jsp");
//        dispatcher.forward(request, response);
//    }
//}
package controller;

import dao.CustomerDAO;
import model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/viewCustomer")
public class CustomerListServlet extends HttpServlet {
    private CustomerDAO customerDAO;

    public void init() {
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String customerIdParam = request.getParameter("customerId");

        if (customerIdParam == null || customerIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing customerId parameter.");
            return;
        }

        try {
            int customerId = Integer.parseInt(customerIdParam);

            Customer customer = customerDAO.getCustomerById(customerId);
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();

            if (customer != null) {
                out.println("<p><strong>Họ tên:</strong> " + customer.getFullName() + "</p>");
                out.println("<p><strong>Số điện thoại:</strong> " + customer.getPhone() + "</p>");
                out.println("<p><strong>Địa chỉ:</strong> " + customer.getAddress() + "</p>");
            } else {
                out.println("<p style='color:red;'>Không tìm thấy thông tin khách hàng.</p>");
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid customerId parameter.");
        }
    }
}
