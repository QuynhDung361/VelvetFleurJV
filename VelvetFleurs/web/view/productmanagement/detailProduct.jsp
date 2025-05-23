<%-- 
    Document   : detailProduct
    Created on : Apr 21, 2025, 3:40:09 PM
    Author     : ADMIN
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Details - ${product.name}</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .product-image {
            max-height: 400px;
            object-fit: contain;
        }
        .raw-material-item {
            border-bottom: 1px solid #eee;
            padding: 10px 0;
        }
        .raw-material-item:last-child {
            border-bottom: none;
        }
        .badge-expired {
            background-color: #dc3545;
        }
        .badge-low {
            background-color: #ffc107;
            color: #212529;
        }
    </style>
</head>
<body>
    <%@ include file="/view/dashboard/sidebar.jsp" %>
    <div class="container mt-4">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/product">Products</a></li>
                <li class="breadcrumb-item active" aria-current="page">Product Details</li>
            </ol>
        </nav>
        
        <c:if test="${empty product}">
            <div class="alert alert-warning">Product not found!</div>
            <a href="${pageContext.request.contextPath}/product" class="btn btn-primary">Back to Products</a>
        </c:if>
        
        <c:if test="${not empty product}">
            <div class="card">
                <div class="row no-gutters">
                    <div class="col-md-5">
                        <img src="${pageContext.request.contextPath}/${not empty product.image ? product.image : 'images/products/default-product.jpg'}" 
                             class="card-img product-image" alt="${product.name}">
                    </div>
                    <div class="col-md-7">
                        <div class="card-body">
                            <h2 class="card-title">${product.name}</h2>
                            <p class="card-text">
                                <strong>Price:</strong> $<fmt:formatNumber value="${product.price}" pattern="#,##0.00" />
                            </p>
                            <p class="card-text">
                                <strong>Category:</strong> ${categoryName}
                            </p>
                            <p class="card-text">
                                <strong>Stock:</strong> ${product.quantity} units
                            </p>
                            <p class="card-text">
                                <strong>Created:</strong> <fmt:formatDate value="${product.createAt}" pattern="yyyy-MM-dd" />
                            </p>
                            <hr>
                            <h5>Description:</h5>
                            <p class="card-text">${product.description}</p>
                            
                            <div class="mt-4">
                                <a href="${pageContext.request.contextPath}/product?action=showEditForm&id=${product.id}" class="btn btn-warning">
                                    <i class="fas fa-edit"></i> Edit Product
                                </a>
                                <a href="${pageContext.request.contextPath}/product?action=createSimilar&id=${product.id}" class="btn btn-success">
                                    <i class="fas fa-clone"></i> Create Similar
                                </a>
                                <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteModal">
                                    <i class="fas fa-trash"></i> Delete
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Raw Materials Section -->
            <div class="card mt-4">
                <div class="card-header">
                    <h4>Raw Materials</h4>
                </div>
                <div class="card-body">
                    <c:if test="${empty product.rawMaterials}">
                        <p class="text-muted">No raw materials associated with this product.</p>
                    </c:if>
                    
                    <c:if test="${not empty product.rawMaterials}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Quantity Used</th>
                                        <th>Available Stock</th>
                                        <th>Expiration Date</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${product.rawMaterials}" var="raw">
                                        <c:set var="quantityUsed" value="0" />
                                        <c:forEach items="${productRawQuantities}" var="entry">
                                            <c:if test="${entry.key.id == raw.id}">
                                                <c:set var="quantityUsed" value="${entry.value}" />
                                            </c:if>
                                        </c:forEach>
                                        
                                        <tr>
                                            <td>${raw.name}</td>
                                            <td>${quantityUsed} units</td>
                                            <td>${raw.quantity} units</td>
                                            <td><fmt:formatDate value="${raw.expriseDate}" pattern="yyyy-MM-dd" /></td>
                                            <td>
                                                <c:if test="${raw.expriseDate.time < currentDate.time}">
                                                    <span class="badge badge-expired">Expired</span>
                                                </c:if>
                                                <c:if test="${raw.quantity < quantityUsed}">
                                                    <span class="badge badge-low">Insufficient</span>
                                                </c:if>
                                                <c:if test="${raw.expriseDate.time >= currentDate.time && raw.quantity >= quantityUsed}">
                                                    <span class="badge badge-success">OK</span>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Production form -->
                        <div class="mt-4">
                            <h5>Produce Product</h5>
                            <form action="${pageContext.request.contextPath}/product" method="post" class="form-inline">
                                <input type="hidden" name="action" value="produce">
                                <input type="hidden" name="id" value="${product.id}">
                                <div class="form-group mr-2">
                                    <label for="productionQuantity" class="mr-2">Quantity:</label>
                                    <input type="number" class="form-control" id="productionQuantity" name="productionQuantity" min="1" value="1" required>
                                </div>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-industry"></i> Produce
                                </button>
                            </form>
                        </div>
                    </c:if>
                </div>
            </div>
            
            <!-- Delete Confirmation Modal -->
            <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            Are you sure you want to delete product "${product.name}"?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <form action="${pageContext.request.contextPath}/product" method="post">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${product.id}">
                                <button type="submit" class="btn btn-danger">Delete</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Set current date for expiration checks
            const currentDate = new Date();
            
            // Initialize any JavaScript functionality if needed
        });
    </script>
</body>
</html>