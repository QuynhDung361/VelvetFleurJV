<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Customer"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
          .page-container {
                max-width: 1100px;
                margin: 0 auto;
                padding: 20px;
            }

/*        .container {
            max-width:600px;
            margin-top:20px;
        }*/
        .form-control {
            margin-bottom: 15px;
        }
        .btn-primary {
            width: 100%;
        }
        .message {
            margin-top: 20px;
            font-size: 16px;
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
    <h2 class="mb-4">Edit Profile</h2>

    <c:choose>
        <c:when test="${not empty customer}">
<!--                        <form action="updateProfile" method="post" enctype="multipart/form-data">-->

            <form action="updateProfile" method="post" >
                <input type="hidden" name="id" value="${customer.id}" />



<%--
    <div class="mb-3">
        <label for="avatar" class="form-label">Avatar</label>
        <input type="file" class="form-control" id="avatar" name="avatar"/>
    </div>

    <c:if test="${not empty customer.avatar}">
        <div class="mb-3">
            <img src="${pageContext.request.contextPath}/images/avatar/${customer.avatar}" alt="Avatar" width="150"/>
        </div>
    </c:if>
--%>
   

                <div class="mb-3">
                    <label for="fullName" class="form-label">Full Name</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" value="${customer.fullName}" required/>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="${customer.email}"/>
                </div>

                <div class="mb-3">
                    <label for="phone" class="form-label">Phone Number</label>
                    <input type="text" class="form-control" id="phone" name="phone" value="${customer.phone}" required/>
                </div>

                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" class="form-control" id="address" name="address" value="${customer.address}" required/>
                </div>

                <div class="mb-3">
                    <label for="gender" class="form-label">Gender</label>
                    <select class="form-select" name="gender" id="gender">
                        <option value="Male" ${customer.gender == 'Male' ? 'selected' : ''}>Male</option>
                        <option value="Female" ${customer.gender == 'Female' ? 'selected' : ''}>Female</option>
                    </select>
                </div>

<button type="submit" class="btn btn-primary" style="background-color: #ff66b2; border-color: pink;">Save Changes</button>
            </form>
        </c:when>
        <c:otherwise>
            <p class="text-danger">Customer information not found!</p>
        </c:otherwise>
    </c:choose>

    <p class="message text-success">${message != null ? message : ''}</p>
</div>
<script>
function validateForm() {
    const fullName = document.forms["updateForm"]["fullName"].value.trim();
    const email = document.forms["updateForm"]["email"].value.trim();
    const phone = document.forms["updateForm"]["phone"].value.trim();

    if (fullName === "" || phone === "") {
        alert("Please enter both your full name and phone number.");
        return false;
    }

    // Validate email format only if email is not empty
    if (email !== "") {
        const emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
        if (!emailRegex.test(email)) {
            alert("Invalid email format.");
            return false;
        }
    }

    const phoneRegex = /^[0-9]{10}$/; // Exactly 10 digits
    if (!phoneRegex.test(phone)) {
        alert("Phone number must be exactly 10 digits.");
        return false;
    }

    return true;
}
</script>
        <%@ include file="/view/components/Footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
