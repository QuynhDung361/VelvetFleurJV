<%-- 
    Document   : createProduct
    Created on : Apr 22, 2025, 09:16:09 AM
    Author     : ADMIN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String role = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>${product != null && product.id > 0 ? 'Edit' : (isSimilar ? 'Create Similar' : 'Add')} Product</title>
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
            <h2>${product != null && product.id > 0 ? 'Edit' : (isSimilar ? 'Create Similar' : 'Add')} Product</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="product" method="post"  class="needs-validation"  enctype="multipart/form-data">
                <input type="hidden" name="action" value="${product != null && product.id > 0 ? 'edit' : 'add'}">
                <c:if test="${product != null && product.id > 0}">
                    <input type="hidden" name="id" value="${product.id}">
                </c:if>

<!--                <div class="form-group">
                    <label for="name">Product Name:</label>
                    <input type="text" class="form-control" id="name" name="name" value="${product != null ? product.name : ''}" required>
                </div>-->
<!--<div class="form-group">
  <label for="name">Product Name: <span class="text-danger">*</span></label>
  <input type="text" class="form-control" id="name" name="name" value="${product != null ? product.name : ''}" required>
  <div class="invalid-feedback">Please enter the product name.</div>
</div>-->
<div class="form-group">
    <label for="name">Product Name: <span class="text-danger">*</span> </label>
    <input type="text" class="form-control" id="name" name="name"
           value="${product != null ? product.name : ''}"
           required pattern=".*[^ ].*"
           oninvalid="this.setCustomValidity('Product name cannot be empty or only spaces')"
           oninput="this.setCustomValidity('')">
</div>


                <div class="form-group">
                    <label for="price">Price:</label>
<!--                    <input type="number" class="form-control" id="price" name="price" step="0.01" value="${product != null ? product.price : '0.00'}" required>-->
                

                
                <input type="number" class="form-control" id="price" name="price" step="0.01"
       value="${product != null ? product.price : '0.00'}"
       required min="0"
       oninvalid="this.setCustomValidity('Please enter a valid price (0 or greater)')"
       oninput="this.setCustomValidity('')">

</div>

                <div class="form-group">
                    <label for="categoryId">Category:</label>
                    <select class="form-control" id="categoryId" name="categoryId" required>
                        <option value="">Select a category</option>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.id}" ${product != null && product.categoryId == category.id ? 'selected' : ''}>${category.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="description">Description:</label>
<!--                    <textarea class="form-control" id="description" name="description" rows="3">${product != null ? product.description : ''}</textarea>-->
                <textarea class="form-control" id="description" name="description" rows="3"
          required pattern=".*[^ ].*"
          oninvalid="this.setCustomValidity('Description cannot be empty or only spaces')"
          oninput="this.setCustomValidity('')">${product != null ? product.description : ''}</textarea>

                
                </div>

                <div class="form-group">
                    <label for="quantity">Initial Quantity:</label>
<!--                    <input type="number" class="form-control" id="quantity" name="quantity" value="${product != null ? product.quantity : '0'}" min="0" required>-->
                
               
<input type="number" class="form-control" id="quantity" name="quantity"
       value="${product != null ? product.quantity : '0'}"
       min="0" required
       oninvalid="this.setCustomValidity('Please enter a quantity (0 or greater)')"
       oninput="this.setCustomValidity('')">
 </div>
                <div class="form-group">
                    <label for="image">Product Image:</label>
                    <c:if test="${product != null && not empty product.image}">
                        <div class="mb-2">
                            <img src="${pageContext.request.contextPath}/${product.image}" alt="${product.name}" style="max-width: 150px; max-height: 150px;">
                            <p>Current Image: ${product.image}</p>
                        </div>
                    </c:if>
                    <input type="file" class="form-control-file" id="image" name="image" accept="image/*">
                    <small class="form-text text-muted">Leave empty to keep current image (if editing)</small>
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

                <div class="form-group mt-4">
                    <button type="submit" class="btn btn-primary">${product != null && product.id > 0 ? 'Update' : 'Create'} Product</button>
                    <a href="${pageContext.request.contextPath}/product" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
            </div>
        <% }%>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.min.css"></script>
<script>
  // Bootstrap form validation
  (function () {
    'use strict';
    window.addEventListener('load', function () {
      var forms = document.getElementsByClassName('needs-validation');
      Array.prototype.filter.call(forms, function (form) {
        form.addEventListener('submit', function (event) {
          if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
          }
          form.classList.add('was-validated');
        }, false);
      });
    }, false);
  })();
</script>
 <script>
document.querySelector('form').addEventListener('submit', function (e) {
    const nameInput = document.getElementById('name');
    const descriptionInput = document.getElementById('description');

    if (nameInput.value.trim() === '') {
        nameInput.setCustomValidity('Product name cannot be empty or only spaces');
        nameInput.reportValidity();
        e.preventDefault();
    }

    if (descriptionInput.value.trim() === '') {
        descriptionInput.setCustomValidity('Description cannot be empty or only spaces');
        descriptionInput.reportValidity();
        e.preventDefault();
    }
});

</script>
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
                               document.addEventListener('DOMContentLoaded', function () {
                                   // Set current date for expiration checks
                                   const currentDate = new Date();

                                   // Initialize all checkboxes
                                   const checkboxes = document.querySelectorAll('.raw-checkbox');
                                   checkboxes.forEach(function (checkbox) {
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

