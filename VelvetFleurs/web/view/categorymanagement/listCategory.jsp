


<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Category" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Management - Flower Shop Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    
</head>
<body>
    <%@ include file="/view/dashboard/sidebar.jsp" %>
    
    <div style="margin-left: 250px; padding: 20px;">
        <div class="container my-5">
            <h2 class="mb-4">Category List</h2>

            <!-- Display Success Message -->
            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-success">${sessionScope.message}</div>
                <c:remove var="message"/>
            </c:if>

            <!-- Form for Add/Edit Category -->
            <c:if test="${showForm == 'create' || showForm == 'edit'}">
                <div class="form-container">
                    <form action="category" method="post">
                        <input type="hidden" name="action" value="${showForm == 'edit' ? 'edit' : 'create'}">
                        <c:if test="${showForm == 'edit'}">
                            <input type="hidden" name="id" value="${editCategory.id}">
                        </c:if>
                        <div class="mb-3">
                            <label for="name" class="form-label">Category Name</label>
                            <input type="text" class="form-control" name="name" value="${showForm == 'edit' ? editCategory.name : ''}" required>
                        
                        <button type="submit" class="btn btn-success" style="margin-top: 1rem;" >${showForm == 'edit' ? 'Update' : 'Add New'}</button>
                    </form>
                </div>
            </c:if>

            <!-- Add New Category Button -->
            <a href="category?action=create" class="btn btn-success mb-3">+ Add New</a>

            <!-- Category List Table -->
            <div class="table-responsive">
                <table id="categoryTable" class="table table-striped table-bordered text-center">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Category Name</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="category" items="${categories}">
                            <tr>
                                <td>${category.id}</td>
                                <td>${category.name}</td>
                                <td>
                                    <a href="category?action=edit&id=${category.id}" class="btn btn-primary btn-sm">Edit</a>
                                    <a href="category?action=delete&id=${category.id}" class="btn btn-danger btn-sm"
                                       onclick="return confirm('Are you sure you want to delete this category?');">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <%-- Toast Message --%>
        <c:if test="${not empty sessionScope.message}">
            <div id="toast" style="position: fixed; top: 20px; right: 20px; color: white; padding: 12px 24px; border-radius: 8px; z-index: 9999;">
                ${sessionScope.message}
            </div>

            <script>
                setTimeout(() => {
                    const toast = document.getElementById('toast');
                    if (toast) toast.remove();
                }, 3000);
            </script>
        </c:if>

    </div>

    <!-- DataTables JS -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#categoryTable').DataTable({
                pageLength: 10
            });
        });
    </script>
</body>
</html>
