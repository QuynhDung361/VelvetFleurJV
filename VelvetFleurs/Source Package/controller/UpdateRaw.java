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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.Raw;

/**
 *
 * @author trung
 */
public class UpdateRaw extends HttpServlet {

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
            out.println("<title>Servlet UpdateRaw</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateRaw at " + request.getContextPath() + "</h1>");
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
        RawDAO dao = new RawDAO();

        int id = Integer.parseInt(request.getParameter("id"));
        Raw flower = dao.getRawById(id);
        request.setAttribute("flower", flower);
        response.sendRedirect(request.getContextPath() + "/raw");

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
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int id = Integer.parseInt(request.getParameter("id"));
         String name = request.getParameter("name");       
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
        String importDateStr = request.getParameter("importDate");
        Date importDate = null;
        if (importDateStr != null && !importDateStr.trim().isEmpty()) {
            try {
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                importDate = formatter.parse(importDateStr);
            } catch (ParseException e) {
                System.out.println("Invalid importDate: " + importDateStr);
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
        RawDAO dao = new RawDAO();
        Raw newFlower = dao.getRawById(id);
        newFlower.setName(name);
        newFlower.setQuantity(quantity);
        newFlower.setExpriseDate(expriseDate);
        newFlower.setCreateAt(importDate);
        newFlower.setImage("");
        dao.updateRaw(newFlower);


        response.sendRedirect(request.getContextPath() +"/raw"); 

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
