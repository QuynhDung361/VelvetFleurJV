<%-- 
    Document   : manageProduct
    Created on : 23 thg 4, 2025, 09:01:03
    Author     : Admin
--%>
<%-- <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Management</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .product-card {
            height: 100%;
            transition: transform 0.2s;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .product-image {
            height: 200px;
            object-fit: cover;
        }
        .action-buttons {
            display: flex;
            gap: 5px;
        }
    </style>
</head>
<body>

    
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
             <% if ("Seller".equals(role) || "Manager".equals(role)) { %>
            <h2>Product Management</h2>
            <a href="${pageContext.request.contextPath}/product?action=showAddForm" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add New Product
            </a>
        </div>
        
        <!-- Alerts for success or error messages -->
        <c:if test="${not empty param.success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${param.success}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
        
        <c:if test="${not empty param.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${param.error}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
        
        <!-- Search form -->
        <form action="${pageContext.request.contextPath}/product" method="get" class="mb-4">
            <input type="hidden" name="action" value="search">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Search products..." name="keyword" value="${keyword}">
                <div class="input-group-append">
                    <button class="btn btn-outline-secondary" type="submit">
                        <i class="fas fa-search"></i> Search
                    </button>
                </div>
            </div>
        </form>
        
        <!-- Product List -->
        <c:if test="${empty products}">
            <div class="alert alert-info">No products found.</div>
        </c:if>
        
        <div class="row">
            <c:forEach items="${products}" var="product">
                <div class="col-md-4 mb-4">
                    <div class="card product-card">
                        <img src="${pageContext.request.contextPath}/${not empty product.image ? product.image : 'images/products/default-product.jpg'}" 
                             class="card-img-top product-image" alt="${product.name}">
                        <div class="card-body">
                            <h5 class="card-title">${product.name}</h5>
                            <p class="card-text">
                                <strong>Price:</strong> $<fmt:formatNumber value="${product.price}" pattern="#,##0.00" />
                            </p>
                            <p class="card-text">
                                <strong>Stock:</strong> ${product.quantity} units
                            </p>
                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/product?action=detail&id=${product.id}" class="btn btn-info btn-sm">
                                    <i class="fas fa-info-circle"></i> Details
                                </a>
                                <a href="${pageContext.request.contextPath}/product?action=showEditForm&id=${product.id}" class="btn btn-warning btn-sm">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="${pageContext.request.contextPath}/product?action=createSimilar&id=${product.id}" class="btn btn-success btn-sm">
                                    <i class="fas fa-clone"></i> Create Similar
                                </a>
                                     <td>
            <button onclick="openPopup(${p.id})">Nhập thêm hàng</button>
        </td>
                                <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteModal${product.id}">
                                    <i class="fas fa-trash"></i> Delete
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Delete Confirmation Modal -->
                <div class="modal fade" id="deleteModal${product.id}" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel${product.id}" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="deleteModalLabel${product.id}">Confirm Delete</h5>
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
            </c:forEach>
                <% } %>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <script>
        // Auto-hide alerts after 5 seconds
        $(document).ready(function() {
            setTimeout(function() {
                $(".alert").alert('close');
            }, 5000);
        });
    </script>
    
    <!-- Popup nhập thêm -->
<div id="popup" style="display:none;">
    <form action="product" method="post">
        <input type="hidden" name="action" value="updateQuantity" />
        <input type="hidden" id="productId" name="productId" />
        <label>Nhập thêm số lượng:</label>
        <input type="number" name="addedQuantity" required />
        <button type="submit">Xác nhận</button>
        <button type="button" onclick="closePopup()">Hủy</button>
    </form>
</div>

<script>
function openPopup(productId) {
    document.getElementById('popup').style.display = 'block';
    document.getElementById('productId').value = productId;
}
function closePopup() {
    document.getElementById('popup').style.display = 'none';
}

</script>
</body>
</html>
--%>
<%--
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String role = (String) session.getAttribute("role");
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Management</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            #popup {
                display: none;
                position: fixed;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -50%);
                background: #fff;
                padding: 20px;
                border: 2px solid #ccc;
                z-index: 9999;
            }
            .overlay {
                display: none;
                position: fixed;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.5);
                z-index: 9998;
            }
        </style>
    </head>
    <body>
        
        <%@ include file="/view/dashboard/sidebar.jsp" %>
        <div style="margin-left: 250px; padding: 20px;">
        <div class="container mt-4">
            <% if ("Seller".equals(role) || "Manager".equals(role)) { %>
            <h2>Product Management</h2>
            <a href="${pageContext.request.contextPath}/product?action=showAddForm" class="btn btn-primary mb-3">
                Thêm sản phẩm mới
            </a>

            <!-- Bảng quản lý sản phẩm -->
            <c:if test="${empty products}">
                <div class="alert alert-info">Không có sản phẩm nào.</div>
            </c:if>
            <!-- Search form -->
            <form action="${pageContext.request.contextPath}/product" method="get" class="mb-4">
                <input type="hidden" name="action" value="search">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search products..." name="keyword" value="${keyword}">
                    <div class="input-group-append">
                        <button class="btn btn-outline-secondary" type="submit">
                            <i class="fas fa-search"></i> Search
                        </button>
                    </div>
                </div>
            </form>
            <table class="table table-bordered table-hover">
                <thead class="thead-light">
                    <tr>
                        <th>Ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng tồn</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${products}" var="product">
                        <tr>
                            <td><img src="${pageContext.request.contextPath}/${not empty product.image ? product.image : 'images/products/default-product.jpg'}" width="80" height="80" alt="${product.name}"/></td>
                            <td>${product.name}</td>
                            <td>$<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></td>
                            <td>${product.quantity}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/product?action=showEditForm&id=${product.id}" class="btn btn-warning btn-sm">Sửa</a>

                                <button type="button" class="btn btn-success btn-sm" onclick="openPopup(${product.id})">Nhập thêm hàng</button>

                                <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteModal${product.id}">Xóa</button>
                            </td>

                        </tr>

                        <!-- Modal xác nhận xóa -->
                    <div class="modal fade" id="deleteModal${product.id}" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel${product.id}" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Xác nhận xóa</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    Bạn có chắc muốn xóa sản phẩm "${product.name}" không?
                                </div>
                                <div class="modal-footer">
                                    <form action="${pageContext.request.contextPath}/product" method="post">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${product.id}">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                        <button type="submit" class="btn btn-danger">Xóa</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                </c:forEach>
                </tbody>
            </table>

            <% }%>
        </div>

        <!-- Popup nhập thêm hàng -->
        <div class="overlay" id="overlay" onclick="closePopup()"></div>
        <div id="popup">
            <form action="product" method="post">
                <input type="hidden" name="action" value="updateQuantity" />
                <input type="hidden" id="productId" name="productId" />
                <div class="form-group">
                    <label>Nhập thêm số lượng:</label>
                    <input type="number" name="addedQuantity" class="form-control" required />
                </div>
                <button type="submit" class="btn btn-primary">Xác nhận</button>
                <button type="button" class="btn btn-secondary" onclick="closePopup()">Hủy</button>
            </form>
        </div>

        <!-- Bootstrap scripts -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>



        <script>
                    function openPopup(productId) {
                        document.getElementById('popup').style.display = 'block';
                        document.getElementById('overlay').style.display = 'block';
                        document.getElementById('productId').value = productId;
                    }
                    function closePopup() {
                        document.getElementById('popup').style.display = 'none';
                        document.getElementById('overlay').style.display = 'none';
                    }
        </script>
        </div>
    </body>
