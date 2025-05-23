<%-- 
    Document   : Header
    Created on : Apr 21, 2025, 1:13:35?AM
    Author     : duongngo21
--%>

<%@page import="model.CartItem"%>
<%@page import="java.util.List"%>
<%@page import="model.Customer"%>

<%
    Customer loggedInUser = (Customer) session.getAttribute("customer");
   

%>
<%
    // L?y cart t? session
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    int cartCount = (cart != null) ? cart.size() : 0;
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<style>


    body {
        margin: 0;
        padding: 0;
    }

    header {
        position: sticky;
        top: 0;
        z-index: 1000;
        background-color: white;
    }



    .logo {
        display: flex;
        align-items: center;
    }

    .logo img {
        height: 50px;
        margin-right: 10px;
    }

    .logo-text {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--primary-color);
    }

    .mobile-menu {
        display: none;
        font-size: 1.5rem;
        cursor: pointer;
    }
    @media (max-width: 768px) {
        .nav-links {
            display: none;
        }

        .mobile-menu {
            display: block;
        }
    }
    .navbar {
        background-color: white;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        position: sticky;
        top: 0;
        z-index: 100;
    }

    .logo-text {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--primary-color);
    }

    .nav-links a {
        text-decoration: none;
        color: var(--text-color);
        font-weight: 500;
        position: relative;
        transition: color 0.3s;
    }

    .nav-links a:hover {
        color: var(--primary-color);
    }

    .nav-links a::after {
        content: '';
        position: absolute;
        width: 0;
        height: 2px;
        bottom: -5px;
        left: 0;
        background-color: var(--primary-color);
        transition: width 0.3s;
    }

    .nav-links a:hover::after {
        width: 100%;
    }


    :root {
        --primary-color: #d6336c;
        --secondary-color: #f06595;
        --accent-color: #ffdeeb;
        --bg-color: #fff8f8;
        --text-color: #444;
        --light-text: #777;
        --dark-bg: #343a40;
    }
    /* ?n caret m?c ??nh c?a Bootstrap dropdown-toggle */
    .no-caret::after {
        display: none !important;
    }


</style>
<!-- HEADER -->


<header>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <div class="logo">
                <img img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/lotus.webp" alt="QT Fresh Flower Shop Logo">
                

<a class="navbar-brand" href="home">
                    <span class="logo-text">Velvet Fleur </span>
                </a>
            </div>  
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto nav-links">
                    <li class="nav-item">
                        <a class="nav-link <%= request.getRequestURI().endsWith("/home") ? "active" : ""%>" href="${pageContext.request.contextPath}/home">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= request.getRequestURI().endsWith("/productPage") ? "active" : ""%>" href="${pageContext.request.contextPath}/productPage">Shop</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= request.getRequestURI().endsWith("/view/common/AboutUsPage.jsp") ? "active" : ""%>" href="${pageContext.request.contextPath}/view/common/AboutUsPage.jsp">About Us</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= request.getRequestURI().endsWith("/view/common/ContactPage.jsp") ? "active" : ""%>" href="${pageContext.request.contextPath}/view/common/ContactPage.jsp">Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= request.getRequestURI().endsWith("/view/common/FAQpage.jsp") ? "active" : ""%>" href="${pageContext.request.contextPath}/view/common/FAQpage.jsp">FAQ</a>
                    </li>
                    <li class="nav-item position-relative me-3">
                        <a class="nav-link" href="${pageContext.request.contextPath}/cart">
                            <i class="fas fa-shopping-cart fa-lg"></i>
                            <span class="position-absolute top-10 start-100 translate-middle badge rounded-pill bg-danger">
                                <%= cartCount%>
                            </span>
                        </a>
                    </li>
                    <% if (loggedInUser == null) { %>
                    <li class="nav-item dropdown me-2">
                        <a class="nav-link dropdown-toggle no-caret d-flex align-items-center" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle fa-lg me-1"></i> Account
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow-sm">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt me-2"></i>Login</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/register"><i class="fas fa-user-plus me-2"></i>Register</a></li>
                        </ul>
                    </li>
                    <% } else {%>
                    <li class="nav-item dropdown me-2">
                        <a class="nav-link dropdown-toggle no-caret d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
<!--                            <img src="${pageContext.request.contextPath}/images/<%= loggedInUser.getAvatar()%>" class="rounded-circle me-2" width="32" height="32" alt="avatar" style="object-fit: cover;">-->
                            <span><%= loggedInUser.getFullName()%></span>
                        </a>
                                                 <ul class="dropdown-menu dropdown-menu-end shadow-sm">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/updateProfile"><i class="fas fa-user me-2"></i>Profile</a></li>
                                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/view-order"><i class="fas fa-user me-2"></i>View History Order</a></li>

                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                        </ul>
                    </li>
                    <% }%>
                </ul>
            </div>

    </nav>

</header>

