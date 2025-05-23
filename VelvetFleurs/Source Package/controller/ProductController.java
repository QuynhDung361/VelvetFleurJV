package controller;

import dao.CategoryDAO;
import dao.CommentDAO;
import dao.OrderItemDAO;
import dao.ProductDAO;
import dao.ProductRawDAO;
import dao.RawDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Category;
import model.Product;
import model.Raw;

/**
 * Controller class for handling product-related operations
 *
 * @author ADMIN
 */
@WebServlet(name = "ProductController", urlPatterns = {"/product"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class ProductController extends HttpServlet {

    private ProductDAO productDAO;
    private CommentDAO commentDAO;
    private OrderItemDAO orderItemDAO;
    private ProductRawDAO productRawDAO;

    
    
    @Override
    public void init() throws ServletException {
        // Khởi tạo productDAO
        this.productDAO = new ProductDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(false);

        // Kiểm tra session và quyền truy cập
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect("login");
            return;
        }

        String role = (String) session.getAttribute("role");

        // Kiểm tra nếu không phải Manager hoặc Seller thì chuyển hướng về home
        if (!"Seller".equalsIgnoreCase(role) && !"Manager".equalsIgnoreCase(role)) {
            response.sendRedirect("home");
            return;
        
        }
        
        // Add this code to your doGet method or wherever you handle listing products

    
  
    
    // Check for error messages in session
    String error = (String) session.getAttribute("error");
    if (error != null) {
        // Move error from session to request
        request.setAttribute("error", error);
        // Remove it from session so it doesn't persist
        session.removeAttribute("error");
    }
    
    // Forward to your JSP page

        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO(); // Assuming you have a CategoryDAO
        RawDAO rawDAO = new RawDAO();
    //List<Product> products = productDAO.getAllProducts();
  //  request.setAttribute("products", products);

        String action = request.getParameter("action");

        if (action == null || action.equals("list")) {
            // List all products
         List<Product> products = productDAO.getAllProducts();
            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("products", products);
            request.setAttribute("categories", categories);

            request.getRequestDispatcher("/view/productmanagement/manageProduct.jsp").forward(request, response);

            } else if (action.equals("edit")) {
            // Lấy productId từ request
            String productId = request.getParameter("productId");

            // Kiểm tra productId và lấy thông tin sản phẩm từ cơ sở dữ liệu
            if (productId != null && !productId.isEmpty()) {
                // Lấy thông tin sản phẩm từ DAO
                Product product = productDAO.getProductById(Integer.parseInt(productId));

                // Kiểm tra nếu sản phẩm tồn tại, nếu không thì chuyển hướng về danh sách sản phẩm
                if (product != null) {
                    request.setAttribute("product", product);
                    List<Category> categories = categoryDAO.getAllCategories();
                    request.setAttribute("categories", categories);

                    // Forward tới trang chỉnh sửa sản phẩm
                    request.getRequestDispatcher("/view/productmanagement/editProduct.jsp").forward(request, response);
                } else {
                    response.sendRedirect("product?action=list");
                }
            } else {
                response.sendRedirect("product?action=list");
            }
        
//        } else if (action.equals("detail")) {
//            // Show product details
//            int productId = Integer.parseInt(request.getParameter("id"));
//
//            Product product = productDAO.getProductById(productId);
//
//            request.setAttribute("product", product);
//            request.getRequestDispatcher("/view/productmanagement/detailProduct.jsp").forward(request, response);

        } else if (action.equals("search")) {
            // Search products by name
            String keyword = request.getParameter("keyword");
            List<Product> products = productDAO.searchProductsByName(keyword);
            List<Category> categories = categoryDAO.getAllCategories();

            request.setAttribute("products", products);
            request.setAttribute("categories", categories);

            request.setAttribute("keyword", keyword);
            request.getRequestDispatcher("/view/productmanagement/manageProduct.jsp").forward(request, response);

        } else if (action.equals("showAddForm")) {
            // Show the form to add a new product
            List<Category> categories = categoryDAO.getAllCategories();
            List<Raw> rawMaterials = rawDAO.getAllRaws();

            request.setAttribute("categories", categories);
            request.setAttribute("rawMaterials", rawMaterials);
            request.getRequestDispatcher("/view/productmanagement/addProduct.jsp").forward(request, response);

        } else if (action.equals("showEditForm")) {
            // Show the form to edit an existing product
            int productId = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.getProductById(productId);

            List<Category> categories = categoryDAO.getAllCategories();
            List<Raw> rawMaterials = rawDAO.getAllRaws();

            // Get raw materials used in this product with quantities
            ProductRawDAO productRawDAO = new ProductRawDAO();
            Map<Raw, Integer> productRawQuantities = productRawDAO.getRawQuantitiesForProduct(productId);

            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            request.setAttribute("rawMaterials", rawMaterials);
            request.setAttribute("productRawQuantities", productRawQuantities);
            request.getRequestDispatcher("/view/productmanagement/editProduct.jsp").forward(request, response);
   
            

      }
        
        
}
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        ProductDAO productDAO = new ProductDAO();
        RawDAO rawDAO = new RawDAO();
        ProductRawDAO productRawDAO = new ProductRawDAO();

//        String action = request.getParameter("action");
// if (action == null) {
//        action = "";
//    }
////
////    switch (action) {
////        case "delete":
////            deleteProduct(request, response);
////            break;
//////        // các case khác (add, update, etc)
////        default:
////            response.sendRedirect(request.getContextPath() + "/product");
//////            break;
////            return;
////  }
//
// switch (action) {
//        case "delete":
//            deleteProduct(request, response);
//            break;
////        // các case khác (add, update, etc)
////        default:
////            response.sendRedirect(request.getContextPath() + "/product");
////            break;
//  }
////}
      String action = request.getParameter("action");
 if (action == null) {
        action = "";
    }

    switch (action) {
        case "delete":
            deleteProduct(request, response);
            break;
//        // các case khác (add, update, etc)
//        default:
//            response.sendRedirect(request.getContextPath() + "/product");
//            break;
  }
//}
        if (action.equals("add")) {
                boolean hasError = false;

            try {
                // Extract product information
                //  String name = request.getParameter("name");

//String name = name == null ? "" : name.trim();

                String nameRaw = request.getParameter("name");
                String name = nameRaw == null ? "" : nameRaw.trim();
                if (name.isEmpty()) {
                    request.getSession().setAttribute("message", "Tên sản phẩm không được để trống hoặc chỉ chứa khoảng trắng!");
                    response.sendRedirect("product?action=showAddForm");
                    return;
                }



                double price = Double.parseDouble(request.getParameter("price"));
                try {
    if (price <= 0) {
        request.setAttribute("error", "Price must be a positive number.");
    }
} catch (NumberFormatException e) {
    request.setAttribute("error", "Price must be a valid number.");
}
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                String description = request.getParameter("description");
                int quantity = Integer.parseInt(request.getParameter("quantity"));



                // Handle image upload
                String imagePath = "default-product.jpg"; // Default image path
                Part filePart = request.getPart("image");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = getFileName(filePart);
                    if (fileName != null && !fileName.isEmpty()) {
                        // Generate unique file name to prevent overwriting
                        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                        String uploadPath = getServletContext().getRealPath("/images/products/");

                        // Create directory if it doesn't exist
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }

                        // Save the file
                        filePart.write(uploadPath + File.separator + uniqueFileName);
                        imagePath = "images/products/" + uniqueFileName;
                    }
                }
  
                // Create product object
                Product product = new Product();
                product.setName(name);
                product.setPrice(price);
                product.setImage(imagePath);
                product.setCategoryId(categoryId);
                product.setDescription(description);
                product.setCreateAt(new Date());
                product.setQuantity(quantity);

                // Get raw materials from form
                Map<Integer, Integer> rawQuantities = new HashMap<>();
                String[] rawIds = request.getParameterValues("rawId");
                String[] rawQuantityArr = request.getParameterValues("rawQuantity");

                if (rawIds != null && rawQuantityArr != null) {
                    // Check if we have enough quantity of each raw material and not expired
                    boolean insufficientRaw = false;
                    String errorMessage = "";

                    for (int i = 0; i < rawIds.length; i++) {
                        int rawId = Integer.parseInt(rawIds[i]);
                        int rawQuantityPerProduct = Integer.parseInt(rawQuantityArr[i]);

                        if (rawQuantityPerProduct <= 0) {
                            continue;
                        }
                        // Check if the raw material exists and has enough quantity
                        Raw raw = rawDAO.getRawById(rawId);
                        if (raw == null) {
                            insufficientRaw = true;
                            errorMessage = "Raw material with ID " + rawId + " does not exist.";
                            break;
                        }

                        // Check if expired
                        if (rawDAO.isExpired(rawId)) {
                            insufficientRaw = true;
                            errorMessage = "Raw material '" + raw.getName() + "' is expired.";
                            break;
                        }

                        int totalRawUsed = rawQuantityPerProduct * quantity;

                        if (!rawDAO.hasEnoughQuantity(rawId, totalRawUsed)) {
                            insufficientRaw = true;
                            errorMessage = "Insufficient quantity of raw material '" + raw.getName() + "'. Required: " + totalRawUsed + ", Available: " + raw.getQuantity();
                            break;
                        }

                        rawQuantities.put(rawId, totalRawUsed);
                    }

                    if (insufficientRaw) {
                        // Set error message and forward back to the form
                        request.setAttribute("error", errorMessage);
                        request.setAttribute("product", product);

// Load lại danh sách nguyên liệu
                        List<Raw> rawList = rawDAO.getAllRaws();
                        for (Raw raw : rawList) {
                            boolean expired = rawDAO.isExpired(raw.getId());
                            //   raw.setExpired(expired);
                        }
                        request.setAttribute("raws", rawList);

// Load lại danh sách danh mục
                        CategoryDAO categoryDAO = new CategoryDAO();
                        List<Category> categoryList = categoryDAO.getAllCategories();
                        request.setAttribute("categories", categoryList);

                        request.getRequestDispatcher("/view/productmanagement/addProduct.jsp").forward(request, response);
                        return;
                    }
                }


                if (productDAO.addProduct(product)) {
                    // Đảm bảo lấy được productId đã được sinh ra
               int productId = productDAO.getGeneratedProductId();
    System.out.println("Generated Product ID: " + productId);

               
            
               
                    // Thêm nguyên liệu thô vào sản phẩm
                    for (Map.Entry<Integer, Integer> entry : rawQuantities.entrySet()) {
                          System.out.println("Raw ID: " + entry.getKey() + ", Quantity: " + entry.getValue());

                        int rawId = entry.getKey();
                        int totalRawUsed = entry.getValue();
                   
     //   boolean productRawAdded = productRawDAO.addProductRaw(productId, rawId, totalRawUsed / quantity); // Chỉ lưu định mức 1 sản phẩm

                        // Add product-raw relationship dòng này dùng ok này
                      productRawDAO.addProductRaw(product.getId(), rawId, totalRawUsed / quantity); // chỉ lưu định mức 1 sản phẩm

                        // Trừ nguyên liệu thật trong kho
                        rawDAO.updateRawQuantity(rawId, totalRawUsed);
                     //  if (!productRawAdded) {
            // Nếu không thể thêm vào ProductRaw, xử lý lỗi
            //request.setAttribute("error", "Failed to associate product with raw material.");
           // request.getRequestDispatcher("/view/productmanagement/addProduct.jsp").forward(request, response);
           // return;
      //  }
                    
                    }
                    // Chuyển hướng đến danh sách sản phẩm với thông báo thành công
                    response.sendRedirect(request.getContextPath() + "/product?success=Product added successfully");
                } else {
                    // Nếu không thể lưu sản phẩm
                    request.setAttribute("error", "Failed to add product. Please try again.");
                    request.setAttribute("product", product);
                    request.getRequestDispatcher("/view/productmanagement/addProduct.jsp").forward(request, response);
                }

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "An error occurred: " + e.getMessage());
                request.getRequestDispatcher("/view/productmanagement/addProduct.jsp").forward(request, response);
            }

            
             } else if (action.equals("edit")) {
        try {
            // Extract product ID and fetch existing product
            int productId = Integer.parseInt(request.getParameter("productId"));
            Product existingProduct = productDAO.getProductById(productId);

            if (existingProduct != null) {
                // Extract updated product information
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                String description = request.getParameter("description");
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                // Handle image upload (if new image provided)
                String imagePath = existingProduct.getImage(); // Keep the existing image by default
                Part filePart = request.getPart("image");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = getFileName(filePart);
                    if (fileName != null && !fileName.isEmpty()) {
                        // Generate unique file name to prevent overwriting
                        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                        String uploadPath = getServletContext().getRealPath("/images/products/");

                        // Create directory if it doesn't exist
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }

                        // Save the file
                        filePart.write(uploadPath + File.separator + uniqueFileName);
                        imagePath = "images/products/" + uniqueFileName;
                    }
                }

                // Update product object
                existingProduct.setName(name);
                existingProduct.setPrice(price);
                existingProduct.setImage(imagePath);
                existingProduct.setCategoryId(categoryId);
                existingProduct.setDescription(description);
                existingProduct.setQuantity(quantity);
                existingProduct.setUpdateAt(new Date()); // Set update timestamp

                
//                // Create product object
            Product product = new Product();
//            product.setId(productId);
//            product.setName(name);
//            product.setPrice(price);
//            product.setImage(imagePath);
//            product.setCategoryId(categoryId);
//            product.setDescription(description);
//            product.setCreateAt(new Date());
//            product.setQuantity(quantity);

            // Update product in the database
          //  boolean productUpdated = productDAO.updateProduct(product);

                // Get raw materials from form
                Map<Integer, Integer> rawQuantities = new HashMap<>();
                String[] rawIds = request.getParameterValues("rawId");
                String[] rawQuantityArr = request.getParameterValues("rawQuantity");

                if (rawIds != null && rawQuantityArr != null) {
                    // Check if we have enough quantity of each raw material and not expired
                    boolean insufficientRaw = false;
                    String errorMessage = "";

                    for (int i = 0; i < rawIds.length; i++) {
                        int rawId = Integer.parseInt(rawIds[i]);
                        int rawQuantityPerProduct = Integer.parseInt(rawQuantityArr[i]);

                        if (rawQuantityPerProduct <= 0) {
                            continue;
                        }
                        // Check if the raw material exists and has enough quantity
                        Raw raw = rawDAO.getRawById(rawId);
                        if (raw == null) {
                            insufficientRaw = true;
                            errorMessage = "Raw material with ID " + rawId + " does not exist.";
                            break;
                        }

                        // Check if expired
                        if (rawDAO.isExpired(rawId)) {
                            insufficientRaw = true;
                            errorMessage = "Raw material '" + raw.getName() + "' is expired.";
                            break;
                        }

                        int totalRawUsed = rawQuantityPerProduct * quantity;

                        if (!rawDAO.hasEnoughQuantity(rawId, totalRawUsed)) {
                            insufficientRaw = true;
                            errorMessage = "Insufficient quantity of raw material '" + raw.getName() + "'. Required: " + totalRawUsed + ", Available: " + raw.getQuantity();
                            break;
                        }

                        rawQuantities.put(rawId, totalRawUsed);
                    }

                    if (insufficientRaw) {
                        // Set error message and forward back to the form
                        request.setAttribute("error", errorMessage);
                        request.setAttribute("product", existingProduct);

                        // Load raw materials and categories again
                        loadCategoriesAndRaws(request);
request.setAttribute("product", product);

                        request.getRequestDispatcher("/view/productmanagement/editProduct.jsp").forward(request, response);
                        return;
                    }
                }

                // Update product in the database
                if (productDAO.updateProduct(existingProduct)) {
                    // Update raw materials relationship
                    for (Map.Entry<Integer, Integer> entry : rawQuantities.entrySet()) {
                        int rawId = entry.getKey();
                        int totalRawUsed = entry.getValue();

                        // Update product-raw relationship
                        productRawDAO.updateProductRaw(existingProduct.getId(), rawId, totalRawUsed / quantity); // Update with 1 product's ratio

                        // Update raw material quantity in inventory
                        rawDAO.updateRawQuantity(rawId, totalRawUsed);
                    }

                    // Redirect to the list page with success message
                    response.sendRedirect(request.getContextPath() + "/product?success=Product updated successfully");
                } else {
                    // If update failed
                    request.setAttribute("error", "Failed to update product. Please try again.");
                    request.setAttribute("product", existingProduct);
                    request.setAttribute("product", product);

                    request.getRequestDispatcher("/view/productmanagement/editProduct.jsp").forward(request, response);
                }

            } else {
                // If product not found
                request.setAttribute("error", "Product not found.");
                request.getRequestDispatcher("/view/productmanagement/editProduct.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
           

            request.getRequestDispatcher("/view/productmanagement/editProduct.jsp").forward(request, response);
        }
    
            
        }