</html>
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
        <title>Product Management</title>
                <link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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

            .overlay {
                display: none;
                position: fixed;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.5);
                z-index: 9998;
            }

            #popup {
                display: none;
                position: fixed;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -50%);
                background: #fff;
                padding: 20px;
                border: 2px solid #ccc;
                z-index: 9999;
                border-radius: 10px;
            }

            
            
        </style>
    </head>
    <body>
        
        <%@ include file="/view/dashboard/sidebar.jsp" %>
        <div style="margin-left: 250px; padding: 20px;">
            <div class="container mt-4">
                <% if ("Seller".equals(role) || "Manager".equals(role)) { %>
                <h2>Product Management</h2>
                <a href="${pageContext.request.contextPath}/product?action=showAddForm" class="btn btn-primary mb-3">
                    Add New Product
                </a>

                <!-- Product Management Table -->
                <c:if test="${empty products}">
                    <div class="alert alert-info">No products available.</div>
                </c:if>

                <!-- Search Form -->
                <form action="${pageContext.request.contextPath}/product" method="get" class="mb-4">
                    <input type="hidden" name="action" value="search">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Search products..." name="keyword" value="${keyword}">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="submit">
                                <i class="fas fa-search"></i> Search
                            </button>
                        </div>
                    </div>
                </form>

                <table id="productTable" class="table table-bordered table-hover">
                    <thead class="thead-light">
                        <tr>
                            <th>Image</th>
                            <th>Product Name</th>
                            <th>Price</th>
                            <th>Quantity in Stock</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${products}" var="product">
                            <tr>
                                <td><img src="${pageContext.request.contextPath}/${not empty product.image ? product.image : 'images/products/default-product.jpg'}" width="80" height="80" alt="${product.name}"/></td>
                                <td>${product.name}</td>
                                <td>$<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></td>
                                <td>${product.quantity}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/product?action=showEditForm&id=${product.id}" class="btn btn-warning btn-sm">Edit</a>

                                    <button type="button" class="btn btn-success btn-sm" onclick="openPopup(${product.id})">Add Stock</button>

                                    <button type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target="#deleteModal${product.id}">Delete</button>
                                </td>
                            </tr>

                            <!-- Modal for Deletion Confirmation -->
                            <div class="modal fade" id="deleteModal${product.id}" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel${product.id}" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Confirm Deletion</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            Are you sure you want to delete the product "${product.name}"?
                                        </div>
                                        <div class="modal-footer">
                                            <form action="${pageContext.request.contextPath}/product" method="post">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${product.id}">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                                <button type="submit" class="btn btn-danger">Delete</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </tbody>
                </table>

                <% } %>
            </div>

            <!-- Popup for Adding Stock -->
            <div class="overlay" id="overlay" onclick="closePopup()"></div>
            <div id="popup">
                <form action="product" method="post">
                    <input type="hidden" name="action" value="updateQuantity" />
                    <input type="hidden" id="productId" name="productId" />
                    <div class="form-group">
                        <label>Enter additional quantity:</label>
                        <input type="number" name="addedQuantity" class="form-control" required />
                    </div>
                    <button type="submit" class="btn btn-primary">Confirm</button>
                    <button type="button" class="btn btn-secondary" onclick="closePopup()">Cancel</button>
                </form>
            </div>
<c:if test="${not empty productList}">
    <c:forEach var="p" items="${productList}">
        <!-- Hiển thị thông tin sản phẩm -->
        <tr>
          
        </tr>
    </c:forEach>
</c:if>

    <c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>


            <!-- Bootstrap and JS scripts -->
            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- Thêm thư viện JavaScript cho DataTables -->
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>

        <script>
            $(document).ready(function() {
                $('#productTable').DataTable({
                    "pageLength": 10, 
                    "ordering": true, 
                    "searching": true 
                });
            });
 </script>
            
             <script>
          
                function openPopup(productId) {
                    document.getElementById('popup').style.display = 'block';
                    document.getElementById('overlay').style.display = 'block';
                    document.getElementById('productId').value = productId;
                }

                function closePopup() {
                    document.getElementById('popup').style.display = 'none';
                    document.getElementById('overlay').style.display = 'none';
                }
            </script>
        </div>
    </body>
</html>
