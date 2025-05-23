<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Customer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css" rel="stylesheet">
</head>
<body>
    
     <div style="margin-left: 250px; padding: 20px;">
            <%@ include file="/view/dashboard/sidebar.jsp" %>
<div class="container my-5">
<!--    <div class="card shadow-sm border rounded-4 p-4">-->
        <h2 class="mb-4">Customer Accounts</h2>

        <div class="table-responsive">
            <table id="customerTable" class="table table-striped table-bordered text-center">
                <thead>
                    <tr>
                        <th>Customer ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="entry" items="${customerMap}">
                        <c:set var="cus" value="${entry.key}" />
                        <c:set var="status" value="${entry.value}" />
                        <tr>
                            <td>${cus.id}</td>
                            <td>${cus.fullName}</td>
                            <td>${cus.email}</td>
                            <td>${cus.phone}</td>
                            <td>${cus.address}</td>
                            <td>
                                <form action="customermanagement" method="post" style="display:inline;">
                                    <input type="hidden" name="accountID" value="${cus.accountId}" />
                                    <input type="hidden" name="status" value="${status == 1 ? 0 : 1}" />
                                    <button type="submit" class="btn btn-sm ${status == 1 ? 'btn-danger' : 'btn-success'}">
                                        ${status == 1 ? 'Active' : 'Inactive'}
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
<!--    </div>-->
</div>
     </div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
<script>
    $(document).ready(function () {
        $('#customerTable').DataTable({
            
        pageLength: 5
        });
    });
</script>
</body>
</html>