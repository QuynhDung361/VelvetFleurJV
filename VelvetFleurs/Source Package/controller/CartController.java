/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import model.CartItem;
import model.Product;

/**
 *
 * @author duongngo21
 */
public class CartController extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");
        
        if (cartItems == null) {
            cartItems = new ArrayList<>();
            session.setAttribute("cart", cartItems);
        }
        
        // Calculate total
        double total = cartItems.stream()
            .mapToDouble(item -> item.getQuantity() * item.getProduct().getPrice())
            .sum();
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("total", total);
        request.getRequestDispatcher("/view/common/CartPage.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));
        HttpSession session = request.getSession();
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");
        
        if (cartItems == null) {
            cartItems = new ArrayList<>();
            session.setAttribute("cart", cartItems);
        }
        
        switch (action) {
            case "add":
                addToCart(productId, cartItems);
                break;
            case "update":
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                updateCart(productId, quantity, cartItems);
                break;
            case "remove":
                removeFromCart(productId, cartItems);
                break;
        }
        
         response.sendRedirect("cart");
    }
    
    private void addToCart(int productId, List<CartItem> cartItems) {
        Optional<CartItem> existingItem = cartItems.stream()
            .filter(item -> item.getProduct().getId() == productId)
            .findFirst();
        
        if (existingItem.isPresent()) {
            existingItem.get().setQuantity(existingItem.get().getQuantity() + 1);
        } else {
            Product product = productDAO.getProductById2(productId);
            cartItems.add(new CartItem(product, 1));
        }
    }
    
    private void updateCart(int productId, int quantity, List<CartItem> cartItems) {
        cartItems.stream()
            .filter(item -> item.getProduct().getId() == productId)
            .findFirst()
            .ifPresent(item -> item.setQuantity(quantity));
    }
    
    private void removeFromCart(int productId, List<CartItem> cartItems) {
        cartItems.removeIf(item -> item.getProduct().getId() == productId);
    }
}


