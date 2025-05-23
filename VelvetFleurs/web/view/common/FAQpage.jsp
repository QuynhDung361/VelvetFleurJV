<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Flower Shop FAQs</title>

        <!-- Bootstrap 5 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">   
        <style>
            .accordion-button {
                background-color: #fff5f3;
                font-weight: bold;
            }

            .accordion-button:not(.collapsed) {
                background-color: #ffe8e3;
                color: #000;
            }

            .contact-btn {
                background-color: #d48a9c;
                border: none;
            }

            .contact-btn:hover {
                background-color: #c47688;
            }

            .active {
                color: var(--primary-color) !important;
            }

            .active::after {
                width: 100% !important;
            }
            body {
                background-color: #fceeea;
                font-family: 'Segoe UI', sans-serif;
            }

            .container {
                padding-top: 10px;
                padding-bottom: 20px;
            }
        </style>
    </head>

    <body>
        <%@ include file="/view/components/Header.jsp" %>
        <div class="container">
            <h1 class="fw-bold mb-3">FAQs</h1>
            <p class="mb-4">Find answers to your most pressing questions about our flower delivery and care services.</p>

            <div class="accordion" id="faqAccordion">
                <!-- FAQ Item Template -->
                <%
                    String[] questions = {
                        "What are your delivery options?",
                        "How do I place an order?",
                        "What if my flowers arrive damaged?",
                        "How should I care for my flowers?",
                        "Do you offer refunds?"
                    };

                    String[] answers = {
                        "We offer same-day delivery for local orders placed before noon. For other areas, standard shipping options are available. You can choose your preferred delivery date at checkout.",
                        "Placing an order is easy! Simply browse our selection, add items to your cart, and proceed to checkout. You can create an account or check out as a guest.",
                        "If your flowers arrive damaged, please contact us within 24 hours. We will gladly replace them or issue a refund. Your satisfaction is our priority.",
                        "To keep your flowers fresh, trim the stems and place them in clean water. Avoid direct sunlight and change the water every few days. Follow the care instructions included with your order.",
                        "Yes, we offer refunds for damaged or unsatisfactory products. Please reach out to our customer service team for assistance. We want to ensure you are completely happy with your purchase."
                    };

                    for (int i = 0; i < questions.length; i++) {
                        String headingId = "heading" + (i + 1);
                        String collapseId = "collapse" + (i + 1);
                %>
                <div class="accordion-item">
                    <h2 class="accordion-header" id="<%= headingId%>">
                        <button class="accordion-button <%= (i == 0 ? "" : "collapsed")%>" type="button"
                                data-bs-toggle="collapse" data-bs-target="#<%= collapseId%>" aria-expanded="<%= (i == 0)%>"
                                aria-controls="<%= collapseId%>">
                            <%= questions[i]%>
                        </button>
                    </h2>
                    <div id="<%= collapseId%>" class="accordion-collapse collapse <%= (i == 0 ? "show" : "")%>"
                         aria-labelledby="<%= headingId%>" data-bs-parent="#faqAccordion">
                        <div class="accordion-body">
                            <%= answers[i]%>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>

            <!-- Contact Section -->
            <div class="mt-5">
                <h4 class="fw-bold">Still have questions?</h4>
                <p>We’re here to help you!</p>
                <a href="contact.jsp" class="btn contact-btn text-white px-4">Contact</a>
            </div>
        </div>

        <%@ include file="/view/components/Footer.jsp" %>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </body>
</html>
