<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>QT Fresh Flower Shop | Home</title>
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
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--bg-color);
                color: var(--text-color);
                line-height: 1.6;
            }
            /* Hero Section */
            .hero {
                position: relative;
                height: 600px;
                background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('https://images.squarespace-cdn.com/content/v1/57451c424c2f85ae9b18f48d/1653676592228-KO25QHNG9RAV0DB9LKHC/facebook-link-image+2.jpeg?format=2500w');
                background-size: cover;
                background-position: center;
                color: white;
                display: flex;
                align-items: center;
            }

            .hero-content {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
            }

            .hero h1 {
                font-size: 3rem;
                margin-bottom: 20px;
                animation: fadeInUp 1s ease;
            }

            .hero p {
                font-size: 1.2rem;
                margin-bottom: 30px;
                max-width: 600px;
                animation: fadeInUp 1.2s ease;
            }

            .btn {
                display: inline-block;
                padding: 12px 30px;
                border-radius: 30px;
                text-decoration: none;
                font-weight: 600;
                transition: all 0.3s ease;
                cursor: pointer;
            }

            .btn-primary {
                background-color: var(--primary-color);
                color: white;
                border: 2px solid var(--primary-color);
                animation: fadeInUp 1.4s ease;
            }

            .btn-primary:hover {
                background-color: transparent;
                color: white;
            }

            .btn-secondary {
                background-color: transparent;
                color: white;
                border: 2px solid white;
                margin-left: 15px;
                animation: fadeInUp 1.6s ease;
            }

            .btn-secondary:hover {
                background-color: white;
                color: var(--primary-color);
            }

            /* Features Section */
            .features {
                padding: 80px 20px;
                max-width: 1200px;
                margin: 0 auto;
            }

            .section-title {
                text-align: center;
                margin-bottom: 60px;
            }

            .section-title h2 {
                font-size: 2.5rem;
                color: var(--primary-color);
                margin-bottom: 15px;
                position: relative;
                display: inline-block;
            }

            .section-title h2::after {
                content: "";
                position: absolute;
                width: 70px;
                height: 3px;
                background-color: var(--secondary-color);
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
            }

            .section-title p {
                color: var(--light-text);
                max-width: 700px;
                margin: 0 auto;
            }

            .features-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                gap: 30px;
            }

            .feature-card {
                flex: 1;
                min-width: 250px;
                background-color: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.05);
                text-align: center;
                transition: transform 0.3s ease;
            }

            .feature-card:hover {
                transform: translateY(-10px);
            }

            .feature-icon {
                font-size: 3rem;
                color: var(--secondary-color);
                margin-bottom: 20px;
            }

            .feature-card h3 {
                margin-bottom: 15px;
                color: var(--primary-color);
            }

            /* Products Section */
            .products {
                padding: 80px 20px;
                background-color: white;
            }

            .products-container {
                max-width: 1200px;
                margin: 0 auto;
            }

            .product-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 30px;
            }

            .product-card {
                background-color: white;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            }

            .product-image {
                height: 250px;
                overflow: hidden;
            }

            .product-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.5s ease;
            }

            .product-card:hover .product-image img {
                transform: scale(1.1);
            }

            .product-info {
                padding: 20px;
            }

            .product-category {
                color: var(--light-text);
                font-size: 0.9rem;
                margin-bottom: 5px;
            }

            .product-title {
                font-size: 1.2rem;
                margin-bottom: 10px;
                color: var(--text-color);
            }

            .product-price {
                color: var(--primary-color);
                font-weight: bold;
                font-size: 1.1rem;
                margin-bottom: 15px;
            }

            .product-button {
                background-color: var(--primary-color);
                color: white;
                border: none;
                padding: 8px 15px;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
                font-weight: 500;
            }

            .product-button:hover {
                background-color: var(--secondary-color);
            }

            /* Testimonials */
            .testimonials {
                padding: 80px 20px;
                background-color: var(--bg-color);
            }

            .testimonials-container {
                max-width: 1200px;
                margin: 0 auto;
            }

            .testimonials-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
                gap: 30px;
            }

            .testimonial-card {
                background-color: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
                position: relative;
            }

            .testimonial-card::before {
                /*            content: """;*/
                position: absolute;
                top: 10px;
                left: 20px;
                font-size: 5rem;
                color: var(--accent-color);
                font-family: Georgia, serif;
                line-height: 1;
                z-index: 0;
            }

            .testimonial-content {
                position: relative;
                z-index: 1;
            }

            .testimonial-text {
                font-style: italic;
                margin-bottom: 20px;
            }

            .testimonial-author {
                display: flex;
                align-items: center;
            }

            .author-image {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                overflow: hidden;
                margin-right: 15px;
            }

            .author-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .author-info h4 {
                margin-bottom: 5px;
                color: var(--primary-color);
            }

            .author-info p {
                color: var(--light-text);
                font-size: 0.9rem;
            }

            /* CTA Section */
            .cta {
                padding: 80px 20px;
                background-color: var(--primary-color);
                color: white;
                text-align: center;
            }

            .cta-container {
                max-width: 900px;
                margin: 0 auto;
            }

            .cta h2 {
                font-size: 2.5rem;
                margin-bottom: 20px;
            }

            .cta p {
                margin-bottom: 40px;
                font-size: 1.1rem;
            }

            .cta-btn {
                background-color: white;
                color: var(--primary-color);
                padding: 15px 40px;
                border-radius: 50px;
                font-size: 1.1rem;
                border: 2px solid white;
                transition: all 0.3s ease;
                display: inline-block;
                text-decoration: none;
                font-weight: 600;
            }

            .cta-btn:hover {
                background-color: transparent;
                color: white;
            }
            /* Animations */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Responsive */
            @media (max-width: 768px) {
                .hero h1 {
                    font-size: 2.5rem;
                }

                .hero {
                    height: 500px;
                }

                .features-container {
                    flex-direction: column;
                }

                .feature-card {
                    margin-bottom: 20px;
                }

                .cta h2 {
                    font-size: 2rem;
                }
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
        <!-- Hero Section -->
        <section class="hero">
            <div class="hero-content">
                <h1>Beautiful Flowers for Every Occasion</h1>
                <p>Discover our wide range of fresh, high-quality flowers perfect for any celebration, occasion, or to simply brighten someone's day.</p>
                <div class="hero-buttons">
                    <a href="productPage" class="btn btn-primary">Shop Now</a>             
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="features">
            <div class="section-title">
                <h2>Why Choose Us</h2>
                <p>We're committed to providing the freshest flowers with exceptional service</p>
            </div>

            <div class="features-container">
                <div class="feature-card">
                    <div class="feature-icon">🌹</div>
                    <h3>Premium Quality</h3>
                    <p>We source only the freshest, highest quality flowers to ensure your arrangements last longer and look beautiful.</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">🚚</div>
                    <h3>Fast Delivery</h3>
                    <p>Same-day delivery available for orders placed before 2 PM, ensuring your flowers arrive fresh and on time.</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">💐</div>
                    <h3>Custom Arrangements</h3>
                    <p>Our expert florists can create custom arrangements tailored to your specific needs and occasions.</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">💯</div>
                    <h3>Satisfaction Guaranteed</h3>
                    <p>Not completely satisfied? We offer a 100% satisfaction guarantee on all our products.</p>
                </div>
            </div>
        </section>

        <!-- Products Section -->
        <section class="product py-5 bg-white">
            <div class="container">
                <div class="section-title">
                    <h5>PRODUCTS</h5>
                    <p class="text-muted text-center">Explore our beautiful flower collection</p>
                </div>

                <div class="row">
                    <c:forEach var="product" items="${productList}">
                        <div class="col-6 col-md-3 mb-4">
                            <div class="product-card">
                                <div class="product-image">
                                    <div class="product-img" style="background-color: #f9f9f9;"> <img src="${product.image}" alt="${product.name}" class="img-fluid" /></div>                                  

                                </div>
                                <div class="product-info">
<!--                                    <div class="product-category">${product.category}</div>-->
                                    <a href="viewDetail?id=${product.id}" style="text-decoration: none;"><h3 class="product-title">${product.name}</h3></a>
                                    <div class="product-price"><fmt:formatNumber value="${product.price}" type="number"/> VNĐ</div>
                                    <button class="product-button add-to-cart-btn" data-product-id="${product.id}">Add to Cart</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Pagination -->
                <!-- Pagination -->
                <nav aria-label="Product pagination" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" 
                               href="?page=${currentPage - 1}${not empty param.search ? '&search=' += param.search : ''}${not empty param.category ? '&category=' += param.category : ''}" 
                               aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" 
                                   href="?page=${i}${not empty param.search ? '&search=' += param.search : ''}${not empty param.category ? '&category=' += param.category : ''}">
                                    ${i}
                                </a>
                            </li>
                        </c:forEach>

                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" 
                               href="?page=${currentPage + 1}${not empty param.search ? '&search=' += param.search : ''}${not empty param.category ? '&category=' += param.category : ''}" 
                               aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </section>
        <!-- Testimonials Section -->
        <section class="testimonials">
            <div class="testimonials-container">
                <div class="section-title">
                    <h2>What Our Customers Say</h2>
                    <p>Read testimonials from our satisfied customers</p>
                </div>

                <div class="testimonials-grid">
                    <div class="testimonial-card">
                        <div class="testimonial-content">
                            <p class="testimonial-text">The flowers I ordered for my mother's birthday were absolutely stunning! They lasted for over two weeks and the arrangement was even more beautiful than in the pictures.</p>
                            <div class="testimonial-author">
                                <div class="author-image">
                                    <img src="file/images/customer1.jpg" alt="Customer">
                                </div>
                                <div class="author-info">
                                    <h4>Sarah Johnson</h4>
                                    <p>Regular Customer</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="testimonial-card">
                        <div class="testimonial-content">
                            <p class="testimonial-text">I've been ordering from QT Flowers for all special occasions in our family. Their customer service is exceptional and the flowers always arrive fresh and beautifully arranged.</p>
                            <div class="testimonial-author">
                                <div class="author-image">
                                    <img src="file/images/customer2.jpg" alt="Customer">
                                </div>
                                <div class="author-info">
                                    <h4>Michael Tran</h4>
                                    <p>Loyal Customer</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="testimonial-card">
                        <div class="testimonial-content">
                            <p class="testimonial-text">The anniversary bouquet I ordered was delivered on time and was absolutely perfect. My wife loved it! Will definitely order again for future special occasions.</p>
                            <div class="testimonial-author">
                                <div class="author-image">
                                    <img src="file/images/customer3.jpg" alt="Customer">
                                </div>
                                <div class="author-info">
                                    <h4>David Nguyen</h4>
                                    <p>New Customer</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <section class="cta">
            <div class="cta-container">
                <h2>Subscribe to Our Newsletter</h2>
                <p>Stay updated with our latest offers, new arrivals, and seasonal specials</p>
                <form class="newsletter-form">
                    <input type="email" class="newsletter-input" placeholder="Enter your email">
                    <button type="submit" class="newsletter-btn">Subscribe</button>
                </form>
            </div>
        </section>

        <%@ include file="/view/components/Footer.jsp" %>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>

            $(document).ready(function () {
                // Initialize cart count (you might want to load this from server)
                updateCartCount();

                $('.add-to-cart-btn').click(function () {
                    const productId = $(this).data('product-id');
                    const button = $(this);

                    button.prop('disabled', true);
                    button.html('<i class="fas fa-spinner fa-spin"></i> Adding...');

                    $.ajax({
                        url: '${pageContext.request.contextPath}/AddToCart',
                        type: 'POST',
                        data: {
                            productId: productId,
                            quantity: 1 // You might want to add quantity later
                        },
                        success: function (response) {
                            if (response.success) {
                                button.html('<i class="fas fa-check"></i> Added!');
                                updateCartCount(response.cartCount);
                            } else {
                                button.html('Failed!');
                                console.error(response.message);
                            }

                            // Reset button after 2 seconds
                            setTimeout(function () {
                                button.html('Add to Cart');
                                button.prop('disabled', false);
                            }, 2000);
                        },
                        error: function (xhr, status, error) {
                            console.error('Status:', status);
                            console.error('Error:', error);
                            console.error('Response:', xhr.responseText); // 👈 Add this line
                            button.html('Error! Try Again');
                            setTimeout(function () {
                                button.html('Add to Cart');
                                button.prop('disabled', false);
                            }, 2000);
                        }
                    });
                });

                function updateCartCount(count) {
                    if (count !== undefined) {
                        $('#cart-count').text(count);
                    } else {
                        // Load current cart count from server
                        $.get('getCartCount', function (response) {
                            $('#cart-count').text(response.cartCount || 0);
                        }).fail(function () {
                            $('#cart-count').text(0);
                        });
                    }
                }
            });
        </script>
    </body>
</html>