<%-- 
    Document   : Header
    Created on : Apr 21, 2025, 1:13:35?AM
    Author     : duongngo21
--%>

<%@page import="model.Account"%>
<%@page import="java.util.List"%>

<%
    String username = (String) session.getAttribute("username"); 
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<style>


    body {
        margin: 0;
        padding: 0;
    }
header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 999;
    background-color: pink;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
     height: 80px;
}
/*    header {
        position: sticky;
        top: 0;
        z-index: 1000;
        background-color: white;
        
        position: fixed;
top: 0;
left: 0;
width: 100%;
z-index: 999;

    }*/



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
/*    .navbar {
        background-color: white;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        position: sticky;
        top: 0;
        z-index: 100;
    }*/

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
                    <span class="logo-text">Five Blooms</span>
                </a>
            </div>  
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto nav-links">
                    <li class="nav-item">
                        <a class="nav-link <%= request.getRequestURI().endsWith("/view/dashboard/dashboard.jsp") ? "active" : ""%>" href="${pageContext.request.contextPath}/dashboard">Home</a>
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
                   
                   <div style="position: absolute; top: 20px; right: 30px; font-size: 16px; color: #555;">
     Welcome, <strong><%= username %></strong>!
</div>

   </ul>
            </div>

    </nav>

</header>

