<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="userRole" value="${sessionScope.account.role}" />
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Customer Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- DataTables Bootstrap 5 CSS -->
        <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">      
    </head>
    <body>   
        <div style="margin-left: 250px; padding: 20px;">
            <%@ include file="/view/dashboard/sidebar.jsp" %>
            <div class="container my-5">
<!--                <div class="card shadow-sm border rounded-4 p-3">-->
                    <h2 class="mb-4">Manager ${userRole == 'Admin' ? 'Manager' : 'Seller'}</h2>
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <input type="text" id="usernameSearch" class="form-control" placeholder="Search Username...">
                        </div>
                        <div class="col-md-4">
                            <select id="StatusFilter" class="form-select">
                                <option value="">All Status</option>
                                <option value="Active">Active</option>
                                <option value="Inactive">Inactive</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <button class="btn btn-outline-success w-100" data-bs-toggle="modal"
                                    data-bs-target="#addStaffModal">
                                Add ${userRole == 'Admin' ? 'Manager' : 'Seller'}
                            </button>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table id="accountTable" class="table table-striped table-bordered text-center">
                            <thead>
                                <tr>

                                    <th>Customer ID</th>
                                    <th>Username</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${userRole == 'Admin'}">  
                                        <c:forEach var="acc" items="${accountList2}">
                                            <tr>
                                                <td>${acc.accountID}</td>
                                                <td>${acc.username}</td>
                                                <td>${acc.role}</td>                                 
                                                <td>
                                                    <form action="account" method="post" style="display:inline;">
                                                        <input type="hidden" name="accountID" value="${acc.accountID}" />
                                                        <input type="hidden" name="status" value="${acc.status == 1 ? 0 : 1}" />
                                                        <button type="submit" class="btn btn-sm ${acc.status == 1 ? 'btn-danger' : 'btn-success'}">
                                                            ${acc.status == 1 ? 'Active' : 'Inactive'}
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>  
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="acc" items="${accountList1}">
                                            <tr>
                                                <td>${acc.accountID}</td>
                                                <td>${acc.username}</td>
                                                <td>${acc.role}</td>                                 
                                                <td>
                                                    <form action="account" method="post" style="display:inline;">
                                                        <input type="hidden" name="accountID" value="${acc.accountID}" />
                                                        <input type="hidden" name="status" value="${acc.status == 1 ? 0 : 1}" />
                                                        <button type="submit" class="btn btn-sm ${acc.status == 1 ? 'btn-danger' : 'btn-success'}">
                                                            ${acc.status == 1 ? 'Active' : 'Inactive'}
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach> 
                                    </c:otherwise>
                                </c:choose>


                            </tbody>
                        </table>
                    </div>                
<!--                </div>      -->
                <!-- Modal -->
                <div class="modal fade" id="addStaffModal" tabindex="-1" aria-labelledby="addStaffLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content rounded-4">
                            <div class="modal-header bg-success text-white">
                                <h5 class="modal-title" id="addStaffModalLabel">
                                    Add New ${userRole == 'Admin' ? 'Manager' : 'Seller'}
                                </h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="${userRole == 'Admin' ? 'addManager' : 'addStaff'}" method="post">
                                    <div class="mb-3">
                                        <label for="staffUsername" class="form-label">Username</label>
                                        <input type="text" class="form-control" id="staffUsername" name="username" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="staffPassword" class="form-label">Password</label>
                                        <input type="password" class="form-control" id="staffPassword" name="password" required>
                                    </div>
                                    <button type="submit" class="btn btn-success w-100">
                                        Add ${userRole == 'Admin' ? 'Manager' : 'Seller'}
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <!-- Bootstrap Bundle -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- DataTables JS -->
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
        <script>
            $(document).ready(function () {
                const table = $('#accountTable').DataTable({
                    pageLength: 5,
                    dom: 'rt<"bottom"lip>' // Ẩn ô search mặc định
                });

                $.fn.dataTable.ext.search.push(function (settings, data, dataIndex) {
                    const username = data[1].toLowerCase();
                    const role = data[2].trim();
                    const status = $(table.row(dataIndex).node()).find('td:eq(3)').text().trim();

                    const selectedUsername = $('#usernameSearch').val().toLowerCase();
                    const selectedRole = $('#roleFilter').val();
                    const selectedStatus = $('#StatusFilter').val();

                    const matchUsername = !selectedUsername || username.includes(selectedUsername);
                    const matchRole = !selectedRole || role === selectedRole;
                    const matchStatus = !selectedStatus || status === selectedStatus;

                    return matchUsername && matchRole && matchStatus;
                });

                $('#usernameSearch, #roleFilter, #StatusFilter').on('input change', function () {
                    table.draw();
                });
            });
            $(document).ready(function () {
                // Existing DataTables filter code...

                // Custom validation
                $('#addStaffModal form').on('submit', function (e) {
                    const username = $('#staffUsername').val().trim();
                    const password = $('#staffPassword').val().trim();

                    const usernameRegex = /^[A-Za-z\s]{1,30}$/;

                    let isValid = true;
                    let errorMessage = '';

                    if (!usernameRegex.test(username)) {
                        isValid = false;
                        errorMessage += '- Username must contain only letters and spaces (max 30 characters).\n';
                    }

                    if (password.length === 0 || password.length > 20) {
                        isValid = false;
                        errorMessage += '- Password must be between 1 and 20 characters.\n';
                    }

                    if (!isValid) {
                        alert('Validation failed:\n' + errorMessage);
                        e.preventDefault(); // prevent form submission
                    }
                });
            });
        </script>
    </body>
</html>
