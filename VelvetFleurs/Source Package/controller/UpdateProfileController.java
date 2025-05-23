package controller;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
//import jakarta.servlet.annotation.MultipartConfig; // giữ lại nếu cần upload file
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import model.Account;
import model.Customer;



//    
//@MultipartConfig(
//    fileSizeThreshold = 1024 * 1024,  // 1MB
//    maxFileSize = 1024 * 1024 * 5,    // 5MB
//    maxRequestSize = 1024 * 1024 * 10 // 10MB
//)
public class UpdateProfileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin tài khoản từ session
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("account");

        if (acc != null) {
            CustomerDAO dao = new CustomerDAO();
            Customer customer = dao.getCustomerByAccountId(acc.getAccountID()); 
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/view/customer/EditProfile.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    int id = Integer.parseInt(request.getParameter("id"));
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String gender = request.getParameter("gender");
    String avatar = request.getParameter("avatar");


    HttpSession session = request.getSession();
    Account acc = (Account) session.getAttribute("account");

    if (acc != null) {
        Customer customer = new Customer(id, fullName, email, phone, address, gender, avatar, acc.getAccountID());

//      Customer customer = new Customer(id, fullName, email, phone, address, gender);
        customer.setAccountId(acc.getAccountID()); 

                if (fullName == null || fullName.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty()) {
            request.setAttribute("message", "Full name and phone number are required.");
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/view/customer/EditProfile.jsp").forward(request, response);
            return;
        }

        if (email != null && !email.trim().isEmpty() &&
            !email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            request.setAttribute("message", "Invalid email format.");
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/view/customer/EditProfile.jsp").forward(request, response);
            return;
        }
                if (!phone.matches("^[0-9]{10}$")) {
            request.setAttribute("message", "Phone number must be exactly 10 digits.");
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("/view/customer/EditProfile.jsp").forward(request, response);
            return;
        }
        CustomerDAO dao = new CustomerDAO();
        boolean success = dao.updateCustomer(customer);

      if (success) {
            request.setAttribute("message", "Update successful!");
        } else {
            request.setAttribute("message", "Update failed. Please try again.");
        }

        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/view/customer/EditProfile.jsp").forward(request, response);
    } else {
        response.sendRedirect("login");
    }
}
}
    



//protected void doPost(HttpServletRequest request, HttpServletResponse response)
//        throws ServletException, IOException {
//
//    request.setCharacterEncoding("UTF-8");
//    response.setCharacterEncoding("UTF-8");
//
//    int id = Integer.parseInt(request.getParameter("id"));
//    String fullName = request.getParameter("fullName");
//    String email = request.getParameter("email");
//    String phone = request.getParameter("phone");
//    String address = request.getParameter("address");
//    String gender = request.getParameter("gender");
//     String avatar = request.getParameter("avatar");
//
//    HttpSession session = request.getSession();
//    Account acc = (Account) session.getAttribute("account");
//
//    if (acc != null) {
//        // Handle avatar upload
//        Part filePart = request.getPart("avatar");
//        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
//
//        String avatarFileName = null;
//        if (fileName != null && !fileName.isEmpty()) {
//            avatarFileName = System.currentTimeMillis() + "_" + fileName;
//            String uploadPath = request.getServletContext().getRealPath("/images/avatar");
////    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
//
//            File uploadDir = new File(uploadPath);
//            if (!uploadDir.exists()) uploadDir.mkdir();
//
//            filePart.write(uploadPath + File.separator + avatarFileName);
//        }
//
//        // Gán avatar nếu có
//        Customer customer = new Customer(id, fullName, email, phone, address, gender);
//       customer.setId(id);
//        customer.setAccountId(acc.getAccountID());
//
//        if (avatarFileName != null) {
//            customer.setAvatar(avatarFileName);
//        } else {
//            // giữ nguyên avatar cũ nếu người dùng không chọn ảnh mới
//            CustomerDAO dao = new CustomerDAO();
//            Customer existing = dao.getCustomerByAccountId(acc.getAccountID());
//            customer.setAvatar(existing.getAvatar());
//        }
//
//        CustomerDAO dao = new CustomerDAO();
//        boolean success = dao.updateCustomer(customer);
//
//        if (success) {
//    request.setAttribute("message", "Cập nhật thành công!");
//
//    // GỌI LẠI CUSTOMER TỪ DB để đảm bảo dữ liệu đầy đủ nhất
//    customer = dao.getCustomerByAccountId(acc.getAccountID());
//} else {
//    request.setAttribute("message", "Cập nhật thất bại!");
//}
//
//// Gán lại customer mới nhất
//request.setAttribute("customer", customer);
//request.getRequestDispatcher("/view/customer/EditProfile.jsp").forward(request, response);
//
//    } else {
//        response.sendRedirect("login");
//    }
//}
//}