<%-- 
    Document   : VerifyEmail
    Created on : Apr 18, 2025, 10:07:31 PM
    Author     : admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Verify Email - Velvet Fleur</title>
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

        .container-verify {
            display: flex;
            height: 100vh;
        }

        .verify-left {
            flex: 1;
            background-color: var(--accent-white);
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .verify-left img {
            width: 120px;
            margin-bottom: 20px;
        }

        .verify-left h4 {
            margin-bottom: 20px;
            font-weight: bold;
            font-family: 'Crimson Text', serif;
            color: var(--secondary-bg);
        }

        .verify-left p {
            font-size: 16px;
            color: #666;
            margin-bottom: 30px;
            text-align: center;
            max-width: 300px;
        }

        .btn-back {
            background: var(--highlight);
            border: none;
            color: white;
            font-weight: bold;
            padding: 12px 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
            transition: 0.3s;
        }

        .btn-back:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }

        .verify-right {
            flex: 1;
            background-color: var(--highlight);
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 60px;
        }

        .verify-right h4 {
            font-weight: bold;
            margin-bottom: 20px;
            font-family: 'Crimson Text', serif;
            font-size: 28px;
        }

        .verify-right p {
            font-size: 16px;
            line-height: 1.6;
        }

        @media (max-width: 768px) {
            .container-verify {
                flex-direction: column;
            }

            .verify-right {
                padding: 40px;
            }
        }
    </style>
</head>
<body>

<div class="container-verify">
    <!-- Left: Message -->
    <div class="verify-left">
        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/lotus.webp" alt="logo">
        <h4>Please Check Your Email</h4>
        <p>We’ve sent a password reset link to your email address. Follow the instructions to reset your password.</p>

        <a href="Login.jsp" class="btn btn-back">&larr; Back to Login</a>
    </div>

    <!-- Right: Visual Info -->
    <div class="verify-right">
        <h4>Email Sent!</h4>
        <p>
            Check your inbox for the reset link. Didn’t get the email? Try checking your spam folder or request another link.
        </p>
    </div>
</div>

</body>
</html>




