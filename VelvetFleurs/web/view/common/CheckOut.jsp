<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Velvet Fleur | Checkout</title>
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

            .navbar {
                background-color: white;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                position: sticky;
                top: 0;
                z-index: 100;
            }

            .logo-text {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--primary-color);
            }

            .breadcrumb {
                background: none;
                padding: 0;
            }

            .section-title h5 {
                font-size: 2rem;
                color: var(--primary-color);
                text-align: center;
                margin-bottom: 30px;
            }

            .checkout-form {
                background-color: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            }

            .form-label {
                font-weight: 500;
            }

            .btn-primary {
                background-color: var(--primary-color);
                border: none;
            }

            .btn-primary:hover {
                background-color: var(--secondary-color);
            }

            .order-summary {
                background-color: white;
                padding: 20px;
                border-radius: 12px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            }

            .order-summary h5 {
                margin-bottom: 20px;
                color: var(--primary-color);
            }

            .order-item {
                border-bottom: 1px solid #eee;
                padding: 10px 0;
            }

            .order-item:last-child {
                border-bottom: none;
            }

            .total {
                font-size: 1.2rem;
                font-weight: bold;
                color: var(--primary-color);
                margin-top: 15px;
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
        <!-- Breadcrumb -->
        <div class="container mt-4">
            <nav class="breadcrumb">
                <a class="breadcrumb-item text-muted" href="home.jsp">Home</a>
                <a class="breadcrumb-item text-muted" href="cart.jsp">Cart</a>
                <span class="breadcrumb-item active">Checkout</span>
            </nav>
        </div>

        <!-- Checkout Content -->
        <section class="py-5">
            <div class="container">
                <div class="row g-5">
                    <!-- Billing Form -->
                    <div class="col-lg-7">
                        <div class="checkout-form">
                            <div class="section-title">
                                <h5>Billing Details</h5>
                            </div>
                            <form action="ajaxServlet" method="post">
                                <div class="mb-3">
                                    <label for="fullname" class="form-label">Full Name</label>
                                    <input type="text" class="form-control" id="fullname" name="fullname" 
                                           value="${customer != null ? customer.fullName : ''}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="address" class="form-label">Address</label>
                                    <input type="text" class="form-control" id="address" name="address" 
                                           value="${customer != null ? customer.address : ''}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="phone" class="form-label">Phone Number</label>
                                    <input type="text" class="form-control" id="phone" name="phone" 
                                           value="${customer != null ? customer.phone : ''}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="note" class="form-label">Order Notes (Optional)</label>
                                    <textarea class="form-control" id="note" name="note" rows="3"></textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Payment Method</label>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="COD" checked>
                                        <label class="form-check-label" for="cod">
                                            Payment(COD)
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="paymentMethod" id="vnpay" value="VNPAY">
                                        <label class="form-check-label" for="vnpay">
                                            Payment(VNPay)
                                        </label>
                                    </div>
                                </div>
                                <!--                                <input type="hidden" name="amount" value="500000" />-->
                                <input type="hidden" name="language" value="vn" />
                                <input type="hidden" name="bankCode" value="" />
                                <button type="submit" class="btn btn-primary w-100">Place Order</button>
                            </form>
                        </div>
                    </div>

                    <!-- Order Summary -->
                    <div class="col-lg-5">
                        <div class="order-summary">
                            <h5>Order Summary</h5>
                            <c:forEach var="item" items="${cartItems}">
                                <div class="order-item d-flex justify-content-between">
                                    <div>${item.product.name} × ${item.quantity}</div>
                                    <div> <fmt:formatNumber value="${item.product.price * item.quantity}" type="number"/> VNĐ</div>
                                </div>
                            </c:forEach>
                            <div class="total d-flex justify-content-between">
                                <div>Total:</div>
                                <div><fmt:formatNumber value="${totalAmount}" type="number"/> VNĐ</div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>
        <%@ include file="/view/components/Footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>

            document.querySelector("form").addEventListener("submit", function (e) {
                e.preventDefault(); // Ngăn chặn gửi form mặc định

                const form = e.target;
                const formData = new FormData(form);
                const paymentMethod = formData.get("paymentMethod");

                // Kiểm tra hợp lệ input
                const name = formData.get("fullname").trim();
                const phone = formData.get("phone").trim();
                const address = formData.get("address").trim();

                const namePattern = /^[A-Za-zÀ-ỹ\s]+$/;
                const phonePattern = /^\d{10}$/;
                const addressPattern = /^[A-Za-zÀ-ỹ0-9\s,.-]+$/;

                let errorMessages = [];

                if (!name || !namePattern.test(name)) {
                    errorMessages.push("Full Name must not contain numbers or special characters.");
                }
                if (!phonePattern.test(phone)) {
                    errorMessages.push("Phone number must be exactly 10 digits.");
                }
                if (!address || !addressPattern.test(address)) {
                    errorMessages.push("Address must not contain special characters (except , and -).");
                }

                if (errorMessages.length > 0) {
                    alert(errorMessages.join("\n"));
                    return;
                }
                if (paymentMethod === "VNPAY") {
                    const formData = new URLSearchParams(new FormData(form));

                    $.ajax({
                        url: "ajaxServlet",
                        method: "POST",
                        data: formData.toString(),
                        contentType: "application/x-www-form-urlencoded",
                        success: function (response) {
                            console.log(response);
                            if (response && response.code === "00") {
                                window.location.href = response.data;
                            } else {
                                alert("VNPay Error: " + (response.message || "Unknown error"));
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("XHR response:", xhr.responseText);
                            alert("AJAX Error: " + status + " - " + error);
                        }
                    });
                } else {
                    form.action = "codOrder";
                    form.submit();// Thanh toán COD thì gửi form như bình thường
                }
            });
        </script>
    </body>
</html>
