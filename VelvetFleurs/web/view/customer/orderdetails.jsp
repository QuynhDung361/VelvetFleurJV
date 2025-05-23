<%-- 
    Document   : orderdetails
    Created on : 28 thg 4, 2025, 17:51:40
    Author     : sunny
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: Arial, sans-serif;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }
            .container {
                flex: 1;
                /*            margin-top: 10px;*/
            }
            h2 {
                text-align: center;
                margin-bottom: 30px;
                color: #343a40;
            }
            th {
                background-color: #007bff;
                color: white;
                text-align: center;
            }
            td {
                background-color: #f2f2f2;
                text-align: center;
                vertical-align: middle;
            }
            .product-img {
                width: 80px;
                height: auto;
                object-fit: cover;
                border-radius: 5px;
            }
            .footer {
                margin-top: auto;
            }
        </style>
    </head>
    <body>
        <%@ include file="/view/components/Header.jsp" %>

        <div class="container">
            <h2>Order Details - Order ID: ${orderId}</h2>

            <c:choose>
                <c:when test="${empty orderItems}">
                    <p class="text-center text-muted">No items found for this order.</p>
                </c:when>
                <c:otherwise>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Product Image</th>

                                <!--                        <th>Item ID</th>-->
                                <th>Product Name</th>
                                <th>Quantity</th>
                                <th>Price (VND)</th>
                                <th>Total</th>
                                <!--                        <th>Created At</th>-->
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${orderItems}">
                                <tr>
        <!--                            <td>${item.id}</td>-->
                                    <td>
                                        <!--                                        <img src="images/products/birthday_colorful.jpg" alt="Product Image" class="product-img"/>-->
                                        <img src="${pageContext.request.contextPath}/${item.imageUrl}" width="80" height="80" alt="Product Image"/>

                                    <td>${item.productName}</td>
                                    <td>${item.quantity}</td>
                                    <td><fmt:formatNumber value="${item.price}" type="number" pattern="#,###"/></td>
                                    <td><fmt:formatNumber value="${item.price * item.quantity}" type="number" pattern="#,###"/></td>
        <!--                            <td>${item.createAt}</td>-->
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>

            <div class="text-center mt-4">
                <a href="view-order" class="btn btn-secondary">Back to Orders</a>
            </div>
        </div>

        <div class="footer">
            <%@ include file="/view/components/Footer.jsp" %>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
