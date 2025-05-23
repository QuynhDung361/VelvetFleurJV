package com.vnpay.common;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.CustomerDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;
import model.CartItem;
import model.Customer;
import model.Order;
import model.OrderItem;

@WebServlet("/ajaxServlet")
public class ajaxServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Config VNPay constants
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String orderType = "other";

        // Lấy các tham số từ form gửi lên
        HttpSession session = req.getSession();
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");

        if (cartItems == null || cartItems.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cart is empty");
            return;
        }

        long totalAmount = 0;
        for (CartItem item : cartItems) {
            totalAmount += item.getProduct().getPrice() * item.getQuantity();
        }
        long amount = totalAmount * 100;
        String bankCode = req.getParameter("bankCode");
        String language = req.getParameter("language");

        // Validate đầu vào
//        if (amountParam == null || amountParam.isEmpty()) {
//            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing amount");
//            return;
//        }
//
//        long amount = Long.parseLong(amountParam) * 100;
        String vnp_TxnRef = Config.getRandomNumber(8);
        String vnp_IpAddr = Config.getIpAddress(req);
        String vnp_TmnCode = Config.vnp_TmnCode;

        // Tạo các tham số
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");

        if (bankCode != null && !bankCode.isEmpty()) {
            vnp_Params.put("vnp_BankCode", bankCode);
        }

        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang: " + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", orderType);
        vnp_Params.put("vnp_Locale", (language != null && !language.isEmpty()) ? language : "vn");
        vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        // Thời gian tạo và hết hạn
        Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = sdf.format(calendar.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        calendar.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = sdf.format(calendar.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        // Sắp xếp key theo thứ tự A-Z
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);

        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();

        for (int i = 0; i < fieldNames.size(); i++) {
            String fieldName = fieldNames.get(i);
            String fieldValue = vnp_Params.get(fieldName);

            if (fieldValue != null && !fieldValue.isEmpty()) {
                hashData.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.UTF_8));
                query.append(URLEncoder.encode(fieldName, StandardCharsets.UTF_8))
                        .append('=')
                        .append(URLEncoder.encode(fieldValue, StandardCharsets.UTF_8));
                if (i < fieldNames.size() - 1) {
                    hashData.append('&');
                    query.append('&');
                }
            }
        }

        // Tạo chuỗi HMAC SHA512
        String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
        query.append("&vnp_SecureHash=").append(vnp_SecureHash);

        // Tạo URL thanh toán
        String paymentUrl = Config.vnp_PayUrl + "?" + query.toString();
        if (amount <= 0) {
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("code", "01"); // Error code for invalid amount
            errorResponse.addProperty("message", "Invalid amount");
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(new Gson().toJson(errorResponse));
            return;
        }
        OrderDAO orderDAO = new OrderDAO();
          Customer customer = (Customer) session.getAttribute("customer");

        CustomerDAO dao = new CustomerDAO();
        ProductDAO product=new ProductDAO();
        if (customer == null) {
            customer = new Customer();
            customer.setFullName(req.getParameter("fullname"));
            customer.setAddress(req.getParameter("address"));
            customer.setPhone(req.getParameter("phone"));
            int customerId = dao.insertCustomer(customer);
            customer.setId(customerId);
        } else {
            customer.setFullName(req.getParameter("fullname"));
            customer.setAddress(req.getParameter("address"));
            customer.setPhone(req.getParameter("phone"));
            dao.updateCustomer(customer);
        }
        String note = req.getParameter("note"); // nếu có

        Order order = new Order();
        order.setCustomerId(customer.getId());
        order.setTotalPrice(totalAmount);
        order.setStatus(0); // Chưa thanh toán
        order.setDeliveryStatus("Not Delivered");
        order.setCreateAt(new Date());
        order.setNote(note);

        int orderId = orderDAO.createOrder(order); // lưu và lấy ID
        order.setId(orderId);

// Tạo OrderItems từ cart
        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem item : cartItems) {
            OrderItem orderItem = new OrderItem();
            product.updateQuantity(item.getProduct().getId(), (-1)*item.getQuantity());
            orderItem.setOrderId(orderId);
            orderItem.setProductId(item.getProduct().getId());
            orderItem.setQuantity(item.getQuantity());
            orderItem.setPrice(item.getProduct().getPrice());
            orderItem.setCreateAt(new Date());
            orderItems.add(orderItem);
        }
        orderDAO.createOrderItems(orderItems);

// Xóa giỏ hàng
        session.removeAttribute("cart");

// Lưu orderId để xử lý sau
        session.setAttribute("orderId", orderId);
        System.out.println("fullname = " + req.getParameter("fullname"));
        System.out.println("address = " + req.getParameter("address"));
        System.out.println("phone = " + req.getParameter("phone"));
        System.out.println("note = " + req.getParameter("note"));
        JsonObject json = new JsonObject();
        json.addProperty("code", "00");
        json.addProperty("message", "success");
        json.addProperty("data", paymentUrl);

// Debugging log
        System.out.println("Generated Payment URL: " + paymentUrl);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(new Gson().toJson(json));
    }
}
