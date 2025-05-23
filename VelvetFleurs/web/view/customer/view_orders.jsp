<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Order</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
/*            padding-top: 50px;  To make room for fixed header */
        }
        

          .page-container {
                max-width: 1100px;
                margin: 0 auto;
                padding: 20px;
            }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #343a40;
            padding-top: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 15px;
            text-align: center;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        td {
            background-color: #f2f2f2;
            font-size: 14px;
        }
        .table-container {
            max-width: 1100px;
            margin: 0 auto;
        }
        .no-orders-message {
            text-align: center;
            font-size: 18px;
            color: #6c757d;
        }
        
        .footer {
            margin-top: auto;
/*            background-color: #f1f1f1;*/
            padding: 10px 0;
            text-align: center;
        }
        
        

    </style>
</head>
<body>

        <%@ include file="/view/components/Header.jsp" %>
    

    <div class="page-container">
        <h2>Your Orders</h2>

        <form method="get" action="view-order" class="row g-3 mb-4">
    <div class="col-md-3">
        <input type="text" name="search" class="form-control" placeholder="Search by note or ID" value="${param.search}">
    </div>
    <div class="col-md-3">
        <select name="status" class="form-select">
            <option value="">All Payment Status</option>
            <option value="0" ${param.status == '0' ? 'selected' : ''}>Unpaid</option>
            <option value="1" ${param.status == '1' ? 'selected' : ''}>Paid</option>
<!--            <option value="2" ${param.status == '2' ? 'selected' : ''}>Cancelled</option>-->
        </select>
    </div>
    <div class="col-md-3">
        <select name="deliveryStatus" class="form-select">
            <option value="">All Delivery Status</option>
<!--            <option value="Pending" ${param.deliveryStatus == 'Pending' ? 'selected' : ''}>Pending</option>
            <option value="Shipping" ${param.deliveryStatus == 'Shipping' ? 'selected' : ''}>Shipping</option>-->
            <option value="Delivered" ${param.deliveryStatus == 'Delivered' ? 'selected' : ''}>Delivered</option>
            <option value="Not Delivered" ${param.deliveryStatus == 'Not Delivered' ? 'selected' : ''}>Not Delivered</option>
<!--            <option value="Cancelled" ${param.deliveryStatus == 'Cancelled' ? 'selected' : ''}>Cancelled</option>-->
        </select>
    </div>
    <div class="col-md-3">
<button type="submit" class="btn w-100" style="background-color: #f06292; color: white; border: none;">Filter</button>
    </div>
</form>

        <c:choose>
            <c:when test="${empty orders}">
                <p class="no-orders-message">You don't have any orders yet.</p>
            </c:when>
            <c:otherwise>
                <div class="table-container">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Total Price</th>
                                <th>Status</th>
                                <th>Created At</th>
                                <th>Delivery Status</th>
                                <th>Notes</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>${order.id}</td>
                                    <td><fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,###"/> VND</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.status == 0}">Unpaid</c:when>
                                            <c:when test="${order.status == 1}">Paid</c:when>
                                            <c:when test="${order.status == 2}">Cancelled</c:when>
                                            <c:otherwise>Unknown</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${order.createAt}</td>
                                    <td>${order.deliveryStatus}</td>
                                    <td>${order.note}</td>
                                    <td>
                                        <a href="vieworderdetails?id=${order.id}" class="btn btn-info btn-sm" style="background-color: #f06292; color: white; border: none;">View Details</a>
                                    <%--    <c:if test="${order.status == 0}">
                                            <a href="cancelorder?id=${order.id}" class="btn btn-danger btn-sm">Cancel</a>
                                        </c:if> . --%>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <footer class="footer">
        <%@ include file="/view/components/Footer.jsp" %>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
