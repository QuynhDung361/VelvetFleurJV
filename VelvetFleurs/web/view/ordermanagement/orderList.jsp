<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
    <head>
         <title>Order List</title>
    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
    <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                padding: 20px;
            }

            h2 {
                color: #d6336c;
                text-align: center;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 5px 10px rgba(0,0,0,0.1);
                border-radius: 8px;
                overflow: hidden;
                margin-top: 20px;
            }

            th, td {
                padding: 12px 15px;
                text-align: center;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #ffdeeb;
                color: #d6336c;
            }

            tr:hover {
                background-color: #fff0f5;
            }

            .details-table {
                margin-top: 30px;
                display: none;
            }

            .details-title {
                margin-top: 30px;
                color: #d6336c;
                font-weight: bold;
            }

            .customer-card {
                background-color: #fff;
                border: 1px solid #ddd;
                padding: 20px;
                border-radius: 8px;
                margin-top: 30px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            }

            .customer-card h3 {
                color: #d6336c;
                margin-bottom: 15px;
            }

            .customer-card p {
                margin: 5px 0;
            }

            .wrapper {
                display: flex;
                flex-direction: row;
            }

            .sidebar {
                width: 250px;
                flex-shrink: 0;
            }

            .main-content {
                flex: 1;
                padding: 20px;
                overflow-x: auto;
            }

            /* Nút lọc */
            button {
                background-color: #d6336c;
                color: white;
                border: none;
                padding: 10px 20px;
                margin: 5px;
                border-radius: 5px;
                cursor: pointer;
                font-size: 14px;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #c1356d;
            }

            button:focus {
                outline: none;
            }



            .filter-container {
                display: flex;
                gap: 20px;
                margin-bottom: 15px;
            }

            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-btn {
                background-color: #d6336c;
                color: white;
                padding: 10px 20px;
                border: none;
                cursor: pointer;
                border-radius: 5px;
                font-size: 16px;
            }

            .dropdown-btn:hover {
                background-color: #c32f60;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #fff;
                min-width: 160px;
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
                z-index: 1;
                border-radius: 5px;
                margin-top: 5px;
            }

            .dropdown-content button {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
                background-color: #fff;
                border: none;
                width: 100%;
                text-align: left;
            }

            .dropdown-content button:hover {
                background-color: #f1f1f1;
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }

            .dropdown:hover .dropdown-btn {
                background-color: #c32f60;
            }

        </style>

        <!-- jQuery + DataTables JS -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
    </head>
    <body>

        <%@ include file="/view/dashboard/sidebar.jsp" %>

        <div style="margin-left: 250px; padding: 20px">
            <h2 style="margin-bottom: 10px;">Order List</h2>
        </div>

        <div class="wrapper">
            <div style="margin-left: 250px; padding: 20px;">
                <form method="get" action="orders" class="row g-3 mb-4">

                    <div class="col-md-3">
                        <select name="status" class="form-select">
                            <option value="">All Payment Status</option>
                            <option value="0" ${param.status == '0' ? 'selected' : ''}>Unpaid</option>
                            <option value="1" ${param.status == '1' ? 'selected' : ''}>Paid</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select name="deliveryStatus" class="form-select">
                            <option value="">All Delivery Status</option>
                            <option value="Delivered" ${param.deliveryStatus == 'Delivered' ? 'selected' : ''}>Delivered</option>
                            <option value="Not Delivered" ${param.deliveryStatus == 'Not Delivered' ? 'selected' : ''}>Not Delivered</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn w-100" style="background-color: #f06292; color: white; border: none;">Filter</button>
                    </div>
                </form>
                    <c:choose>
                        <c:when test="${empty orders}">
                            <p style="text-align:center; color: #888;">No orders available.</p>
                        </c:when>
                        <c:otherwise>



                            <table id="ordersTable" class="display">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Customer ID</th>
                                        <th>Total</th>
                                        <th>Status</th>
                                        <th>Created At</th>
                                        <th>Delivery</th>
                                        <th>Note</th>
                                        <th>Details</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="o" items="${orders}">
                                        <tr>
                                            <td>${o.id}</td>
                                            <td>${o.customerId}</td>
                                            <td>${o.totalPrice} đ</td>

                                            <td>
                                                <select onchange="updateStatus(${o.id}, this)" data-original-value="${o.paid ? 1 : 0}">
                                                    <option value="1" ${o.paid ? "selected" : ""}>Paid</option>
                                                    <option value="0" ${!o.paid ? "selected" : ""}>Unpaid</option>
                                                </select>
                                            </td>

                                            <td>${o.createAt}</td>

                                            <td data-order="${o.deliveryStatus == 'Delivered' ? 1 : 0}">
                                                <span class="delivery-text" style="display:none;">${o.deliveryStatus}</span>
                                                <select onchange="updateDeliveryStatus(${o.id}, this)" data-original-value="${o.deliveryStatus}">
                                                    <option value="Delivered" ${o.deliveryStatus == 'Delivered' ? 'selected' : ''}>Delivered</option>
                                                    <option value="Not Delivered" ${o.deliveryStatus == 'Not Delivered' ? 'selected' : ''}>Not Delivered</option>
                                                </select>
                                            </td>

                                          <td>${o.note}</td>
                                <td>
                                    <button onclick="loadOrderItems('${o.id}')">View Order Items</button>
                                    <button onclick="loadCustomerInfo('${o.customerId}', '${o.id}')">View Customer Info</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>

        <div style="margin-left: 250px; padding: 20px;">
            <!-- Order Details Table -->
            <div id="orderDetailsSection" class="details-table" style="flex: 2;">
                <h3 class="details-title">Order Details</h3>
                <table id="orderDetails">
                    <thead>
                        <tr>
                            <th>Product Name</th>
                            <th>Product ID</th>
                            <th>Quantity</th>
                            <th>Price</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody id="orderDetailsBody">
                        <!-- Content will be loaded by AJAX -->
                    </tbody>
                </table>
            </div>

            <!-- Customer Information -->
            <div id="customerInfoSection" class="customer-card" style="display: none;">
                <h3>Recipient Information</h3>
                <p><strong>Name:</strong> <span id="customerName"></span></p>
                <p><strong>Phone:</strong> <span id="customerPhone"></span></p>
                <p><strong>Address:</strong> <span id="customerAddress"></span></p>
            </div>
        </div>

        <!-- DataTables script -->
        <script type="text/javascript">
