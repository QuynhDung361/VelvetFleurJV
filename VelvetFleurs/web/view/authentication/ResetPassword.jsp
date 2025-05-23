<%-- 
    Document   : ResetPassword
    Created on : Apr 18, 2025, 10:10:26 PM
    Author     : admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password - Velvet Fleur</title>
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

        .container-reset {
            display: flex;
            height: 100vh;
        }

        .reset-left {
            flex: 1;
            background-color: var(--accent-white);
            padding: 60px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .reset-left img {
            width: 120px;
            margin-bottom: 20px;
        }

        .reset-left h4 {
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

        .reset-right {
            flex: 1;
            background-color: var(--highlight);
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 60px;
        }

        .reset-right h4 {
            font-weight: bold;
            margin-bottom: 20px;
            font-family: 'Crimson Text', serif;
            font-size: 28px;
        }

        .reset-right p {
            font-size: 16px;
            line-height: 1.6;
        }

        @media (max-width: 768px) {
            .container-reset {
                flex-direction: column;
            }

            .reset-right {
                padding: 40px;
            }
        }
    </style>
</head>
<body>

<div class="container-reset">
    <!-- Left: Form -->
    <div class="reset-left">
        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/lotus.webp" alt="logo">
        <h4>Create New Password</h4>

        <form method="post" action="resetPassword" style="width: 100%; max-width: 320px;">
            <div class="mb-3">
                <input type="password" name="newPassword" class="form-control" placeholder="New Password" required>
            </div>

            <div class="mb-3">
                <input type="password" name="confirmPassword" class="form-control" placeholder="Confirm Password" required>
            </div>

            <div class="mb-3">
                <button type="submit" class="btn btn-reset">RESET PASSWORD</button>
            </div>

            <div class="text-center">
                <a href="Login.jsp" class="text-muted">&larr; Back to Login</a>
            </div>
        </form>
    </div>

    <!-- Right: Info -->
    <div class="reset-right">
        <h4>Set a Strong New Password</h4>
        <p>
            Your new password should be different from your previous password and at least 8 characters long. For best security, use a combination of letters, numbers, and special characters.
        </p>
    </div>
</div>

</body>
</html>




