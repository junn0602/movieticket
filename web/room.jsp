
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@page import="java.util.List"%>
<%@page import="entity.CinemaRoom, entity.Account"%>
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
        <title>Cinema Seating</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4dc;
                text-align: center;
            }
            header {
                display: flex;
                justify-content: space-between; /* Đẩy menu vào giữa, login ra phải */
                align-items: center;
                background-color: #b22222;
                padding: 10px 20px;
                color: white;
                width : 100vw;
                box-sizing: border-box;
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
            }
            .theater-name {
                font-size: 28px;
                font-weight: bold;
                margin-bottom: 10px;
            }
            .divider {
                width: 50%;
                margin: 0 auto;
                height: 3px;
                background-color: black;
                margin-bottom: 20px;
            }
            .seat-container {
                display: grid;
                grid-template-columns: repeat(5, 1fr);
                gap: 10px;
                background-color: #d3d3d3;
                padding: 20px;
                border-radius: 8px;
                width: fit-content;
                margin: 0 auto;
            }
            .seat {
                background-color: white;
                padding: 15px;
                border-radius: 4px;
                font-weight: bold;
            }
            .address {
                font-size: 18px;
                margin-top: 20px;
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
            html, body {
                height: 100%;
                margin: 0;
                display: flex;
                flex-direction: column;
            }

            main {
                flex: 1;
                display: flex;
                flex-direction: column;
                justify-content: center; /* Đẩy nội dung vào giữa nếu ít */
                align-items: center;
                padding: 20px;
            }

            footer {
                background-color: #333;
                color: white;
                text-align: center;
                padding: 10px;
                width: 100%;
                margin-top: auto; /* Đảm bảo footer luôn nằm dưới */
            }



            .navbar{
                position: sticky;
                top: 0; /* Đảm bảo navbar cố định ở trên cùng */
                z-index: 1000; /* Đảm bảo navbar luôn nằm trên các phần tử khác */
                width: 100%; /* Đảm bảo chiều rộng của navbar luôn là 100% */
            }
        </style>
    </head>
    <body><header>
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
            <div class="theater-name">Cinema Rooms</div>
            <div class="divider"></div>
            <h3>Room List</h3>
            <div class="seat-container">
                <% 
                    List<CinemaRoom> rooms = (List<CinemaRoom>) session.getAttribute("CINEMA_ROOM_LIST");  
                    if (rooms != null && !rooms.isEmpty()) {  
                        for (CinemaRoom room : rooms) { 
                %>
                <div class="seat">
                    <%= room.getRoomName() %>
                </div>
                <% } } else { %>
                <p>No rooms available</p>
                <% } %>
            </div>
            <div class="divider"></div>

            <footer>
                <div class="social-icons">
                    <a href="#"><img src="images/facebook.png" alt="Facebook"><span>Facebook</span></a>
                    <a href="#"><img src="images/youtube.png" alt="YouTube"><span>YouTube</span></a>
                    <a href="#"><img src="images/tiktok.png" alt="TikTok"><span>TikTok</span></a>
                </div>
            </footer>
        </main>
    </body>
</html>
