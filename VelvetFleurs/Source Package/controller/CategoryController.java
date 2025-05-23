package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import model.Product;

@WebServlet(name = "CategoryController", urlPatterns = {"/category"})
public class CategoryController extends HttpServlet {

    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect("login");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"Seller".equalsIgnoreCase(role) && !"Manager".equalsIgnoreCase(role)) {
            response.sendRedirect("home");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "create":
                showInlineCreateForm(request, response);
                break;
            case "edit":
                showInlineEditForm(request, response);
                break;
            case "delete":
                deleteCategory(request, response);
                break;
            default:
                listCategories(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "create":
                insertCategory(request, response);
                break;
            case "edit":
                updateCategory(request, response);
                break;
            default:
                response.sendRedirect("category?action=list");
                break;
        }
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/view/categorymanagement/listCategory.jsp").forward(request, response);
    }

    private void showInlineCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("showForm", "create");
        listCategories(request, response);
    }

    private void showInlineEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Category category = categoryDAO.getCategoryById(id);
        request.setAttribute("showForm", "edit");
        request.setAttribute("editCategory", category);
        listCategories(request, response);
    }

    private void insertCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String name = request.getParameter("name").trim();

        // Validate category name
        if (name.isEmpty()) {
            request.getSession().setAttribute("message", "Tên danh mục không được để trống!");
            response.sendRedirect("category?action=create");
            return;
        }

        if (name.matches(".*\\s.*")) {
            request.getSession().setAttribute("message", "Tên danh mục không được chứa khoảng trắng.");
            response.sendRedirect("category?action=create");
            return;
        }

        if (categoryDAO.getCategoryByName(name) != null) {
            request.getSession().setAttribute("message", "Danh mục với tên này đã tồn tại!");
            response.sendRedirect("category?action=create");
            return;
        }

        Category newCategory = new Category();
        newCategory.setName(name);
        categoryDAO.addCategory(newCategory);

        request.getSession().setAttribute("message", "Thêm danh mục thành công!");
        response.sendRedirect("category?action=list");
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name").trim();

        // Validate category name
        if (name.isEmpty()) {
            request.getSession().setAttribute("message", "Tên danh mục không được để trống!");
            response.sendRedirect("category?action=edit&id=" + id);
            return;
        }

        if (name.matches(".*\\s.*")) {
            request.getSession().setAttribute("message", "Tên danh mục không được chứa khoảng trắng.");
            response.sendRedirect("category?action=edit&id=" + id);
            return;
        }

        Category category = categoryDAO.getCategoryById(id);
        if (category != null) {
            category.setName(name);
            categoryDAO.updateCategory(category);

            request.getSession().setAttribute("message", "Cập nhật danh mục thành công!");
            response.sendRedirect("category?action=list");
        } else {
            request.getSession().setAttribute("message", "Danh mục không tồn tại!");
            response.sendRedirect("category?action=list");
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        categoryDAO.deleteCategory(id);
        request.getSession().setAttribute("message", "Xóa danh mục thành công!");
        response.sendRedirect("category?action=list");
    }

//    private void viewCategoryProducts(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        int categoryId = Integer.parseInt(request.getParameter("id"));
//        Category category = categoryDAO.getCategoryById(categoryId);
//        List<Product> products = productDAO.getProductsByCategoryId(categoryId);
//        request.setAttribute("category", category);
//        request.setAttribute("products", products);
//        request.getRequestDispatcher("/view/categorymanagement/listCategory.jsp").forward(request, response);
//    }
}
