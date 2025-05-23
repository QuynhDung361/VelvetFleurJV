/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;
import model.Product;

/**
 *
 * @author trung
 */
public class ProductPageController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("search");
        String categoryIdStr = request.getParameter("category");
        int categoryId = 0; // Default to 0 if the parameter is null or empty

        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException e) {
                // Handle the error (e.g., log the error)
                System.out.println("Invalid category ID: " + categoryIdStr);
                categoryId = 0; // Set to 0 in case of an invalid number
            }
        }

        int page = 1;
        int recordsPerPage = 8;

        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            // default to page = 1
        }

        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = null;
        int totalRecords = 0;

        searchTerm = (searchTerm != null) ? searchTerm.trim() : "";  // For search term, trim to avoid extra spaces    // categoryId is already an int, no need for trim

        try {
            if (!searchTerm.isEmpty()) {
                productList = productDAO.searchProducts(searchTerm, (page - 1) * recordsPerPage, recordsPerPage);
                totalRecords = productDAO.countSearchResults(searchTerm);
            } else if (categoryId != 0) {
                productList = productDAO.getProductsByCategory(categoryId, (page - 1) * recordsPerPage, recordsPerPage);
                totalRecords = productDAO.countProductsByCategory(categoryId);
            } else {
                productList = productDAO.getAllProducts((page - 1) * recordsPerPage, recordsPerPage);
                totalRecords = productDAO.countAllProducts();
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductPageController.class.getName()).log(Level.SEVERE, null, ex);
        }

        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categoryList = categoryDAO.getAllCategories();

        request.setAttribute("productList", productList);
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("searchTerm", searchTerm);
        request.setAttribute("selectedCategory", categoryId);

        request.getRequestDispatcher("/view/common/ProductPage.jsp").forward(request, response);
    }

}
