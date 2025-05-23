<%-- 
    Document   : categoryCreate
    Created on : Apr 21, 2025, 12:31:17 AM
    Author     : ADMIN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm danh mục</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="p-5">
    <div class="container">
        <h2 class="mb-4">Thêm danh mục mới</h2>

        <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <form action="insertCustomer" method="post">
    Họ tên: <input type="text" name="name"><br>
    Email: <input type="email" name="email"><br>
    SĐT: <input type="text" name="phone"><br>
    Địa chỉ: <input type="text" name="address"><br>
    Giới tính: <input type="text" name="gender"><br>
    Ảnh đại diện (URL): <input type="text" name="avatar"><br>
    ID tài khoản: <input type="number" name="accountId"><br>
    <input type="submit" value="Thêm khách hàng">
</form>
    </div>
</body>
</html>
