<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
    body {
        font-family: 'Segoe UI', sans-serif;
        background-color: #fff5f7;
    }

    .hero-banner {
        background-image: url('https://images.unsplash.com/photo-1504208434309-cb69f4fe52b0?auto=format&fit=crop&w=1600&q=80');
        background-size: cover;
        background-position: center;
        padding: 120px 0;
        color: #fff;
        text-align: center;
    }

    .hero-banner h1 {
        font-size: 48px;
        font-weight: bold;
        text-shadow: 1px 1px 4px rgba(0,0,0,0.5);
    }

    .section {
        padding: 60px 0;
    }

    .service-card {
        background-color: #fff;
        border-radius: 12px;
        padding: 30px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        transition: transform 0.3s;
    }

    .service-card:hover {
        transform: translateY(-5px);
    }

    .pink-text {
        color: #d63384;
    }

    .rounded-icon {
        width: 60px;
        height: 60px;
        background-color: #f8d7da;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        font-size: 24px;
        color: #d63384;
    }

    .cta-banner {
        background-color: #ffe6eb;
        padding: 60px 20px;
        border-radius: 12px;
        text-align: center;
    }
    .active {
        color: var(--primary-color) !important;
    }

    .active::after {
        width: 100% !important;
    }
</style>

<!-- Hero Banner -->
<div class="hero-banner">
    <h1>Our Services</h1>
    <p class="mt-3 fs-5">Beautiful blooms, thoughtful gifts, and floral artistry for every occasion.</p>
</div>

<!-- Section: About Services -->
<section class="section text-center">
    <div class="container">
        <h2 class="mb-4 pink-text">What We Offer</h2>
        <p class="lead">From weddings to everyday surprises, we bring beauty to life with our custom floral designs, curated gifts, and heartfelt services tailored to your needs.</p>
    </div>
</section>

<!-- Section: Service Cards -->
<section class="section">
    <div class="container">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="service-card text-center">
                    <div class="rounded-icon mb-3"><i class="bi bi-flower1"></i></div>
                    <h5>Floral Arrangements</h5>
                    <p>Custom-designed bouquets and floral pieces perfect for birthdays, anniversaries, and every “just because” moment.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="service-card text-center">
                    <div class="rounded-icon mb-3"><i class="bi bi-box-seam"></i></div>
                    <h5>Gift Boxes</h5>
                    <p>Curated gift boxes with artisan treats, candles, and handmade items that pair beautifully with our blooms.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="service-card text-center">
                    <div class="rounded-icon mb-3"><i class="bi bi-heart-fill"></i></div>
                    <h5>Wedding Services</h5>
                    <p>Full-service floral design for weddings, including bridal bouquets, centerpieces, arch installations, and more.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Section: Why Choose Us -->
<section class="section bg-light">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="pink-text">Why Choose Blossom & Bone?</h2>
        </div>
        <div class="row g-4">
            <div class="col-md-3 text-center">
                <div class="rounded-icon mb-2"><i class="bi bi-star-fill"></i></div>
                <h6>Artisanal Quality</h6>
                <p>Every piece is handcrafted with love and attention to detail.</p>
            </div>
            <div class="col-md-3 text-center">
                <div class="rounded-icon mb-2"><i class="bi bi-truck"></i></div>
                <h6>Local Delivery</h6>
                <p>Fast, fresh delivery throughout Durham and surrounding areas.</p>
            </div>
            <div class="col-md-3 text-center">
                <div class="rounded-icon mb-2"><i class="bi bi-emoji-heart-eyes"></i></div>
                <h6>Custom Requests</h6>
                <p>We work closely with you to bring your vision to life.</p>
            </div>
            <div class="col-md-3 text-center">
                <div class="rounded-icon mb-2"><i class="bi bi-globe"></i></div>
                <h6>Sustainable Practice</h6>
                <p>We care about the planet with eco-conscious packaging and sourcing.</p>
            </div>
        </div>
    </div>
</section>

<!-- Section: CTA -->
<section class="section">
    <div class="container">
        <div class="cta-banner">
            <h3 class="mb-3">Let's Make Something Beautiful</h3>
            <p class="mb-4">Whether it’s a special occasion or just because, we’re here to help you create a moment that lasts forever.</p>
            <a href="#" class="btn btn-dark btn-lg">Contact Us</a>
        </div>
    </div>
</section>



