/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.RawDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.Raw;

/**
 *
 * @author trung
 */
public class AddRaw extends HttpServlet {

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
            out.println("<title>Servlet AddRaw</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddRaw at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String UPLOAD_DIR = "flower_images";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle text fields
        String name = request.getParameter("name");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        Date importDate = new Date(System.currentTimeMillis()); // Current date as import
        // Handle image upload   
        String expriseDateStr = request.getParameter("expriseDate");
        Date expriseDate = null;
        if (expriseDateStr != null && !expriseDateStr.trim().isEmpty()) {
            try {
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                expriseDate = formatter.parse(expriseDateStr);
            } catch (ParseException e) {
                System.out.println("Invalid expireDate: " + expriseDateStr);
            }
        }
        // Tiếp tục xử lý với expireDate
//        Part imagePart = request.getPart("createFlowerImage");
//        String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
//
//        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
//        File uploadDir = new File(uploadPath);
//        if (!uploadDir.exists()) {
//            uploadDir.mkdir();
//        }
//
//        String imagePath = UPLOAD_DIR + File.separator + fileName;
//        imagePart.write(uploadPath + File.separator + fileName);

        // Save flower to database using DAO
        Raw newFlower = new Raw();
        newFlower.setName(name);
        newFlower.setQuantity(quantity);
        newFlower.setExpriseDate(expriseDate);
        newFlower.setCreateAt(importDate);
        newFlower.setImage("");

        RawDAO dao = new RawDAO();
        dao.addRaw(newFlower);

        response.sendRedirect(request.getContextPath() +"/raw"); // or use a controller servlet
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

    private void println(String bookingDate, String ngày_đặt_lịch_không_hợp_lệ) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
