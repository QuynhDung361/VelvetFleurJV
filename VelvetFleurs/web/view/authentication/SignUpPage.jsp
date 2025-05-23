<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Sign Up</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

        <style>
            html, body {
                height: 100%;
                margin: 0;
            }

            body {
                font-family: Arial, sans-serif;
            }

            .signup-btn {
                background-color: #d291bc;
                color: white;
                font-weight: bold;
            }

            .signup-btn:hover,
            .signup-btn:active {
                background-color: #ffeee8;
                color: #000;
            }

            .signin-box button {
                background-color: #fff;
                font-weight: bold;
            }

            .signin-box button:hover,
            .signin-box button:active {
                background-color: #ffeee8;
            }

            .right-panel {
                background-color: #d291bc;
            }

            .form-icon {
                width: 40px;
                text-align: center;
            }

            .form-control::placeholder {
                font-size: 0.95rem;
            }

            .home-link {
                position: absolute;
                top: 20px;
                left: 20px;
                background-color: #d291bc;
                color: white;
                padding: 10px 20px;
                border-radius: 10px;
                text-decoration: none;
                font-weight: bold;
            }

            .home-link:hover {
                background-color: #ffeee8;
                color: #000;
            }
        </style>
    </head>

    <body>
        <!-- Home button -->
        <a class="home-link" href="${pageContext.request.contextPath}/home">&larr; HOME</a>

        <div class="container-fluid h-100">
            <div class="row h-100">
                <!-- Sign Up Form -->
                <div class="col-md-6 d-flex flex-column justify-content-center align-items-center p-5">
                    <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/lotus.webp" alt="logo" style="max-width: 140px;">
                    <h4 class="mb-4">Please join with us</h4>
                    <form class="w-100" style="max-width: 400px;" action="register" method="post">
                        <div class="input-group mb-3">
                            <span class="input-group-text form-icon"><i class="fa fa-user"></i></span>
                            <input type="text" class="form-control" placeholder="Full Name" name="fullname"
                                   value="<%= request.getAttribute("fullname") != null ? request.getAttribute("fullname") : ""%>" required>
                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text form-icon"><i class="fa fa-phone"></i></i></span>
                            <input type="phone" class="form-control" placeholder="Phone" name="phone"
                                   value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : ""%>" required>
                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text form-icon"><i class="fa fa-envelope"></i></span>
                            <input type="email" class="form-control" placeholder="Email(can be blank)" name="email"
                                   value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : ""%>">

                        </div>
                        <div class="input-group mb-3">
                            <span class="input-group-text form-icon"><i class="fa fa-lock"></i></span>
                            <input type="password" class="form-control" placeholder="Password" name="password" required>
                        </div>

                        <% String error = (String) request.getAttribute("error"); %>
                        <% if (error != null) {%>
                        <div class="alert alert-danger w-100 text-center" style="max-width: 500px;">
                            <%= error%>
                        </div>
                        <% }%>

                        <button type="submit" class="btn signup-btn w-100 mt-3">SIGN UP</button>
                    </form>
                </div>

                <!-- Right Panel -->
                <div class="col-md-6 right-panel d-flex flex-column justify-content-center align-items-center text-center p-5">
                    <div class="signin-box">
                        <h2 class="text-white mb-4">ONE OF US?</h2>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-light fw-bold">SIGN IN</a>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
