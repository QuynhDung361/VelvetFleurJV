<%-- 
    Document   : sidebar
    Created on : Apr 30, 2025, 8:05:34?AM
    Author     : trung
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <style>
/*         Sidebar styles 
        .sidebar {
            width: 250px;
            background-color: #f4f4f4;
            padding-top: 80px;
            
            position: fixed;
            height: 100%;
            left: 0;
            position: fixed;
          top: 0;
           height: 100vh;
        background-color: #f8f9fa;
          
        }

        .sidebar a {
            text-decoration: none;
            color: #ff66b2;
            padding: 12px 15px;
            display: block;
            font-weight: bold;
            border-radius: 5px;
        }

        .sidebar a:hover {
            background-color: #ffccf2;
            color: white;
        }*/
.sidebar {
    width: 250px;
    background-color: #f4f4f4;
    padding-top: 80px;
    position: fixed;
    top: 0;
    left: 0;
    height: 100vh;
}

.sidebar a {
    text-decoration: none;
    color: #ff66b2;
    padding: 12px 15px;
    display: block;
    font-weight: bold;
    border-radius: 5px;
}

.sidebar a:hover {
    background-color: #ffccf2;
    color: white;
}

    </style>
</head>

<body>

        <%@ include file="/view/dashboard/Header-manage.jsp" %>
  <div style="padding-top: 80px;"> <!-- Gi? s? header cao 80px -->
        <!-- N?i dung chính ? ?ây -->
   
<!-- Sidebar -->
<div class="sidebar">
    <h2 style="text-align: center; color: #ff66b2; padding-top: 30px">Dashboard</h2>

    <c:if test="${sessionScope.role == 'Admin'}">
        <a href="${pageContext.request.contextPath}/account">Manage User</a>
    </c:if>

    <c:if test="${sessionScope.role == 'Manager'}">
                <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>

        <a href="${pageContext.request.contextPath}/product">Manage Products</a>
        <a href="${pageContext.request.contextPath}/category">Manage Categories</a>
        <a href="${pageContext.request.contextPath}/raw">Manage Raw</a>
        <a href="${pageContext.request.contextPath}/account">Manage Staff</a>
         <a href="${pageContext.request.contextPath}/customermanagement">Manage Customer</a>
        <a href="${pageContext.request.contextPath}/orders">View Orders</a>
    </c:if>

    <c:if test="${sessionScope.role == 'Seller'}">
        <a href="${pageContext.request.contextPath}/raw">Management Raw</a>
        <a href="${pageContext.request.contextPath}/product">Add Product</a>
        <a href="${pageContext.request.contextPath}/orders">Manage Orders</a>
    </c:if>

    <%--<c:if test="${sessionScope.role == 'Customer'}">--%>
        <!--<a href="${pageContext.request.contextPath}/shopProducts.jsp">Shop Products</a>-->
        <!--<a href="${pageContext.request.contextPath}/viewOrders.jsp">View My Orders</a>-->
    <%--</c:if>--%>
    <c:if test="${not empty sessionScope.account}">   
        <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
    </c:if>
    <c:if test="${empty sessionScope.role}">
        <a href="${pageContext.request.contextPath}/login">Login</a>
    </c:if>
</div>
     </div>
</body>
