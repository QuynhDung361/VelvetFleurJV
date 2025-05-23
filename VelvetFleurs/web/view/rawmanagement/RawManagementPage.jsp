<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="now" class="java.util.Date" scope="page" />
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Flower Management</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- DataTables Bootstrap 5 CSS -->
        <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

        <style>
            .flower-img {
                width: 60px;
                height: auto;
                object-fit: cover;
            }
        </style>
    </head>
    <body>
        <%@ include file="/view/dashboard/sidebar.jsp" %>
        <div style="margin-left: 250px; padding: 20px;">

            <div class="container my-5">
                <div class="card shadow-sm border rounded-4 p-3">
                    <h2 class="fw-bold mb-4">Manager Flower</h2>
                    <!-- Date Filters -->
                    <div class="row mb-4">
                        <div class="col-md-2">
                            <label for="createDate" class="form-label">Import Date:</label>    
                        </div>
                        <div class="col-md-4">
                            <input type="date" class="form-control" id="createDate" />
                        </div>
                        <div class="col-md-2">
                            <label for="expireDate" class="form-label">Expired Date:</label>    
                        </div>
                        <div class="col-md-4">
                            <input type="date" class="form-control" id="expireDate" />
                        </div>
                    </div>
                    <div class="col-md-6 ">
                        <button class="btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#createFlowerModal" style="margin-bottom: 10px;">
                            Create Flower
                        </button>
                    </div>
                    <!-- Table -->
                    <div class="table-responsive">
                        <table id="flowerTable" class="table table-striped table-bordered text-center">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Flower Image</th>
                                    <th>Flower Name</th>
                                    <th>Quantity</th>
                                    <th>Expired Date</th>
                                    <th>Import Date</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="flower" items="${flowerList}" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td><img src="${flower.image}" alt="${flower.name}" class="flower-img" /></td>
                                        <td>${flower.name}</td>
                                        <td>${flower.quantity}</td>
                                        <td><fmt:formatDate value="${flower.expriseDate}" pattern="MM/dd/yyyy" /></td>
                                        <td><fmt:formatDate value="${flower.createAt}" pattern="MM/dd/yyyy" /></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${flower.quantity == 0}">
                                                    <span class="text-danger">Out of stock</span>
                                                </c:when>
                                                <c:when test="${flower.expriseDate.time lt now.time}">
                                                    <span class="text-warning">Expired</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-success">In stock</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="d-flex justify-content-center gap-2 flex-wrap">
                                                <!-- Delete -->
                                                <form action="deleteRaw" method="get" onsubmit="return confirmDelete()">
                                                    <input type="hidden" name="id" value="${flower.id}" />
                                                    <button class="btn btn-outline-danger" title="Delete">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </form>

                                                <!-- Update -->
                                                <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal"
                                                        data-bs-target="#updateFlowerModal" data-id="${flower.id}" data-name="${flower.name}"
                                                        data-quantity="${flower.quantity}" data-exprise="${flower.expriseDate}"
                                                        data-import="${flower.createAt}"  title="Update">
                                                    <i class="fas fa-pen"></i>
                                                </button>

                                                <!-- View Detail -->