//    if ("updateQuantity".equals(action)) {
//            updateQuantity(request, response);
//        }
//    }
//
//    private void updateQuantity(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        try {
//            int productId = Integer.parseInt(request.getParameter("productId"));
//            int addedQuantity = Integer.parseInt(request.getParameter("addedQuantity"));
//
//            boolean success = productDAO.updateQuantity(productId, addedQuantity);
// if (success) {
//                response.sendRedirect("product"); // reload lại list
//            } else {
//                request.setAttribute("error", "Cập nhật số lượng thất bại");
//                request.getRequestDispatcher("listProduct.jsp").forward(request, response);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.getWriter().write("Error: " + e.getMessage());
//        }

//    }

//if ("updateQuantity".equals(action)) {
//    updateQuantity(request, response);
//}
//    }
//
//private void updateQuantity(HttpServletRequest request, HttpServletResponse response)
//        throws ServletException, IOException {
//    try {
//        int productId = Integer.parseInt(request.getParameter("productId"));
//        int addedQuantity = Integer.parseInt(request.getParameter("addedQuantity"));
//
//        // Tạo đối tượng RawDAO để kiểm tra nguyên liệu
//        RawDAO rawDAO = new RawDAO();
//        
//        // Kiểm tra nếu đủ nguyên liệu trong bảng raw
//        boolean rawAvailable = rawDAO.checkRawAvailability(productId, addedQuantity);
//        
//        if (!rawAvailable) {
//            request.setAttribute("error", "Không đủ nguyên liệu để tạo thêm sản phẩm.");
//          //  request.getRequestDispatcher("/view/productmanagement/manageProduct.jsp").forward(request, response);
//                        request.getRequestDispatcher("product").forward(request, response);
//
//            return;
//        }
//
//        // Cập nhật số lượng sản phẩm trong bảng product
//        boolean success = productDAO.updateQuantity(productId, addedQuantity);
//
//        if (success) {
//            // Nếu thành công, reload lại list sản phẩm
//            response.sendRedirect("product"); 
//        } else {
//            request.setAttribute("error", "Cập nhật số lượng sản phẩm thất bại");
//            request.getRequestDispatcher("/view/productmanagement/manageProduct.jsp").forward(request, response);
//        }
//    } catch (Exception e) {
//        e.printStackTrace();
//        response.getWriter().write("Error: " + e.getMessage());
//    }
//}
//if ("updateQuantity".equals(action)) {
//    updateQuantity(request, response);
//}
//    }
//private void updateQuantity(HttpServletRequest request, HttpServletResponse response)
//        throws ServletException, IOException {
//    try {
//        int productId = Integer.parseInt(request.getParameter("productId"));
//        int addedQuantity = Integer.parseInt(request.getParameter("addedQuantity"));
//
//        // Tạo đối tượng RawDAO để kiểm tra nguyên liệu
//        RawDAO rawDAO = new RawDAO();
//        
//        // Kiểm tra nếu đủ nguyên liệu trong bảng raw
//        boolean rawAvailable = rawDAO.checkRawAvailability(productId, addedQuantity);
//        
//        if (!rawAvailable) {
//            request.setAttribute("error", "Không đủ nguyên liệu để tạo thêm sản phẩm.");
//            request.getRequestDispatcher("/view/productmanagement/manageProduct.jsp").forward(request, response);
//            return;
//        }
//
//        // Cập nhật số lượng sản phẩm trong bảng product
//        boolean success = productDAO.updateQuantity(productId, addedQuantity);
//
//        if (success) {
//            // Nếu thành công, reload lại list sản phẩm
//            response.sendRedirect("product"); 
//        } else {
//            request.setAttribute("error", "Cập nhật số lượng sản phẩm thất bại");
//            request.getRequestDispatcher("/view/productmanagement/manageProduct.jsp").forward(request, response);
//        }
//    } catch (Exception e) {
//        e.printStackTrace();
//        response.getWriter().write("Error: " + e.getMessage());
//    }
//}
if ("updateQuantity".equals(action)) {
    updateQuantity(request, response);

}}

