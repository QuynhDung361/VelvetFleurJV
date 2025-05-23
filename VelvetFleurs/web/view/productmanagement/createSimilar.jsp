<%-- 
    Document   : createSimilar
    Created on : 26 thg 4, 2025, 13:05:40
    Author     : sunny
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Similar Product</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background: linear-gradient(to right, #fff0f5, #ffe4e1);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container {
            background: #ffffff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 0px 15px rgba(255, 192, 203, 0.5);
            margin-top: 50px;
        }
        h2 {
            color: #ff69b4;
            font-weight: bold;
            text-align: center;
            margin-bottom: 30px;
        }
        label {
            font-weight: bold;
            color: #d63384;
        }
        .btn-primary {
            background-color: #ff69b4;
            border: none;
        }
        .btn-primary:hover {
            background-color: #ff85c1;
        }
        .btn-secondary {
            background-color: #ffc0cb;
            border: none;
            color: black;
        }
        .btn-secondary:hover {
            background-color: #ffb6c1;
        }
        .raw-material-row {
            border: 1px solid #ffe4e1;
            border-radius: 10px;
            padding: 10px;
            margin-bottom: 10px;
            background: #fffafa;
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
<div class="container">
    <h2>Create Similar Product</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="product" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="add">

        <div class="form-group">
            <label for="name">Product Name:</label>
            <input type="text" class="form-control" id="name" name="name" 
                   value="${product != null ? product.name : ''}" required>
        </div>

        <div class="form-group">
            <label for="price">Price (VND):</label>
            <input type="number" class="form-control" id="price" name="price" step="0.01" 
                   value="${product != null ? product.price : '0.00'}" required>
        </div>

        <div class="form-group">
            <label for="categoryId">Category:</label>
            <select class="form-control" id="categoryId" name="categoryId" required>
                <option value="">-- Select Category --</option>
                <c:forEach items="${categories}" var="category">
                    <option value="${category.id}" ${product.categoryId == category.id ? 'selected' : ''}>
                        ${category.name}
                    </option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="description">Description:</label>
            <textarea class="form-control" id="description" name="description" rows="3">${product != null ? product.description : ''}</textarea>
        </div>

        <div class="form-group">
            <label for="quantity">New Quantity:</label>
            <input type="number" class="form-control" id="quantity" name="quantity" min="0" value="0" required>
        </div>

        <div class="form-group">
            <label for="image">Product Image:</label>
            <c:if test="${product != null && not empty product.image}">
                <div class="mb-2">
                    <img src="${pageContext.request.contextPath}/${product.image}" alt="${product.name}" style="max-width: 150px;">
                    <p>Current Image: ${product.image}</p>
                </div>
            </c:if>
            <input type="file" class="form-control-file" id="image" name="image" accept="image/*">
            <small class="form-text text-muted">Upload new image if you want to replace</small>
        </div>

        <h4 class="mt-4 text-center" style="color: #d63384;">Raw Materials</h4>
        <p class="text-muted text-center">Select raw materials and specify quantity required.</p>

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
                            <c:if test="${raw.expriseDate.time < currentDate.time}">
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

        <div class="form-group text-center mt-4">
            <button type="submit" class="btn btn-primary">Create Product</button>
            <a href="${pageContext.request.contextPath}/product" class="btn btn-secondary ml-2">Cancel</a>
        </div>
    </form>
</div>

<script>
    function toggleQuantityField(checkbox, rawId) {
        const quantityInput = document.getElementById('quantity-' + rawId);
        if (checkbox.checked) {
            quantityInput.disabled = false;
            quantityInput.value = '1';
        } else {
            quantityInput.disabled = true;
            quantityInput.value = '0';
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        const checkboxes = document.querySelectorAll('.raw-checkbox');
        checkboxes.forEach(function(checkbox) {
            const rawId = checkbox.id.split('-')[1];
            const quantityInput = document.getElementById('quantity-' + rawId);
            if (checkbox.checked) {
                quantityInput.disabled = false;
            } else {
                quantityInput.disabled = true;
                quantityInput.value = '0';
            }
        });
    });
</script>

</body>
</html>
