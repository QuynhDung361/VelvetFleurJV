<%@page import="model.CartItem"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>


<title>Five Blooms | Flower Shop</title>
<style>

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: var(--bg-color);
        color: var(--text-color);
        line-height: 1.6;
        margin: 0px;
    }

    /* Hero Section */
    .hero {
        position: relative;
        height: 500px;
        background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)), url('https://images.unsplash.com/photo-1526397751294-331021109fbd');
        background-size: cover;
        background-position: center;
        color: white;
        display: flex;
        align-items: center;
        margin-bottom: 50px;
    }

    .hero h2 {
        font-size: 3rem;
        margin-bottom: 20px;
        text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
    }

    .btn {
        display: inline-block;
        padding: 12px 30px;
        border-radius: 30px;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .btn-dark {
        background-color: var(--primary-color);
        border-color: var(--primary-color);
    }

    .btn-dark:hover {
        background-color: var(--secondary-color);
        border-color: var(--secondary-color);
    }

    /* Category Section */
    .section-title {
        text-align: center;
        margin-bottom: 40px;
    }

    .section-title h5 {
        font-size: 2rem;
        color: var(--primary-color);
        margin-bottom: 15px;
        position: relative;
        display: inline-block;
    }

    .section-title h5::after {
        content: "";
        position: absolute;
        width: 70px;
        height: 3px;
        background-color: var(--secondary-color);
        bottom: -10px;
        left: 50%;
        transform: translateX(-50%);
    }

    .category-img, .product-img {
        width: 100%;
        height: 200px;
        background-color: #eee;
        border-radius: 12px;
        object-fit: cover;
        transition: transform 0.5s ease;
    }

    .category-item:hover .category-img,
    .product-img:hover {
        transform: scale(1.05);
    }

    .category-title, .product-title {
        font-weight: bold;
        text-align: center;
        margin-top: 15px;
        color: var(--text-color);
    }

    .price {
        text-align: center;
        color: var(--primary-color);
        font-weight: 600;
        font-size: 1.1rem;
        margin: 10px 0;
    }

    .btn-outline-dark {
        color: var(--primary-color);
        border-color: var(--primary-color);
    }

    .btn-outline-dark:hover {
        background-color: var(--primary-color);
        color: white;
    }

    /* Carousel Controls */
    .carousel-control-prev, .carousel-control-next {
        width: 40px;
        height: 40px;
        background-color: var(--primary-color);
        border-radius: 50%;
        top: 50%;
        transform: translateY(-50%);
        opacity: 1;
    }

    .carousel-control-prev {
        left: -20px;
    }

    .carousel-control-next {
        right: -20px;
    }
    /* Responsive Adjustments */
    @media (max-width: 768px) {
        .hero {
            height: 400px;
            text-align: center;
        }

        .hero h2 {
            font-size: 2.2rem;
        }

        .category-img, .product-img {
            height: 150px;
        }
    }
    .product-card {
        background-color: white;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        height: 100%;
        display: flex;
        flex-direction: column;
    }

    .product-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0,0,0,0.15);
    }

    .product-image {
        height: 250px;
        overflow: hidden;
    }

    .product-img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s ease;
    }

    .product-card:hover .product-img {
        transform: scale(1.1);
    }

    .product-info {
        padding: 20px;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
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
        font-weight: 600;
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
        margin-top: auto;
        width: 100%;
    }

    .product-button:hover {
        background-color: var(--secondary-color);
    }

    @media (max-width: 768px) {
        .product-image {
            height: 180px;
        }

        .product-info {
            padding: 15px;
        }

        .product-title {
            font-size: 1rem;
        }

        .product-price {
            font-size: 1rem;
        }
    }
    /* Category Section Styling */
    .category {
        position: relative;
    }

    .carousel-control-prev,
    .carousel-control-next {
        width: 40px;
        height: 40px;
        background-color: var(--primary-color);
        border-radius: 50%;
        opacity: 1;
        transform: translateY(-50%);
    }

    .carousel-control-prev {
        left: -20px;
    }

    .carousel-control-next {
        right: -20px;
    }

    @media (max-width: 768px) {
        .carousel-control-prev {
            left: 0;
        }

        .carousel-control-next {
            right: 0;
        }
    }
    .active {
        color: var(--primary-color) !important;
    }

    .active::after {
        width: 100% !important;
    }
    .carousel-control-prev-icon,
    .carousel-control-next-icon {
        background-color: black !important; /* Adjust color as needed */
    }

    /* Optional: Change the hover color */
    .carousel-control-prev:hover .carousel-control-prev-icon,
    .carousel-control-next:hover .carousel-control-next-icon {
        background-color: #f8f9fa !important; /* Change to any hover color */
    }
    .category-title.active {
        color: var(--primary-color);
        font-weight: bold;
        position: relative;
    }

    .category-title.active::after {
        content: "";
        position: absolute;
        width: 50%;
        height: 2px;
        background-color: var(--primary-color);
        bottom: -5px;
        left: 25%;
    }
    
    .btn-pink {
        background-color: #ff66b2; /* Màu hồng */
        color: white;
        font-size: 16px;
        padding: 10px 25px;
        border: none;
        border-radius: 25px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        display: inline-block;
        text-align: center;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }

    .btn-pink:hover {
        background-color: #ff3385; /* Màu hồng đậm khi hover */
    }

    .category-link-all {
        margin-top: 10px;
        margin-bottom: 25px;
        text-align: center;
    }
