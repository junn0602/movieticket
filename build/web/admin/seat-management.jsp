<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="entity.Seat, java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Movie Ticket - Seat List</title>

    <!-- Custom fonts -->
    <link href="${pageContext.request.contextPath}/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles -->
    <link href="${pageContext.request.contextPath}/admin/css/sb-admin-2.min.css" rel="stylesheet">
</head>

<body id="page-top">
    <div id="wrapper">
        <!-- Include Sidebar -->
        <jsp:include page="sidebar.jsp"></jsp:include>

        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <!-- Include Topbar -->
                <jsp:include page="topbar.jsp"></jsp:include>

                <div class="container-fluid">
                    <h1 class="h3 mb-4 text-gray-800">Seat Management</h1>

                    <!-- Debug Info -->
                    <c:if test="${pageContext.request.method == 'GET'}">
                        <div class="alert alert-info">
                            Request Method: ${pageContext.request.method}<br>
                            Seats Attribute: ${not empty seats ? 'Present' : 'Not Present'}<br>
                            Error Attribute: ${not empty error ? error : 'No Error'}
                        </div>
                    </c:if>

                    <!-- Success/Error Messages -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <div class="card shadow mb-4">
                        <div class="card-header py-3 d-flex justify-content-between align-items-center">
                            <h6 class="m-0 font-weight-bold text-primary">All Seats</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <c:choose>
                                    <c:when test="${not empty seats}">
                                        <table class="table table-bordered" id="seatTable" width="100%" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th>Seat ID</th>
                                                    <th>Row</th>
                                                    <th>Number</th>
                                                    <th>Type</th>
                                                    <th>Room</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="seat" items="${seats}">
                                                    <tr>
                                                        <td>${seat.seatID}</td>
                                                        <td>${seat.seatRow}</td>
                                                        <td>${seat.seatNumber}</td>
                                                        <td>${seat.seatType}</td>
                                                        <td>${seat.roomID}</td>
                                                        <td>
                                                            <span class="badge ${seat.status == 'Available' ? 'badge-success' : 'badge-danger'}">
                                                                ${seat.status}
                                                            </span>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="alert alert-warning">Không có ghế nào được tìm thấy.</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Nút Tiếp Tục -->
                    <button class="button" onclick="window.location.href='buy.jsp'">Tiếp tục</button>

                </div>
            </div>

            <!-- Include Footer -->
            <jsp:include page="includes/footer.jsp"></jsp:include>
        </div>
    </div>

    <!-- Scroll to Top Button -->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Bootstrap core JavaScript -->
    <script src="${pageContext.request.contextPath}/admin/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript -->
    <script src="${pageContext.request.contextPath}/admin/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts -->
    <script src="${pageContext.request.contextPath}/admin/js/sb-admin-2.min.js"></script>
</body>
</html>
