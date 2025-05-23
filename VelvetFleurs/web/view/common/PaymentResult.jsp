<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Five Blooms | Payment Result</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #d6336c;
                --secondary-color: #f06595;
                --accent-color: #ffdeeb;
                --bg-color: #fff8f8;
                --text-color: #444;
                --light-text: #777;
                --dark-bg: #343a40;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--bg-color);
                color: var(--text-color);
            }

            .logo-text {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--primary-color);
            }

            .result-container {
                margin-top: 80px;
                text-align: center;
            }

            .result-icon {
                font-size: 5rem;
                color: var(--primary-color);
                margin-bottom: 20px;
            }

            .result-message {
                font-size: 1.5rem;
                font-weight: 600;
                margin-bottom: 30px;
            }

            .btn-home {
                background-color: var(--primary-color);
                border: none;
                padding: 12px 24px;
                font-size: 1rem;
                font-weight: 600;
                color: white;
                border-radius: 30px;
                text-decoration: none;
            }

            .btn-home:hover {
                background-color: var(--secondary-color);
                color: white;
            }
            .active {
                color: var(--primary-color) !important;
            }

            .active::after {
                width: 100% !important;
            }
        </style>
    </head>
    <body>
        <!-- Navigation -->
        <%@ include file="/view/components/Header.jsp" %>
        <!-- Payment Result Content -->
        <div class="container result-container">
            <div class="result-icon">
                <i class="fa-regular fa-circle-check"></i>
            </div>
            <div class="result-message">
                ${message}
            </div>
            <div class="result-message">
                ${status}
            </div>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-home">Return to Home</a>
        </div>
        <%@ include file="/view/components/Footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
