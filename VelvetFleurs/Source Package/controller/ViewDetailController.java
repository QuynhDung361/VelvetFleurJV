

package controller;

import dao.ProductDAO;
import model.Product;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class ViewDetailController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy productId từ URL
        String idStr = request.getParameter("id");
        
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("productPage"); // Nếu không có id, quay lại trang shop
            return;
        }
        
        try {
            int productId = Integer.parseInt(idStr);
            
            // Gọi DAO để lấy thông tin sản phẩm
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductById2(productId);
            
            if (product != null) {
                request.setAttribute("product", product);
                RequestDispatcher dispatcher = request.getRequestDispatcher("view/common/ProductViewDetail.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("productPage"); // Không tìm thấy sản phẩm -> trở lại shop
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("productPage");
        }
    }
}