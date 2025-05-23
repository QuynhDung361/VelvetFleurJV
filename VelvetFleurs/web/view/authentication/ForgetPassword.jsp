<%-- 
    Document   : ForgetPassword
    Created on : Apr 16, 2025, 11:52:29 PM
    Author     : admin
--%>

<%-- 
    Document   : ForgetPassword
    Created on : Apr 16, 2025, 11:52:29 PM
    Author     : admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password - Lotus Team</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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

        .container-forgot {
            display: flex;
            height: 100vh;
        }

        .forgot-left {
            flex: 1;
            background-color: var(--accent-white);
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .forgot-left img {
            width: 120px;
            margin-bottom: 20px;
        }

        .forgot-left h4 {
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

        .btn-reset {
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

        .btn-reset:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }

        .forgot-right {
            flex: 1;
            background-color: var(--highlight);
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 60px;
        }

        .forgot-right h4 {
            font-weight: bold;
            margin-bottom: 20px;
            font-family: 'Crimson Text', serif;
            font-size: 28px;
        }

        .forgot-right p {
            font-size: 16px;
            line-height: 1.6;
        }

        .text-muted a {
            text-decoration: none;
            color: #888;
            transition: color 0.3s;
        }

        .text-muted a:hover {
            color: var(--highlight);
        }

        @media (max-width: 768px) {
            .container-forgot {
                flex-direction: column;
            }

            .forgot-right {
                padding: 40px;
            }
        }
    </style>
</head>
<body>

<div class="container-forgot">
    <!-- Left: Form -->
    <div class="forgot-left">
        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/lotus.webp" alt="logo">
        <h4>Reset Your Password</h4>

        <form style="width: 100%; max-width: 320px;">
            <div class="mb-3">
                <input type="email" name="email" class="form-control" placeholder="Enter your email address" required>
            </div>

            <div class="mb-3">
                                 <button type="submit" class="btn btn-reset"><a href="/SWP391/verify">SEND RESET LINK</a>-</button>

            </div>

            <div class="text-center">
                <a href="Login.jsp" class="text-muted">&larr; Back to Login</a>
            </div>
        </form>
    </div>

    <!-- Right: Info -->
    <div class="forgot-right">
        <h4>We’ve got you covered!</h4>
        <p>
            Don’t worry if you forgot your password. Enter your email address and we’ll send you a link to reset it.
        </p>
    </div>
</div>

</body>
</html>