<!--                                                <button type="button" class="btn btn-outline-warning" data-bs-toggle="modal"
                                                        data-bs-target="#viewDetailModal" data-id="${acc.accountID}" title="View detail">
                                                    <i class="fas fa-eye"></i>
                                                </button> -->

                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- Modal -->
            <div class="modal fade" id="createFlowerModal" tabindex="-1" aria-labelledby="createFlowerModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content rounded-4">
                        <div class="modal-header bg-success text-white">
                            <h5 class="modal-title" id="createFlowerModalLabel">Add New Flower</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="addRaw" method="post" >
                                <div class="mb-3">
                                    <label for="createFlowerName" class="form-label">Flower Name</label>
                                    <input type="text" class="form-control" id="createFlowerName" name="name" required />
                                </div>
                                <div class="mb-3">
                                    <label for="createFlowerQuantity" class="form-label">Quantity</label>
                                    <input type="number" class="form-control" id="createFlowerQuantity" name="quantity" required />
                                </div>
                                <div class="mb-3">
                                    <label for="createFlowerImage" class="form-label">Flower Image</label>
                                    <input type="file" class="form-control" id="createFlowerImage" name="image" required />
                                </div>
                                <div class="mb-3">
                                    <label for="createExpriseDate" class="form-label">Expired Date</label>
                                    <input type="date" class="form-control" id="createExpriseDate" name="expriseDate" required />
                                </div>
                                <button type="submit" class="btn btn-success w-100">Create Flower</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="updateFlowerModal" tabindex="-1" aria-labelledby="updateFlowerModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content rounded-4">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title" id="updateFlowerModalLabel">Update Flower</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="updateRaw" method="post" >
                                <input type="hidden" name="id" id="updateFlowerId" value=""/>
                                <div class="mb-3">
                                    <label for="updateFlowerName" class="form-label">Flower Name</label>
                                    <input type="text" class="form-control" name="name" id="updateFlowerName" required />
                                </div>
                                <div class="mb-3">
                                    <label for="updateFlowerQuantity" class="form-label">Quantity</label>
                                    <input type="number" class="form-control" name="quantity" id="updateFlowerQuantity" required />
                                </div>                   
                                <div class="mb-3">
                                    <label for="updateExpriseDate" class="form-label">Expired Date</label>
                                    <input type="date" class="form-control" name="expriseDate" id="updateExpriseDate" required />
                                </div>
                                <div class="mb-3">
                                    <label for="updateCreateDate" class="form-label">Import Date</label>
                                    <input type="date" class="form-control" name="importDate" id="updateCreateDate" required />
                                </div>
                                <button type="submit" class="btn btn-primary w-100">Update Flower</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <!-- Bootstrap Bundle -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- DataTables JS -->
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

        <script>
                                                function confirmDelete() {
                                                    return confirm('Are you sure you want to delete this flower?');
                                                }
                                                $(document).ready(function () {
                                                    $('#updateFlowerModal').on('show.bs.modal', function (event) {
                                                        var button = $(event.relatedTarget); // Button that triggered the modal

                                                        // Get data from button attributes
                                                        var id = button.data('id');
                                                        var name = button.data('name');
                                                        var quantity = button.data('quantity');
                                                        var exprise = button.data('exprise');
                                                        var importDate = button.data('import');

                                                        // Format date strings if necessary
                                                        const formatDate = (dateStr) => {
                                                            const date = new Date(dateStr);
                                                            return date.toISOString().split('T')[0];
                                                        };

                                                        // Update modal fields
                                                        var modal = $(this);
                                                        modal.find('#updateFlowerId').val(id);
                                                        modal.find('#updateFlowerName').val(name);
                                                        modal.find('#updateFlowerQuantity').val(quantity);
                                                        modal.find('#updateExpriseDate').val(formatDate(exprise));
                                                        modal.find('#updateCreateDate').val(formatDate(importDate));
                                                    });
                                                });
                                                $(document).ready(function () {
                                                    var table = $('#flowerTable').DataTable({
                                                        pageLength: 5
                                                    });

                                                    // Custom search filter by Import Date
                                                    $.fn.dataTable.ext.search.push(function (settings, data, dataIndex) {
                                                        const importDate = new Date(data[5]).toISOString().split('T')[0]; // Import Date
                                                        const expiredDate = new Date(data[4]).toISOString().split('T')[0]; // Expired Date

                                                        const selectedImportDate = $('#createDate').val();
                                                        const selectedExpiredDate = $('#expireDate').val();

                                                        const matchImport = !selectedImportDate || importDate === selectedImportDate;
                                                        const matchExpired = !selectedExpiredDate || expiredDate === selectedExpiredDate;

                                                        return matchImport && matchExpired;
                                                    });

                                                    // Trigger table redraw on date change
                                                    $('#createDate, #expireDate').on('change', function () {
                                                        table.draw();
                                                    });
                                                });
                                                function validateForm(formId) {
                                                    const form = document.getElementById(formId);
                                                    const quantity = form.querySelector('[name="quantity"]');
                                                    const expriseDate = form.querySelector('[name="expriseDate"]');

                                                    const today = new Date().toISOString().split('T')[0];

                                                    if (parseInt(quantity.value) <= 0) {
                                                        alert("Quantity must be greater than 0.");
                                                        return false;
                                                    }

                                                    if (expriseDate.value < today) {
                                                        alert("Expired date must not be in the past.");
                                                        return false;
                                                    }

                                                    return true;
                                                }

                                                document.getElementById("createFlowerModal").addEventListener("submit", function (e) {
                                                    if (!validateForm("createFlowerModal"))
                                                        e.preventDefault();
                                                });

                                                document.getElementById("updateFlowerModal").addEventListener("submit", function (e) {
                                                    if (!validateForm("updateFlowerModal"))
                                                        e.preventDefault();
                                                });
        </script>

    </body>

</html>

