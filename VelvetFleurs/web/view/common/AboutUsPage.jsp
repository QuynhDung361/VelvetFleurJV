<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><!DOCTYPE html>
<html>
    <head>
        <title>About Us</title>
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #fff;
            }

            .page-container {
                max-width: 1100px;
                margin: 0 auto;
                padding: 20px;
            }

            h1, h2, h3, p {
                margin: 0;
                padding: 0;
            }

            h2 {
                font-size: 32px;
                margin-bottom: 30px;
            }

            .header {
                text-align: center;
                margin-bottom: 30px;
            }

            .content-container {
                display: flex;
                gap: 40px;
                flex-wrap: wrap;
                align-items: center;
                margin-bottom: 40px;
            }

            .about-content {
                flex: 1 1 400px;
            }

            .about-text {
                margin-bottom: 15px;
                color: #333;
                font-size: 16px;
                line-height: 1.6;
            }

            .highlight {
                font-weight: bold;
                color: #d63384;
            }

            .about-image {
                flex: 1 1 300px;
            }

            .about-image img {
                width: 100%;
                max-height: 340px;
                object-fit: cover;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }

            .values-container {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                margin-bottom: 40px;
            }

            .value-card {
                flex: 1 1 300px;
                background-color: #fff8f6;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            .value-title {
                margin: 10px 0;
                color: #000;
            }

            .value-icon {
                font-size: 24px;
            }

            .contact-about-section {
                margin-top: 40px;
                padding-bottom: 20px;
            }

            .contact-about-title {
                font-size: 28px;
                margin-bottom: 10px;
            }

            .contact-about-info {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                margin-top: 20px;
            }

            .contact-about-item {
                flex: 1 1 250px;
                background-color: #f9f9f9;
                padding: 15px;
                border-radius: 8px;
            }

            .contact-about-icon {
                font-size: 20px;
                margin-bottom: 5px;
            }

            .contact-about-label {
                font-weight: bold;
                color: #222;
            }

            .active {
                color: var(--primary-color) !important;
            }

            .active::after {
                width: 100% !important;
            }

            @media (max-width: 768px) {
                .content-container,
                .values-container,
                .contact-info {
                    flex-direction: column;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="/view/components/Header.jsp" %>

        <div class="page-container">
            <div class="header">
                <h1>About Us</h1>
                <p>Where emotions bloom through every fresh petal</p>
            </div>

            <div class="content-container">
                <div class="about-content">
                    <h2 class="section-title">Our Story</h2>
                    <p class="about-text">
                        Welcome to <span class="highlight">Five Blooms</span> – your go-to destination for the most beautiful flowers for every special occasion.
                    </p>
                    <p class="about-text">
                        Established in <span class="highlight">2025</span>, we specialize in providing both imported and locally sourced fresh flowers for birthdays, anniversaries, weddings, and seasonal celebrations.
                    </p>
                    <p class="about-text">
                        With a team of professional and passionate florists, we are committed to delivering the best online flower shopping experience and top-notch customer service.
                    </p>
                    <p class="about-text">
                        Every bouquet is carefully crafted and delivered with love. <span class="highlight">Your satisfaction is our greatest reward!</span>
                    </p>
                </div>

                <div class="about-image">
                    <img src="https://dongnai360.com/images/post/2024/02/nhung_cua_hang_hoa_tuoi_tai_dong_nai/tiem_hoa_yeu_thuong.webp" alt="Five Blooms" />
                </div>
            </div>

            <h2 class="section-title">Our Core Values</h2>
            <div class="values-container">
                <div class="value-card">
                    <div class="value-icon">🌸</div>
                    <h3 class="value-title">Superior Quality</h3>
                    <p>We select the freshest, most beautiful, and unique flowers to ensure every bouquet is perfect for your special moments.</p>
                </div>

                <div class="value-card">
                    <div class="value-icon">💝</div>
                    <h3 class="value-title">Dedicated Service</h3>
                    <p>Our team is always ready to assist and advise you in finding the perfect flowers for your special occasions.</p>
                </div>

                <div class="value-card">
                    <div class="value-icon">✨</div>
                    <h3 class="value-title">Endless Creativity</h3>
                    <p>We continuously update with the latest trends and create unique designs for every occasion throughout the year.</p>
                </div>
            </div>

            <div class="contact-about-section">
                <h2 class="contact-about-title">Contact Us</h2>
                <p>Let us help you spread messages of love through the language of flowers</p>

                <div class="contact-about-info">
                    <div class="contact-about-item">
                        <div class="contact-about-icon">📍</div>
                        <div class="contact-about-label">Address</div>
                        <div>123 Rose Street, District 1, Hoa Lac City</div>
                    </div>

                    <div class="contact-about-item">
                        <div class="contact-about-icon">📞</div>
                        <div class="contact-about-label">Hotline</div>
                        <div>+84 909 123 456</div>
                    </div>

                    <div class="contact-about-item">
                        <div class="contact-about-icon">📧</div>
                        <div class="contact-about-label">Email</div>
                        <div>contact@fiveblooms.com</div>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="/view/components/Footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </body>
</html>
