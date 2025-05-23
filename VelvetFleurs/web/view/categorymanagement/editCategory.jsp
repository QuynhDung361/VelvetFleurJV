<%-- 
    Document   : editCategory
    Created on : Apr 21, 2025, 12:33:15 AM
    Author     : ADMIN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Category" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Category</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }

        h2 {
            color: #d6336c;
            text-align: center;
        }

        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: auto;
            margin-top: 50px;
        }

        label {
            color: #d6336c;
            font-weight: bold;
        }

        .btn-primary {
            background-color: #d6336c;
            border: none;
        }

        .btn-primary:hover {
            background-color: #c2185b;
        }

        .btn-secondary {
            background-color: #ffdeeb;
            color: #d6336c;
            border: none;
        }

        .btn-secondary:hover {
            background-color: #f8bbd0;
        }
    </style>
</head>
<body class="p-5">
    <%@ include file="/view/dashboard/sidebar.jsp" %>
    <div style="margin-left: 250px; padding: 20px;">
        <div class="container">
            <h2 class="mb-4">Edit Category</h2>

            <form action="category" method="post">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="id" value="<%= ((Category) request.getAttribute("category")).getId() %>">
                <div class="mb-3">
                    <label class="form-label">Category Name:</label>
                    <input type="text" name="name" class="form-control" 
                           value="<%= ((Category) request.getAttribute("category")).getName() %>" required>
                </div>
                <button type="submit" class="btn btn-primary">Update</button>
                <a href="category?action=list" class="btn btn-secondary">Back</a>
            </form>
        </div>
    </div>
</body>
</html>
