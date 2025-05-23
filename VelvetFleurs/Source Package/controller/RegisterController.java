/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import dao.HashUtilDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author trung
 */
public class RegisterController extends HttpServlet {

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
            out.println("<title>Servlet RegisterController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterController at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("view/authentication/SignUpPage.jsp").forward(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("phone");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullname");
        String password = request.getParameter("password");

        // Validate đơn giản
        AccountDAO dao = new AccountDAO();

//     Kiểm tra username đã tồn tại
        if (fullName.length() < 6) {
            request.setAttribute("error", "Full Name must be at least 8 characters");
            request.setAttribute("fullname", fullName);
            request.setAttribute("phone", username);
            request.setAttribute("email", email);
            request.getRequestDispatcher("view/authentication/SignUpPage.jsp").forward(request, response);
            return;
        }
        if (!fullName.matches(fullName)) {
            request.setAttribute("error", "Full name must start with capital letters and only contain letters and spaces.");
            request.setAttribute("fullname", fullName);
            request.setAttribute("phone", username);
            request.setAttribute("email", email);
            request.getRequestDispatcher("view/authentication/SignUpPage.jsp").forward(request, response);
            return;
        }
        if (dao.isPhoneExists(username)) {
            request.setAttribute("error", "Phone already in use!");
            request.setAttribute("fullname", fullName);
            request.setAttribute("phone", username);
            request.setAttribute("email", email);
            request.getRequestDispatcher("view/authentication/SignUpPage.jsp").forward(request, response);
            return;
        }
        String phonePattern = "^0\\d{9}$";

        if (!username.matches(phonePattern)) {
            request.setAttribute("error", "Phone must be 10 digits and start with 0.");
            request.setAttribute("fullname", fullName);
            request.setAttribute("phone", username);
            request.setAttribute("email", email);
            request.getRequestDispatcher("view/authentication/SignUpPage.jsp").forward(request, response);
            return;
        }
        if (dao.isEmailExists(email) && !email.isEmpty()) {
            request.setAttribute("error", "Email already in use!");
            request.setAttribute("fullname", fullName);
            request.setAttribute("phone", username);
            request.setAttribute("email", email);
            request.getRequestDispatcher("view/authentication/SignUpPage.jsp").forward(request, response);
            return;
        }
        if (password.length() < 8) {
            request.setAttribute("error", "Password must be at least 8 characters");
            request.setAttribute("fullname", fullName);
            request.setAttribute("phone", username);
            request.setAttribute("email", email);
            request.getRequestDispatcher("view/authentication/SignUpPage.jsp").forward(request, response);
            return;
        }
        String passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{8,}$";

        if (!password.matches(passwordPattern)) {
            request.setAttribute("error", "Password must including uppercase, lowercase, numbers and special characters.");
            request.setAttribute("fullname", fullName);
            request.setAttribute("phone", username);
            request.setAttribute("email", email);
            request.getRequestDispatcher("view/authentication/SignUpPage.jsp").forward(request, response);
            return;
        }
        // Hash password
        String hashedPassword = HashUtilDAO.md5(password);

        // Đăng ký (thêm account và customer)
        boolean success = dao.registerCustomer(username, hashedPassword, email, fullName);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Register fail. Please try again.");
            request.getRequestDispatcher("view/authentication/SignUpPage.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
