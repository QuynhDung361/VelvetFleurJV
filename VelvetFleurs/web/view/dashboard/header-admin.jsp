<%-- 
    Document   : header-admin.jsp
    Created on : 30 thg 4, 2025, 13:38:01
    Author     : sunny
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<style>
    .navbar-admin {
        background-color: white;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    .logo {
        display: flex;
        align-items: center;
    }

    .logo img {
        height: 40px;
        margin-right: 10px;
    }

    .logo-text {
        font-size: 1.5rem;
        font-weight: bold;
        color: #d6336c;
    }

    .nav-item .nav-link {
        color: #444;
        font-weight: 500;
    }

    .nav-item .nav-link:hover {
        color: #d6336c;
    }

    .dropdown-menu a:hover {
        background-color: #f8d7da;
        color: #721c24;
    }

    .avatar {
        object-fit: cover;
        width: 32px;
        height: 32px;
        border-radius: 50%;
        margin-right: 8px;
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
</style>

<nav class="navbar navbar-expand-lg navbar-admin">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/adminHome">
            <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/lotus.webp" alt="Logo">
            <span class="logo-text">Admin Panel</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>
<!--        <div class="collapse navbar-collapse" id="adminNavbar">
            <ul class="navbar-nav ms-auto">
                <c:choose>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
                               <img src="${pageContext.request.contextPath}/images/default-avatar.png" class="avatar" alt="Avatar">
<span><%= username != null ? username : "Admin" %> (<%= role != null ? role : "Unknown" %>)</span>

                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/adminProfile"><i class="fas fa-user me-2"></i>Profile</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                            </ul>
                        </li>
                    
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt"></i> Login</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>-->
<div class="collapse navbar-collapse" id="adminNavbar">
    <ul class="navbar-nav ms-auto">
        <c:choose>
            <c:when test="${not empty sessionScope.username}">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
                        <img src="${pageContext.request.contextPath}/images/default-avatar.png" class="avatar" alt="Avatar">
                        <span>${sessionScope.username} (${sessionScope.role})</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/adminProfile">
                                <i class="fas fa-user me-2"></i>Profile
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt me-2"></i>Logout
                            </a>
                        </li>
                    </ul>
                </li>
            </c:when>
            <c:otherwise>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/login">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </a>
                </li>
            </c:otherwise>
        </c:choose>
    </ul>
</div>

    </div>
</nav>
