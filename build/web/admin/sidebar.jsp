<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="indexAdmin.jsp">
        <div class="sidebar-brand-icon">
            <i class="fas fa-film"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Movie Ticket Admin</div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item">
        <a class="nav-link" href="indexAdmin.jsp">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Dashboard</span>
        </a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
        Management
    </div>

    <!-- Nav Item - Account Management -->
    <li class="nav-item active">
        <a class="nav-link" href="account?service=ListAllCustomer">
            <i class="fas fa-fw fa-users"></i>
            <span>Account Management</span>
        </a>
    </li>

    <!-- Nav Item - Movie Management -->
    <li class="nav-item">
        <a class="nav-link" href="movie-management.jsp">
            <i class="fas fa-fw fa-film"></i>
            <span>Movie Management</span>
        </a>
    </li>

    <!-- Nav Item - Showtime Management -->
    <li class="nav-item">
        <a class="nav-link" href="showtime-management.jsp">
            <i class="fas fa-fw fa-clock"></i>
            <span>Showtime Management</span>
        </a>
    </li>

    <!-- Nav Item - Booking Management -->
    <li class="nav-item">
        <a class="nav-link" href="booking-management.jsp">
            <i class="fas fa-fw fa-ticket-alt"></i>
            <span>Booking Management</span>
        </a>
    </li>
    
        <li class="nav-item">
        <a class="nav-link" href="/bc6/admin/promo">
            <i class="fas fa-fw fa-ticket-alt"></i>
            <span>Promotion Management</span>
        </a>
    </li>
    
         <li class="nav-item">
        <a class="nav-link" href="/bc6/admin/combo">
            <i class="fas fa-fw fa-ticket-alt"></i>
            <span>Combo Management</span>
        </a>
    </li>
    
    <li class="nav-item">
        <a class="nav-link" href="/bc6/CinemaManageController">
            <i class="fas fa-fw fa-ticket-alt"></i>
            <span>Cinema Manage </span>
        </a>
    </li>
    
    
    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>
</ul>
<!-- End of Sidebar -->
