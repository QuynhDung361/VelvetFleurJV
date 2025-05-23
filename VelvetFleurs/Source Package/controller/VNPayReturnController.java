/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.vnpay.common.Config;
import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author trung
 */
@WebServlet("/vnpay_return")
public class VNPayReturnController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        Map<String, String[]> params = new HashMap<>(request.getParameterMap()); // Create a mutable copy
        params.remove("vnp_SecureHash");

        StringBuilder dataToHash = new StringBuilder();

        // Sort the parameters by key (important for hash verification)
        params.keySet().stream().sorted().forEach(key -> {
            String[] values = params.get(key);
            if (values != null && values.length > 0) {
                String value = values[0];
                if (value != null && !value.isEmpty()) {
                    dataToHash.append(key).append("=")
                            .append(URLEncoder.encode(value, StandardCharsets.UTF_8))
                            .append("&");
                }
            }
        });

        // Remove last "&" if present
        if (dataToHash.length() > 0 && dataToHash.charAt(dataToHash.length() - 1) == '&') {
            dataToHash.setLength(dataToHash.length() - 1);
        }

        String calculatedSecureHash = Config.hmacSHA512(Config.secretKey, dataToHash.toString());

        String resultMessage;
        String resultStatus;

        if (calculatedSecureHash.equals(vnp_SecureHash)) {
            String responseCode = request.getParameter("vnp_ResponseCode");
            String transactionStatus = request.getParameter("vnp_TransactionStatus");

            if ("00".equals(responseCode) && "00".equals(transactionStatus)) {
                OrderDAO orderDAO = new OrderDAO();
                HttpSession session = request.getSession();
                Integer orderId = (Integer) session.getAttribute("orderId");

                if (orderId != null) {
                    orderDAO.updateStatus(orderId, 1); // Mark as paid
                    session.removeAttribute("cart");    // Optional: clear cart
                    resultMessage = "Payment successful!";
                    resultStatus = "success";
                } else {
                    resultMessage = "Order not found in session.";
                    resultStatus = "error";
                }
            } else {
                resultMessage = "Payment failed. Response code: " + responseCode;
                resultStatus = "fail";
            }
        } else {
            resultMessage = "Invalid signature. Possible tampering.";
            resultStatus = "invalid";
        }

        // Forward to JSP with message
        request.setAttribute("message", resultMessage);
        request.setAttribute("status", resultStatus);
        System.out.println("Forwarding to JSP with message: " + resultMessage + ", status: " + resultStatus);
        try {
            request.getRequestDispatcher("/view/common/PaymentResult.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // In log nếu có lỗi trong forward
        }
    }
}
