package controller;

import dao.CustomerDAO;
import dao.OrderDAO;
import model.Account;
import model.CartItem;
import model.Customer;
import model.Order;
import model.OrderItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CheckOutController extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        // Tự động fill thông tin khách hàng
        if (customer != null) {
            request.setAttribute("fullname", customer.getFullName());
            request.setAttribute("address", customer.getAddress());
            request.setAttribute("phone", customer.getPhone());
        }

        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");
        double totalAmount = 0;
        if (cartItems != null) {
            for (CartItem item : cartItems) {
                totalAmount += item.getProduct().getPrice() * item.getQuantity();
            }
        }

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalAmount", totalAmount);

        request.getRequestDispatcher("/view/common/CheckOut.jsp").forward(request, response);
    }

//  
}