</style>

<body>
    <%@ include file="/view/components/Header.jsp" %>
    <!-- Hero Section -->
    <section class="hero">
        <div class="container text-center" >
            <h2>THE BEST <br> FLOWER PRODUCTS <br> FOR YOU</h2>
        </div>
    </section>     
    <section class="search">
        <div class="container" >
            <nav class="breadcrumb">
                <a class="breadcrumb-item text-muted" href="home">Home</a>
                <span class="breadcrumb-item active" >Shopping</span>
            </nav>
            <!-- Search Bar -->
            <div class="input-group mb-5 shadow-sm">
                <form action="productPage" method="get" class="d-flex w-100">
                    <input type="text" name="search" class="form-control py-2" placeholder="Search Product" 
                           value="${param.search}">
                    <button class="btn btn-outline-secondary" type="submit">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>
    </section>
<!--     Category Section - Thêm link filter 
    <section class="category py-5">
        <div class="container position-relative">
            <div class="section-title">
                <h5>CATEGORY</h5>
            </div>

            <div id="categoryCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach var="i" begin="0" end="${fn:length(categoryList) - 1}" step="4">
                        <div class="carousel-item ${i == 0 ? 'active' : ''}">
                            <div class="row">
                                <c:forEach var="j" begin="0" end="3">
                                    <c:if test="${(i + j) < fn:length(categoryList)}">
                                        <c:set var="category" value="${categoryList[i + j]}" />
                                        <div class="col-6 col-md-3 text-center mb-4">
                                            <a href="productPage?category=${category.id}" 
                                               style="text-decoration: none; color: inherit;">
                                                <div class="category-img"></div>
                                                <div class="category-title ${param.category == category.id ? 'active' : ''}">
                                                    ${category.name}
                                                </div>
                                            </a>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

             Carousel Controls 
            <button class="carousel-control-prev" type="button" data-bs-target="#categoryCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#categoryCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </section>-->


<section class="category py-5">
    <div class="container position-relative">
        <div class="section-title">
            <h5>CATEGORY</h5>
        </div>


<!-- Nút View All Products -->
<div class="category-link-all">
    <a href="productPage" style="text-decoration: none;">
        <button class="btn-pink">View All Products</button>
    </a>
</div>

        <div id="categoryCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <c:forEach var="i" begin="0" end="${fn:length(categoryList) - 1}" step="4">
                    <div class="carousel-item ${i == 0 ? 'active' : ''}">
                        <div class="row">
                            <c:forEach var="j" begin="0" end="3">
                                <c:if test="${(i + j) < fn:length(categoryList)}">
                                    <c:set var="category" value="${categoryList[i + j]}" />
                                    <div class="col-6 col-md-3 text-center mb-4">
                                        <a href="productPage?category=${category.id}" style="text-decoration: none; color: inherit;">
                                            <div class="category-box p-4 d-flex flex-column justify-content-center align-items-center mb-3">
                                                <div class="category-icon">
                                                    <i class="fas fa-box fa-3x"></i> <!-- Biểu tượng danh mục -->
                                                </div>
                                                <div class="category-title ${param.category == category.id ? 'active' : ''}">
                                                    ${category.name}
                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Các nút điều khiển carousel -->
        <button class="carousel-control-prev" type="button" data-bs-target="#categoryCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#categoryCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</section>

    <!-- Product Section -->
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
<!--                            <div class="product-info">
                                <div class="product-category">${product.category}</div>
                                <a href="viewDetail?id=${product.id}" style="text-decoration: none;"><h3 class="product-title">${product.name}</h3></a>
                                <div class="product-price"><fmt:formatNumber value="${product.price}" type="number"/> VNĐ</div>
                                <button class="product-button add-to-cart-btn" data-product-id="${product.id}">Add to Cart</button>
                            </div>-->
<div class="product-info">
    <div class="product-category" style="display:none;">${product.category}</div>
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
