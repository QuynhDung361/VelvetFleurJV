<%-- 
    Document   : profile
    Created on : Apr 24, 2025, 1:15:24 AM
    Author     : DELL
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Customer"%>
<%
    Customer customer = (Customer) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("/login"); // Chưa đăng nhập
        return;
    }
%>

<h2>Xin chào <%= customer.getFullName() %>!</h2>

<form action="updateProfile" method="post">
    Họ tên: <input type="text" name="fullName" value="<%= customer.getFullName() %>"><br>
    Email: <input type="email" name="email" value="<%= customer.getEmail() %>"><br>
    SĐT: <input type="text" name="phone" value="<%= customer.getPhone() %>"><br>
    Địa chỉ: <input type="text" name="address" value="<%= customer.getAddress() %>"><br>
    Giới tính:
    <select name="gender">
        <option value="Nam" <%= "Nam".equals(customer.getGender()) ? "selected" : "" %>>Nam</option>
        <option value="Nữ" <%= "Nữ".equals(customer.getGender()) ? "selected" : "" %>>Nữ</option>
    </select><br>
    <input type="submit" value="Lưu">
</form>