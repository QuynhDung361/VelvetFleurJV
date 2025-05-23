<%-- 
    Document   : Login
    Created on : Apr 16, 2025, 11:54:50 PM
    Author     : admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Login page for SWP Team application">
    <meta name="keywords" content="login, SWP Team, authentication">
    <title>Login - Velvet Fleur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&family=Crimson+Text:wght@400;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-bg: #FFEEE8;
            --secondary-bg: #444444;
            --accent-light: #F2F2F2;
            --accent-white: #FFFFFF;
            --dark: #000000;
            --highlight: #D291BC;
        }

        body, html {
            height: 100%;
            margin: 0;
            font-family: 'Roboto', sans-serif;
            background-color: var(--primary-bg);
        }

        .container-login {
            display: flex;
            height: 100vh;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .login-left {
            flex: 1;
            background-color: var(--accent-white);
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .login-left img {
            width: 140px;
            margin-bottom: 20px;
        }

        .login-left h4 {
            margin-bottom: 20px;
            font-weight: bold;
            font-family: 'Crimson Text', serif;
            color: var(--secondary-bg);
        }

        .form-control {
            border-radius: 10px;
            padding: 12px;
            font-size: 16px;
            border: 1px solid #ddd;
        }

        .form-control:focus {
            border-color: var(--highlight);
            box-shadow: 0 0 0 0.25rem rgba(210, 145, 188, 0.25);
        }

        .btn-login {
            background: var(--highlight);
            border: none;
            color: white;
            font-weight: bold;
            padding: 12px;
            border-radius: 10px;
            width: 100%;
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
            transition: 0.3s;
        }

        .btn-login:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }

        .login-right {
            flex: 1;
            background-color: var(--highlight);
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 60px;
        }

        .login-right h4 {
            font-weight: bold;
            margin-bottom: 20px;
            font-family: 'Crimson Text', serif;
            font-size: 28px;
        }

        .login-right p {
            font-size: 16px;
            line-height: 1.6;
        }

        .btn-outline-danger {
            border-radius: 8px;
            font-weight: bold;
            padding: 8px 16px;
            border-width: 2px;
            color: var(--highlight);
            border-color: var(--highlight);
            transition: all 0.3s ease;
        }

        .btn-outline-danger:hover {
            background-color: var(--highlight);
            color: white;
        }

        a.text-muted {
            text-decoration: none;
            transition: color 0.3s;
        }

        a.text-muted:hover {
            color: var(--highlight) !important;
        }

        .alert {
            max-width: 320px;
            margin-bottom: 20px;
        }

        @media (max-width: 768px) {
            .container-login {
                flex-direction: column;
            }

            .login-right {
                padding: 40px;
            }
        }
    </style>
</head>
<body>

<div class="container-login">
    <!-- Left: Form -->
    <div class="login-left">
        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/lotus.webp" alt="logo">
        <h4>Welcome to Velvet Fleur</h4>

        <%-- Hiển thị thông báo lỗi nếu có --%>
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger text-center" role="alert">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>

        <form method="post" action="login" style="width: 100%; max-width: 320px;">
            <div class="mb-3">
                <input type="text" name="username" class="form-control" placeholder="Username" required>
            </div>

            <div class="mb-3">
                <input type="password" name="password" class="form-control" placeholder="Password" required>
            </div>

            <div class="mb-3">
                <button type="submit" class="btn btn-login">LOG IN</button>
            </div>

            <div class="mb-3 text-center">
                <a href="/forgot-password" class="text-muted" style="font-size: 14px;">Forgot password?</a>
            </div>

            <div class="d-flex justify-content-center align-items-center mt-3">
                <p class="mb-0 me-2">Don't have an account?</p>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-danger">CREATE NEW</a>
            </div>
        </form>
    </div>

    <!-- Right: Info -->
    <div class="login-right">
        <h4>We are more than just a company</h4>
        <p>
            Velvet Fleur ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
            incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud
            exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
        </p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>




