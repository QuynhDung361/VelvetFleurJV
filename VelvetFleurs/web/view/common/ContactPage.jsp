<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Contact </title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootstrap 5 CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">  
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
        <!-- Style -->
        <style>
            body {
                font-family: 'Montserrat', sans-serif;
                color: #000;
            }

            .contact-section {
                max-width: 800px;
                margin: 5% auto;
                border: 2px solid #f783ac;
                padding: 40px;
                background-color: #fff;
                border-radius: 12px;
                background-color: #fff0f5;

            }

            .contact-title {
                font-weight: 700;
                font-size: 26px;
                margin-bottom: 20px;
                color: #d63384;
            }

            .contact-info i {
                font-style: normal;
                margin-right: 10px;
                font-weight: 700;
            }

            .message-box {
                height: 120px;
                resize: none;
                border: 1px solid #f783ac;
            }

            .send-btn {
                border: 2px solid #d63384;
                background-color: #fff;
                color: #d63384;
                font-weight: 600;
                transition: all 0.3s ease-in-out;
            }

            .send-btn:hover {
                background-color: #d63384;
                color: #fff;
            }

            .footer {
                text-align: center;
                margin-top: 40px;
                font-size: 14px;
                border-top: 1px solid #f783ac;
                padding-top: 10px;
                color: #d63384;
            }

            .icon {
                display: inline-block;
                width: 20px;
                color: #d63384;
            }

            .contact-info strong {
                color: #d63384;
            }

            textarea.form-control:focus {
                border-color: #d63384;
                box-shadow: 0 0 0 0.2rem rgba(214, 51, 132, 0.25);
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
        <%@ include file="/view/components/Header.jsp" %>

        <div class="contact-section">

            <!-- CONTACT INFO -->
            <div class="contact-title text-center">CONTACT US</div>
            <div class="row mb-4">
                <div class="col-md-12">
                    <p class="contact-info">
                        <span class="icon"></span><strong>Email</strong> : fiveblooms@gmail.com
                    </p>
                    <p class="contact-info">
                        <span class="icon"></span><strong>Phone Number</strong> : +84392522003
                    </p>
                    <p class="contact-info">
                        <span class="icon"></span><strong>LinkedIn</strong> : FiveBlooms
                    </p>
                    <p class="contact-info">
                        <span class="icon"></span><strong>Instagram</strong> : @Fiveblooms
                    </p>
                </div>
            </div>

            <!-- MESSAGE BOX -->
            <div class="contact-title text-center">SEND MESSAGE</div>
            <form>
                <div class="mb-3">
                    <textarea class="form-control message-box" placeholder="Message"></textarea>
                </div>
                <div class="text-end">
                    <button type="submit" class="btn send-btn">SEND</button>
                </div>
            </form>     
        </div>
        <%@ include file="/view/components/Footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </body>
</html>