//private void updateQuantity(HttpServletRequest request, HttpServletResponse response)
//        throws ServletException, IOException {
//    try {
//        int productId = Integer.parseInt(request.getParameter("productId"));
//        int addedQuantity = Integer.parseInt(request.getParameter("addedQuantity"));
//
//        // Tạo đối tượng RawDAO để kiểm tra nguyên liệu và cập nhật số lượng nguyên liệu
//        RawDAO rawDAO = new RawDAO();
//        
//        // Kiểm tra nếu đủ nguyên liệu trong bảng raw
//        boolean rawAvailable = rawDAO.updateRawQuantity2(productId, addedQuantity);
//        
//        if (!rawAvailable) {
//            request.setAttribute("error", "Không đủ nguyên liệu để tạo thêm sản phẩm.");
//            request.getRequestDispatcher("/view/productmanagement/manageProduct.jsp").forward(request, response);
//            return;
//        }
//
//        // Cập nhật số lượng sản phẩm trong bảng product
//        boolean success = productDAO.updateQuantity(productId, addedQuantity);
//
//        if (success) {
//            // Nếu thành công, reload lại list sản phẩm
//            response.sendRedirect("product"); 
//        } else {
//            request.setAttribute("error", "Cập nhật số lượng sản phẩm thất bại");
//            request.getRequestDispatcher("/view/productmanagement/manageProduct.jsp").forward(request, response);
//        }
//    } catch (Exception e) {
//        e.printStackTrace();
//        response.getWriter().write("Error: " + e.getMessage());
//    }
//}

