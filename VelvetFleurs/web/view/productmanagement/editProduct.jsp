<%-- 
    Document   : editProduct
    Created on : Apr 22, 2025, 12:28:50 PM
    Author     : ADMIN
--%>

<%@page import="model.Product"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String role = (String) session.getAttribute("role");
%>

<%
    Product product = (Product) request.getAttribute("product");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Product 3 Fleur</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .raw-material-row {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #eee;
            border-radius: 5px;
        }
        .raw-material-row:hover {
            background-color: #f9f9f9;
        }
        .expired {
            color: red;
            font-weight: bold;
        }
        .low-quantity {
            color: orange;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <%@ include file="/view/dashboard/sidebar.jsp" %>
        <div style="margin-left: 250px; padding: 20px;">

    <% if ("Admin".equals(role) || "Manager".equals(role)) { %>
    <div class="container mt-4">
        <h2>Edit Product</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <form action="product" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" value="${product.id}">
            
            <div class="form-group">
                <label for="name">Product Name:</label>
                <input type="text" class="form-control" id="name" name="name" value="${product.name}" required>
            </div>
            
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" class="form-control" id="price" name="price" step="0.01" value="${product.price}" required>
            </div>
            
            <div class="form-group">
                <label for="categoryId">Category:</label>
                <select class="form-control" id="categoryId" name="categoryId" required>
                    <option value="">Select a category</option>
                    <c:forEach items="${categories}" var="category">
                        <option value="${category.id}" ${product.categoryId == category.id ? 'selected' : ''}>${category.name}</option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-group">
                <label for="description">Description:</label>
                <textarea class="form-control" id="description" name="description" rows="3">${product.description}</textarea>
            </div>
            
            <div class="form-group">
                <label for="quantity">Initial Quantity:</label>
                <input type="number" class="form-control" id="quantity" name="quantity" value="${product.quantity}" min="0" required>
            </div>
            
            <div class="form-group">
                <label for="image">Product Image:</label>
                <c:if test="${product.image != null && not empty product.image}">
                    <div class="mb-2">
                        <img src="${pageContext.request.contextPath}/${product.image}" alt="${product.name}" style="max-width: 150px; max-height: 150px;">
                        <p>Current Image: ${product.image}</p>
                    </div>
                </c:if>
                <input type="file" class="form-control-file" id="image" name="image" accept="image/*">
                <small class="form-text text-muted">Leave empty to keep the current image (if editing)</small>
            </div>

            <h4 class="mt-4">Raw Materials</h4>
            <p class="text-muted">Select the raw materials used in this product and specify the quantity required for each.</p>

            <div id="rawMaterialsContainer">
                <c:forEach items="${rawMaterials}" var="raw">
                    <c:set var="isSelected" value="false"/>
                    <c:set var="selectedQuantity" value="0"/>
                    <c:forEach items="${productRawQuantities}" var="entry">
                        <c:if test="${entry.key.id == raw.id}">
                            <c:set var="isSelected" value="true"/>
                            <c:set var="selectedQuantity" value="${entry.value}"/>
                        </c:if>
                    </c:forEach>

                    <div class="raw-material-row form-row align-items-center">
                        <div class="col-md-1 text-center">
                            <input type="checkbox" class="form-check-input raw-checkbox" name="rawId" value="${raw.id}"
                                   id="raw-${raw.id}" ${isSelected ? 'checked' : ''}
                                   onchange="toggleQuantityField(this, ${raw.id})">
                        </div>
                        <div class="col-md-4">
                            <label for="raw-${raw.id}">
                                ${raw.name}
                                <c:if test="${raw.expriseDate != null && raw.expriseDate.time < currentDate.time}">
                                    <span class="expired">(EXPIRED)</span>
                                </c:if>
                                <c:if test="${raw.quantity < 10}">
                                    <span class="low-quantity">(Low Stock: ${raw.quantity} left)</span>
                                </c:if>
                            </label>
                        </div>
                        <div class="col-md-3">
                            <input type="number" class="form-control quantity-input" name="rawQuantity"
                                   id="quantity-${raw.id}" min="0"
                                   value="${selectedQuantity}" ${!isSelected ? 'disabled' : ''}>
                        </div>
                        <div class="col-md-4">
                            <small>Available: ${raw.quantity} units</small>
                            <c:if test="${raw.expriseDate != null}">
                                <br><small>Expires: <fmt:formatDate value="${raw.expriseDate}" pattern="yyyy-MM-dd"/></small>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="form-group mt-4">
                <button type="submit" class="btn btn-primary">Update Product</button>
                <a href="${pageContext.request.contextPath}/product" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
        </div>
    <% } else { %>
        <div class="container mt-4">
            <div class="alert alert-danger">You do not have permission to access this page.</div>
        </div>
    <% } %>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        // Function to toggle the quantity input field based on checkbox state
        function toggleQuantityField(checkbox, rawId) {
            const quantityInput = document.getElementById('quantity-' + rawId);
            if (checkbox.checked) {
                quantityInput.disabled = false;
                quantityInput.value = '1'; // Default value when selected
            } else {
                quantityInput.disabled = true;
                quantityInput.value = '0';
            }
        }
        
        // Initialize form on load
        document.addEventListener('DOMContentLoaded', function() {
            // Set current date for expiration checks
            const currentDate = new Date();
            
            // Initialize all checkboxes
            const checkboxes = document.querySelectorAll('.raw-checkbox');
            checkboxes.forEach(function(checkbox) {
                const rawId = checkbox.id.split('-')[1];
                if (checkbox.checked) {
                    document.getElementById('quantity-' + rawId).disabled = false;
                } else {
                    document.getElementById('quantity-' + rawId).disabled = true;
                    document.getElementById('quantity-' + rawId).value = '0';
                }
            });
        });
    </script>
</body>
</html>
