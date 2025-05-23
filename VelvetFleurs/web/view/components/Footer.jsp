<%-- 
    Document   : Footer
    Created on : Apr 21, 2025, 1:14:04?AM
    Author     : duongngo21
--%>
<head>
    <title>Velvet Fleur | Flower Shop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        /* Footer */
        :root {
            --primary-color: #d6336c;
            --secondary-color: #f06595;
            --accent-color: #ffdeeb;
            --bg-color: #fff8f8;
            --text-color: #444;
            --light-text: #777;
            --dark-bg: #343a40;
        }
        .footer {
            background-color: var(--dark-bg);
            color: white;
            padding: 60px 20px 30px;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
        }

        .footer-about h3,
        .footer-links h3,
        .footer-contact h3,
        .footer-newsletter h3 {
            color: white;
            margin-bottom: 20px;
            font-size: 1.3rem;
            position: relative;
            padding-bottom: 10px;
        }

        .footer-about h3::after,
        .footer-links h3::after,
        .footer-contact h3::after,
        .footer-newsletter h3::after {
            content: "";
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 2px;
            background-color: var(--primary-color);
        }

        .footer-about p {
            margin-bottom: 20px;
            color: #ddd;
        }

        .social-links {
            display: flex;
            gap: 15px;
        }

        .social-links a {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background-color: rgba(255,255,255,0.1);
            border-radius: 50%;
            color: white;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .social-links a:hover {
            background-color: var(--primary-color);
            transform: translateY(-3px);
        }

        .footer-links ul {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 12px;
        }

        .footer-links a {
            color: #ddd;
            text-decoration: none;
            transition: color 0.3s ease;
            display: inline-block;
        }

        .footer-links a:hover {
            color: var(--primary-color);
            transform: translateX(5px);
        }

        .contact-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 15px;
            color: #ddd;
        }

        .contact-icon {
            margin-right: 15px;
            color: var(--secondary-color);
        }

        .newsletter-form {
            display: flex;
            margin-top: 20px;
        }

        .newsletter-input {
            flex-grow: 1;
            padding: 12px 15px;
            border: none;
            border-radius: 5px 0 0 5px;
            outline: none;
        }

        .newsletter-btn {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 0 20px;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .newsletter-btn:hover {
            background-color: var(--secondary-color);
        }

        .footer-bottom {
            max-width: 1200px;
            margin: 40px auto 0;
            padding-top: 20px;
            border-top: 1px solid rgba(255,255,255,0.1);
            text-align: center;
            color: #aaa;
            font-size: 0.9rem;
        }
    </style>
</head>
<!-- FOOTER -->
<footer class="footer">
    <div class="footer-container">
        <div class="footer-about">
            <h3>Velvet Fleur Flower Shop</h3>
            <p>We deliver beautiful, fresh flowers for all occasions. Our expert florists create stunning arrangements that will bring joy to your loved ones.</p>
            <div class="social-links">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-pinterest-p"></i></a>
            </div>
        </div>

        <div class="footer-links">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="home.jsp">Home</a></li>
                <li><a href="product">Shop</a></li>
                <li><a href="categories.jsp">Categories</a></li>
                <li><a href="AboutUsPage.jsp">About Us</a></li>
                <li><a href="contact.jsp">Contact</a></li>
                <li><a href="faq.jsp">FAQ</a></li>
            </ul>
        </div>

        <div class="footer-contact">
            <h3>Contact Us</h3>
            <div class="contact-item">
                <i class="fas fa-map-marker-alt contact-icon"></i>
                <div>Thach Hoa, Hoa Lac, Thach That, Ha Noi</div>
            </div>
            <div class="contact-item">
                <i class="fas fa-phone contact-icon"></i>
                <div> +84392522003</div>
            </div>
            <div class="contact-item">
                <i class="fas fa-envelope contact-icon"></i>
                <div>contact@VelvetFleur.com</div>
            </div>
            <div class="contact-item">
                <i class="fas fa-clock contact-icon"></i>
                <div>Mon-Sat: 8:00 AM - 8:00 PM</div>
            </div>
        </div>

        <div class="footer-newsletter">
            <h3>Newsletter</h3>
            <p>Subscribe to receive updates on new arrivals and special promotions.</p>
            <form class="newsletter-form">
                <input type="email" class="newsletter-input" placeholder="Your email address">
                <button type="submit" class="newsletter-btn">?</button>
            </form>
        </div>
    </div>

    <div class="footer-bottom">
        <p>&copy; 2025 Five Blooms Flower Shop. All rights reserved.</p>
    </div>
</footer>

