<%-- 
    Document   : dashboard
    Created on : April 27, 2025, 01:57:40
    Author     : sunny
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #ffffff;
            color: #333;
            display: flex;
        }
        .main-content {
            margin-left: 250px;
            padding: 80px;
            width: 100%;
        }

        h2, h3 {
            color: #ff66b2;
        }

        button {
            background-color: #ff66b2;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background-color: #ff3385;
        }

        .logout-button {
            margin-top: 20px;
        }
        
        .widget-container {
            display: flex;
            flex-wrap: wrap;
            gap: 40px;
        }

        a.widget-link, a.widget-link:visited, a.widget-link:hover, a.widget-link:active {
            text-decoration: none;
            color: inherit;
        }

        .widget {
            flex: 1 0 240px;
            height: 200px;
            padding: 20px;
            border-radius: 10px;
            background-color: #f0f0f0;
            text-align: center;
            box-shadow: 2px 2px 5px #ccc;
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .widget:hover {
            background-color: #ffe6f0;
            box-shadow: 4px 4px 15px #bbb;
            transform: translateY(-5px);
        }

        .widget h2 {
            margin: 10px 0;
        }

        .best-sellers {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 20px;
        }

        .best-seller-item {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 10px;
            width: 180px;
            text-align: center;
            box-shadow: 2px 2px 5px #eee;
        }

        .best-seller-item img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-bottom: 10px;
            border-radius: 5px;
        }

        .best-seller-title {
            margin-top: 60px;
        }

        .product-card {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 10px;
            width: 180px;
            text-align: center;
            box-shadow: 2px 2px 5px #eee;
            transition: transform 0.2s;
        }
.product-card:hover {
            transform: scale(1.03);
        }

        .product-card img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

    <%@ include file="/view/dashboard/sidebar.jsp" %>

    <div class="main-content">
        <h1>🌼 System Overview 🌼</h1>

        <div class="widget-container">
            <a class="widget-link" href="orders">
                <div class="widget">🛒<br><h2>${totalOrders}</h2><p>Total Orders</p></div>
            </a>
            <a class="widget-link" href="product">
                <div class="widget">🌸<br><h2>${totalProduct}</h2><p>Flower Products</p></div>
            </a>
            <a class="widget-link" href="/admin/customers">
                <div class="widget">👥<br><h2>${totalCustomers}</h2><p>Customers</p></div>
            </a>
            <a class="widget-link" href="/admin/revenue">
                <div class="widget">💰<br><h2><fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true"/></h2>
                <p>Total Revenue</p></div>
            </a>
            <a class="widget-link" href="/admin/orders/pending">
                <div class="widget">📦<br><h2>${pendingOrders}</h2><p>Pending Orders</p></div>
            </a>
        </div>

        <h3 class="best-seller-title">🔥 Best-Selling Products</h3>
        <div style="display: flex; flex-wrap: wrap; gap: 20px;">
            <c:forEach var="p" items="${bestSellers}">
                <div class="product-card">
                    <img src="${p.image}" alt="${p.name}" />
                    <div><strong>${p.name}</strong></div>
                    <div>Price: ${p.price} VND</div>
                    <div>Sold: ${p.totalSold} items</div>
                </div>
            </c:forEach>
        </div>
    </div>

</body>
</html>