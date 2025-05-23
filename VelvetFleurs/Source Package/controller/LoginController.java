/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import dao.CustomerDAO;
import dao.HashUtilDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import jakarta.servlet.http.HttpSession;
import model.Customer;

/**
 *
 * @author admin
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/authentication/Login.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        HashUtilDAO hash = new HashUtilDAO();
        // Tạo đối tượng AccountDAO để kiểm tra đăng nhập
        AccountDAO accountDAO = new AccountDAO();
        try {
            Account account = accountDAO.login(username, hash.md5(password));
            if (account != null && account.getStatus() == 1) {
                // Đăng nhập thành công, lưu thông tin vào session
                HttpSession session = request.getSession();
                session.invalidate(); // Xóa session cũ
session = request.getSession(true); // Tạo session mới

                session.setAttribute("account", account);
                CustomerDAO customerDAO = new CustomerDAO();
                Customer customer = customerDAO.getCustomerByAccountId(account.getAccountID());
                session.setAttribute("customer", customer);
                String role = account.getRole();

                session.setAttribute("role", account.getRole());
                session.setAttribute("username", account.getUsername());

                switch (role) {

                    case "Admin":
                        response.sendRedirect("account");
                        break;
                        
                    case "Manager":
                        response.sendRedirect("dashboard");
                        break;
                        
                    case "Seller":
                        response.sendRedirect("orders");
                        break;

                    case "Customer":
//                        response.sendRedirect("view/customer/EditProfile.jsp");
                        response.sendRedirect("home");
                        break;
                    default:
                        response.sendRedirect("home");
//                        response.sendRedirect("view/customer/EditProfile.jsp");
                }
            } else if (account != null && account.getStatus() == 0) {
                request.setAttribute("errorMessage", "Your account have been ban");
                request.getRequestDispatcher("/view/authentication/Login.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("/view/authentication/Login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/view/authentication/Login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "LoginController handles login logic.";
    }
}
