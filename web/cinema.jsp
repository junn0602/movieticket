
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%@page import="java.util.List"%>
<%@page import="entity.Cinema, entity.Account"%>

<%
   
    
    Object accObj = session.getAttribute("account");
    Account account = null;
    if (accObj instanceof Account) {
        account = (Account) accObj;
    }

    boolean isLoggedIn = (account != null);
    Integer customerID = (Integer) session.getAttribute("CustomerID");
    
    

%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CINEMATIC</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4dc;
            }
            header {
                display: flex;
                justify-content: space-between; /* Đẩy menu vào giữa, login ra phải */
                align-items: center;
                background-color: #b22222;
                padding: 10px 20px;
                color: white;
            }

            /* Container để chứa menu */
            .nav-container {
                flex: 1; /* Giúp menu nằm ở giữa */
                display: flex;
                justify-content: center; /* Căn giữa menu */
            }

            nav ul {
                list-style: none;
                display: flex;
                gap: 20px;
                padding: 0;
                margin: 0;
            }

            nav ul li {
                display: inline;
            }

            nav ul li a {
                color: white;
                text-decoration: none;
                font-size: 18px;

                padding: 10px;
            }

            /* Đẩy login ra góc phải */
            .auth {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .auth p {
                margin: 0;
                font-size: 18px;

            }

            .auth a {
                color: white;
                text-decoration: none;
                font-size: 18px;

                padding: 10px;
            }
            main {
                padding: 20px;
                text-align: center;
            }
            .cinema-container {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 20px;
                justify-content: center;
                margin-top: 20px;
            }
            .cinema-card {
                background-color: white;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }
            .cinema-card img {
                width: 80px;
                height: auto;
                border-radius: 8px;
                display: block;
                margin: 0 auto 10px;
            }
            .cinema-card p {
                font-size: 16px;
                font-weight: bold;
                margin: 0;
                color: #333;
            }
            html, body {
                height: 100%;
                margin: 0;
                display: flex;
                flex-direction: column;
            }

            main {
                flex: 1;
            }

            footer {
                background-color: #333;
                color: white;
                text-align: center;
                padding: 10px;
                width: 100%;
            }

            .social-icons {
                display: flex;
                justify-content: center;
                gap: 20px; /* Khoảng cách giữa các icon */
            }

            .social-icons a {
                display: flex;
                align-items: center;
                text-decoration: none;
                color: white; /* Màu chữ */
                font-size: 16px;
                font-weight: bold;
                gap: 8px; /* Khoảng cách giữa logo và chữ */
            }

            .social-icons img {
                width: 30px; /* Kích thước logo */
                height: auto;
            }

            footer {
                background-color: #333;
                text-align: center;
                padding: 10px;
                position: static;
                bottom: 0;
                width: 100%;
            }

        </style>
    </head>
    <body>
        <header>
            <!-- Menu nằm ở giữa -->
            <div class="nav-container">
                <nav>
                    <ul>
                        <li><a href="home">HOME</a></li>
                        <li><a href="MovieController?action=list">MOVIES</a></li>
                        <li><a href="CimemaController">CINEMAS</a></li>
                        <li><a href="#">MEMBERS</a></li>
                    </ul>
                </nav>
            </div>

            <!-- Login nằm bên phải -->
            <nav class="auth">
                <% if (isLoggedIn) { %>
                <p><strong>Xin chào, <%= account.getName() %>!</strong></p>
                <a href="logout">Logout</a>
                <% } else { %>
                <a href="login.jsp">Login</a>
                <% } %>
            </nav>
        </header>


        <main>
            <h2>Cinemas</h2>
            <div class="cinema-container">
                <% 
                    List<Cinema> cinemas = (List<Cinema>) request.getAttribute("CINEMA_LIST");  
                    if (cinemas != null && !cinemas.isEmpty()) {  
                        for (Cinema cinema : cinemas) { 
                %>
                <div class="cinema-card" onclick="window.location.href = 'CinemaRoomController?action=byCinema&cinemaID=<%= cinema.getCinemaID() %>'" >
                    <img src="https://c8.alamy.com/comp/2KE1GD2/cinema-building-vector-illustration-isolated-on-white-background-movie-theater-and-houses-exterior-view-in-flat-style-2KE1GD2.jpg" alt="<%= cinema.getCinemaName() %> Cinema">
                    <p><%= cinema.getCinemaName() %></p>
                </div>
                <% } } else { %>
                <p>No cinemas available</p>
                <% } %>
            </div>
        </main>

        <footer>
            <div class="social-icons">
                <a href="#"><img src="images/facebook.png" alt="Facebook"><span>Facebook</span></a>
                <a href="#"><img src="images/youtube.png" alt="YouTube"><span>YouTube</span></a>
                <a href="#"><img src="images/tiktok.png" alt="TikTok"><span>TikTok</span></a>
            </div>
        </footer>
    </body>
</html>