//private void updateQuantity(HttpServletRequest request, HttpServletResponse response)
//        throws ServletException, IOException {
//    try {
//        int productId = Integer.parseInt(request.getParameter("productId"));
//        int addedQuantity = Integer.parseInt(request.getParameter("addedQuantity"));
//
//        RawDAO rawDAO = new RawDAO();
//        ProductDAO productDAO = new ProductDAO(); // Đảm bảo bạn có đối tượng này nếu chưa có
//
//        // Kiểm tra nếu đủ nguyên liệu
//        boolean rawAvailable = rawDAO.updateRawQuantity2(productId, addedQuantity);
//
//        if (!rawAvailable) {
//            // Load lại danh sách sản phẩm để hiện ra cùng với thông báo lỗi
//            List<Product> productList = productDAO.getAllProducts();
//            request.setAttribute("productList", productList);
//
//            request.setAttribute("error", "Không đủ nguyên liệu để tạo thêm sản phẩm.");
//            request.getRequestDispatcher("/view/productmanagement/manageProduct.jsp").forward(request, response);
//            return;
//        }
//
//        // Nếu đủ nguyên liệu, tiếp tục cập nhật số lượng sản phẩm
//        boolean success = productDAO.updateQuantity(productId, addedQuantity);
//
//        if (success) {
//            // Redirect về trang product nếu thành công
//            response.sendRedirect("product");
//        } else {
//
//            // Nếu cập nhật thất bại, load lại danh sách và báo lỗi
//            List<Product> productList = productDAO.getAllProducts();
//            request.setAttribute("productList", productList);
//
//            request.setAttribute("error", "Cập nhật số lượng sản phẩm thất bại.");
//            request.getRequestDispatcher("/view/productmanagement/manageProduct.jsp").forward(request, response);
//        }
//    } catch (Exception e) {
//        e.printStackTrace();
//        response.getWriter().write("Error: " + e.getMessage());
//    }
//}

