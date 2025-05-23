<%-- 
    Document   : categoryCreate
    Created on : Apr 21, 2025, 12:31:17 AM
    Author     : ADMIN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Add Category</title>
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

            .btn-success {
                background-color: #d6336c;
                border: none;
            }

            .btn-success:hover {
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

            .alert-danger {
                color: #842029;
                background-color: #f8d7da;
                border-color: #f5c2c7;
            }
        </style>
    </head>
    <body class="p-5">
        <%@ include file="/view/dashboard/sidebar.jsp" %>
        <div style="margin-left: 250px; padding: 20px;">
            <div class="container">
                <h2 class="mb-4">Add New Category</h2>

                <% String error = (String) request.getAttribute("error");
                    if (error != null) { %>
                    <div class="alert alert-danger"><%= error %></div>
                <% } %>

                <form action="category" method="post">
                    <input type="hidden" name="action" value="create">
                    <div class="mb-3">
                        <label class="form-label">Category Name:</label>
                        <input type="text" name="name" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-success">Add</button>
                    <a href="category?action=list" class="btn btn-secondary">Back</a>
                </form>
            </div>
        </div>
    </body>
</html>