//                $(document).ready(function () {
//                    $('#ordersTable').DataTable();
//                });
            $(document).ready(function () {
                $('#ordersTable').DataTable({
                    "columnDefs": [

                        {
                            "targets": 5, // Delivery column index
                            "render": function (data, type, row, meta) {
                                var cell = row[5];
                                var el = $('<div>').html(cell);
                                return el.find('.delivery-text').text(); // lấy giá trị thực

                            }
                        }
                    ]
                });
            });

        </script>

       <script>
    let currentOrderId = null;

    function loadOrderItems(orderId) {
        if (currentOrderId !== orderId) {
            $('#customerInfoSection').hide();
        }

        $.ajax({
            url: 'OrderItems',
            method: 'GET',
            data: {orderId: orderId},
            success: function (response) {
                $('#orderDetailsBody').html(response);
                $('#orderDetailsSection').show();
                $('html, body').animate({
                    scrollTop: $("#orderDetailsSection").offset().top
                }, 500);
                currentOrderId = orderId;
            },
            error: function () {
                alert("Failed to load order item data.");
            }
        });
    }

    function loadCustomerInfo(customerId, orderId) {
        if (currentOrderId !== orderId) {
            $('#orderDetailsSection').hide();
        }

        $('#customerInfoSection').hide();

        $.ajax({
            url: 'viewCustomer',
            method: 'GET',
            data: {customerId: customerId},
            success: function (response) {
                $('#customerInfoSection').html('<h3>Recipient Information</h3>' + response).show();
                $('html, body').animate({
                    scrollTop: $("#customerInfoSection").offset().top
                }, 500);
                currentOrderId = orderId;
            },
            error: function () {
                alert("Failed to load customer information.");
            }
        });
    }

    function updateDeliveryStatus(orderId, selectElement) {
        const newDeliveryStatus = selectElement.value;

        const formData = new FormData();
        formData.append("orderId", orderId);
        formData.append("deliveryStatus", newDeliveryStatus);

        fetch("orders", {
            method: "POST",
            body: formData
        }).then(res => {
            if (res.ok) {
                alert("Delivery status updated successfully!");
                location.reload();
            } else {
                alert("Failed to update delivery status.");
            }
        }).catch(err => {
            alert("System error!");
            console.error(err);
        });
    }
</script>

        <script>
            function updateStatus(orderId, select) {
                const newStatus = select.value;
                const deliverySelect = $(select).closest('tr').find('select')[1];
                const deliveryStatus = deliverySelect.value;

                $.post('orders', {
                    orderId: orderId,
                    status: newStatus,
                    deliveryStatus: deliveryStatus
                }).done(function (response) {
                    alert(response.message);
                }).fail(function () {
                    alert("Failed to update order status.");
                });
            }

            function updateDeliveryStatus(orderId, select) {
                const newDelivery = select.value;
                const statusSelect = $(select).closest('tr').find('select')[0];
                const status = statusSelect.value;

                $.post('orders', {
                    orderId: orderId,
                    status: status,
                    deliveryStatus: newDelivery
                }).done(function (response) {
                    alert(response.message);
                }).fail(function () {
                    alert("Failed to update delivery status.");
                });
            }
        </script>



    </body>
</html>
