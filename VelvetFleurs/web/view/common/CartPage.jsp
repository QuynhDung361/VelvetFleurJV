<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Velvet Fleur | Cart</title>
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
                line-height: 1.6;
                margin: 0;
                padding: 0;
            }
            
            .logo-text {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--primary-color);
            }
            .active {
                color: var(--primary-color) !important;
            }

            .active::after {
                width: 100% !important;
            }

            .breadcrumb {
                background-color: transparent;
                padding: 15px 0;
                margin-bottom: 0;
            }

            .breadcrumb-item.active {
                color: var(--primary-color);
                font-weight: 500;
            }

            .cart-container {
                max-width: 800px;
                margin: 30px auto;
                padding: 30px;
                background-color: white;
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            }

            .cart-header {
                text-align: center;
                margin-bottom: 30px;
                color: var(--primary-color);
                font-size: 2rem;
                font-weight: 700;
                text-transform: uppercase;
            }

            .cart-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 0;
                border-bottom: 1px solid #eee;
            }

            .item-info {
                flex: 1;
                padding-left: 20px;
            }

            .item-name {
                font-weight: 600;
                font-size: 1.2rem;
                margin-bottom: 5px;
            }

            .item-price {
                color: var(--primary-color);
                font-weight: 600;
            }

            .quantity-selector {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .quantity-btn {
                width: 30px;
                height: 30px;
                border-radius: 50%;
                background-color: var(--accent-color);
                color: var(--primary-color);
                border: none;
                font-weight: bold;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
            }

            .quantity {
                font-size: 1.1rem;
                min-width: 20px;
                text-align: center;
            }

            .remove-btn {
                background: none;
                border: none;
                color: var(--light-text);
                cursor: pointer;
                font-size: 0.9rem;
                margin-left: 20px;
                text-transform: uppercase;
                font-weight: 600;
            }

            .remove-btn:hover {
                color: var(--primary-color);
            }

            .cart-summary {
                margin-top: 30px;
                padding-top: 20px;
                border-top: 2px solid #eee;
            }

            .total-row {
                display: flex;
                justify-content: space-between;
                font-size: 1.3rem;
                font-weight: 600;
                margin-bottom: 30px;
            }

            .total-amount {
                color: var(--primary-color);
            }

            .action-buttons {
                display: flex;
                justify-content: space-between;
                gap: 20px;
            }

            .btn {
                flex: 1;
                padding: 12px;
                border-radius: 8px;
                font-weight: 600;
                text-align: center;
                transition: all 0.3s ease;
                text-transform: uppercase;
            }

            .btn-cancel {
                background-color: white;
                color: var(--primary-color);
                border: 2px solid var(--primary-color);
            }

            .btn-cancel:hover {
                background-color: #ffeff5;
            }

            .btn-checkout {
                background-color: var(--primary-color);
                color: white;
                border: 2px solid var(--primary-color);
            }

            .btn-checkout:hover {
                background-color: var(--secondary-color);
                border-color: var(--secondary-color);
            }         
            @media (max-width: 768px) {
                .cart-container {
                    margin: 20px;
                    padding: 15px;
                }

                .cart-item {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .quantity-selector {
                    margin-top: 10px;
                    margin-bottom: 10px;
                }

                .action-buttons {
                    flex-direction: column;
                }
            }
        </style>
    </head>
    <body>
        <!-- Navigation -->
        <%@ include file="/view/components/Header.jsp" %>
        <!-- Breadcrumb -->
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                    <li class="breadcrumb-item"><a href="product">Shop</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Cart</li>
                </ol>
            </nav>
        </div>

        <!-- Cart Content -->
        <div class="cart-container">
            <h1 class="cart-header">Your Cart</h1>

            <c:choose>
                <c:when test="${empty cartItems}">
                    <div class="text-center py-5">
                        <h4>Your cart is empty</h4>
                        <a href="productPage" class="btn" style="background-color: #ffeff5;">Continue Shopping</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${cartItems}" var="item">
                        <div class="cart-item">
                            <div class="item-info">
                                <div class="item-name">${item.product.name}</div>
                                <div class="item-price"><fmt:formatNumber value="${item.product.price}" type="number"/> VNĐ</div>
                            </div>
                            <form action="cart" method="post" class="quantity-selector">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="productId" value="${item.product.id}">
                                <input type="hidden" name="quantity" value="${item.quantity}" class="quantity-input">
                                <button type="button" class="quantity-btn minus-btn">-</button>
                                <span class="quantity">${item.quantity}</span>
                                <button type="button" class="quantity-btn plus-btn" data-max="${item.product.quantity}">+</button>
                            </form>
                            <form action="cart" method="post">
                                <input type="hidden" name="action" value="remove">
                                <input type="hidden" name="productId" value="${item.product.id}">
                                <button type="submit" class="remove-btn">Remove</button>
                            </form>
                        </div>
                    </c:forEach>

                    <!-- Cart Summary -->
                    <div class="cart-summary">
                        <div class="total-row">
                            <span>Total</span>
                            <span class="total-amount"><fmt:formatNumber value="${total}" type="number"/> VNĐ</span>
                        </div>

                        <div class="action-buttons">
                            <a href="productPage" class="btn btn-cancel">Cancel</a>
                            <a href="checkOut" class="btn btn-checkout">Checkout</a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <%@ include file="/view/components/Footer.jsp" %>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Quantity adjustment functionality
            document.querySelectorAll('.minus-btn').forEach(button => {
                button.addEventListener('click', function () {
                    const form = this.closest('form');
                    const quantityElement = form.querySelector('.quantity');
                    const quantityInput = form.querySelector('.quantity-input'); // lấy input hidden
                    let quantity = parseInt(quantityElement.textContent);

                    if (quantity > 1) {
                        quantity--;
                        quantityElement.textContent = quantity;
                        quantityInput.value = quantity; // cập nhật input hidden
                        form.submit();
                    }
                });
            });
            // Update total price
            function updateTotal() {
                // In a real implementation, you would calculate based on actual prices
                // This is just a placeholder for the demo
                let total = 0;
                document.querySelectorAll('.cart-item').forEach(item => {
                    const priceText = item.querySelector('.item-price').textContent;
                    const price = parseFloat(priceText.replace(/[^0-9.]/g, ''));
                    const quantity = parseInt(item.querySelector('.quantity').textContent);
                    total += price * quantity;
                });
                document.querySelector('.total-amount').textContent = 'Rp ' + total.toLocaleString('id-ID');
            }
            document.querySelectorAll('.plus-btn').forEach(button => {
                button.addEventListener('click', function () {
                    const form = this.closest('form');
                    const quantityElement = form.querySelector('.quantity');
                    const quantityInput = form.querySelector('.quantity-input');
                    let quantity = parseInt(quantityElement.textContent);

                    const maxQuantity = parseInt(this.dataset.max);

                    if (quantity < maxQuantity) {
                        quantity++;
                        quantityElement.textContent = quantity;
                        quantityInput.value = quantity;
                        form.submit(); // chỉ submit nếu hợp lệ
                    } else {
                        alert('Not enough stock available.');
                    }
                });
            });
        </script>
    </body>
</html>