private void updateQuantity(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int addedQuantity = Integer.parseInt(request.getParameter("addedQuantity"));
 
        RawDAO rawDAO = new RawDAO();
        ProductDAO productDAO = new ProductDAO();
 
        // Check if there are enough raw materials
        boolean rawAvailable = rawDAO.updateRawQuantity2(productId, addedQuantity);
 
        if (!rawAvailable) {
            // Store error message in session instead of request
            HttpSession session = request.getSession();
            session.setAttribute("error", "Không đủ nguyên liệu để tạo thêm sản phẩm.");
            
            // Redirect back to the product listing page
            response.sendRedirect(request.getContextPath() + "/product");
            return;
        }
 
        // If enough raw materials, update product quantity
        boolean success = productDAO.updateQuantity(productId, addedQuantity);
 
        if (!success) {
            // Store error message in session for failed update
            HttpSession session = request.getSession();
            session.setAttribute("error", "Cập nhật số lượng sản phẩm thất bại.");
        }
        
        // Always redirect back to the product page
        response.sendRedirect(request.getContextPath() + "/product?action=list");
        
    } catch (Exception e) {
        e.printStackTrace();
        // Store error in session and redirect
        HttpSession session = request.getSession();
        session.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        response.sendRedirect(request.getContextPath() + "/product?action=list");
    }

}
    // Utility method to extract file name from HTTP header content-disposition
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }

private void loadCategoriesAndRaws(HttpServletRequest request) {
    // Load all categories
    CategoryDAO categoryDAO = new CategoryDAO();
    List<Category> categoryList = categoryDAO.getAllCategories();
    request.setAttribute("categories", categoryList);

    // Load all raw materials
    RawDAO rawDAO = new RawDAO();
    List<Raw> rawList = rawDAO.getAllRaws();
    request.setAttribute("raws", rawList);
}


//Delete Product
private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        int id = Integer.parseInt(request.getParameter("id"));

        // Gọi DAO để xóa sản phẩm theo id
        ProductDAO dao = new ProductDAO();
        dao.deleteProduct(id);

        // Sau khi xóa xong, quay lại trang danh sách sản phẩm
        response.sendRedirect(request.getContextPath() + "/product");
    } catch (NumberFormatException e) {
        e.printStackTrace();
        response.sendRedirect(request.getContextPath() + "/product");
    }
}
}