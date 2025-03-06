<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@page import="java.util.List"%>
<%@page import="entity.Movie,entity.Account"%>
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
        <title>MOVIE</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #ffffff;
                background-image: url('images/hero-bg.png');
                background-size: cover; /* Lấp đầy toàn bộ trang */
                background-position: center; /* Căn giữa ảnh */
                background-attachment: fixed; /* Giữ ảnh nền cố định khi cuộn */
                overflow-x: hidden;
            }

            header, main, footer {
                width: 100%;
                max-width: 100%; /* Đảm bảo chiều rộng tối đa */
                box-sizing: border-box; /* Đảm bảo padding không làm phần tử bị rộng quá */
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
            }
            .now-showing {
                text-align: center;
            }
            .movies-container {
                display: flex;
                gap: 20px;
                flex-wrap: wrap; /* Cho phép các thẻ phim gói lại khi cần thiết */
                justify-content: center; /* Canh giữa các thẻ phim */
                margin-top: 20px;
                box-sizing: border-box; /* Đảm bảo padding không gây vượt chiều rộng */
            }
            .movie-card {
                background-color: white;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
                width: 250px; /* Đặt chiều rộng cố định cho thẻ phim */
                height: 420px; /* Đặt chiều cao cố định */
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                margin-bottom: 20px; /* Khoảng cách giữa các thẻ phim */
                box-sizing: border-box; /* Đảm bảo padding không làm phần tử rộng ra ngoài */
            }

            .movie-card img {
                width: 100%;
                height: 320px; /* Giảm chiều cao ảnh để cân đối với thẻ phim */
                object-fit: cover;
                border-radius: 8px;
            }

            .movie-card p {
                font-size: 16px;
                margin-top: 10px;
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;
            }

            .movie-card button {
                background-color: red;
                color: white;
                border: none;
                padding: 10px;
                cursor: pointer;
                margin-top: 10px;
                border-radius: 5px;
            }


            .movie-card button {
                background-color: red;
                color: white;
                border: none;
                padding: 12px;
                cursor: pointer;
                margin-top: 10px;
                border-radius: 5px;
            }

            .movie-card p {
                font-size: 16px;
                margin-top: 10px;
                text-overflow: ellipsis;
                overflow: hidden;
                white-space: nowrap;
            }

            .movie-card button {
                background-color: red;
                color: white;
                border: none;
                padding: 10px;
                cursor: pointer;
                margin-top: 10px;
            }
            footer {
                background-color: #333;
                text-align: center;
                padding: 10px;
                position: static;
                bottom: 0;
                width: 100%;
            }
            .social-icons img {
                width: 30px;
                margin: 0 5px;
            }



            .now-showing {
                text-align: center;
                max-width: 1200px;
                margin: 0 auto;
                overflow: hidden;
            }

            .movies-container {
                display: flex;
                gap: 20px;
                overflow-x: auto;
                white-space: nowrap;
                padding-bottom: 10px;
                max-width: 100%;
                margin: 0 auto;
            }

            .movies-container::-webkit-scrollbar {
                height: 8px; /* Thanh cu?n ngang */
            }

            .movies-container::-webkit-scrollbar-thumb {
                background-color: red;
                border-radius: 10px;
            }

            .movies-container::-webkit-scrollbar-track {
                background-color: #f4f4dc;
            }

            .navbar{
                position: sticky;
                top: 0; /* Đảm bảo navbar cố định ở trên cùng */
                z-index: 1000; /* Đảm bảo navbar luôn nằm trên các phần tử khác */
                width: 100%; /* Đảm bảo chiều rộng của navbar luôn là 100% */
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
            <section class="now-showing">
                <h2>Now Showing</h2>
                <div class="movies-container">
                    <% 
         List<Movie> movie = (List<Movie>) request.getAttribute("MOVIE_LIST");  
         if (movie != null && !movie.isEmpty()) {  
                    %>
                    <div class="movies-container">
                        <% for (Movie mv : movie) { %>
                        <div class="movie-card">
                            <img src="<%= mv.getMoviePoster() %>" alt="Movie Poster">
                            <p><strong><%= mv.getMovieName() %></strong></p>
                            <button onclick="window.location.href = 'MovieController?action=detail&id=<%= mv.getMovieID() %>'">View Details</button>
                        </div>
                        <% } %>
                    </div>
                    <% } else { %>
                    <p>No movies available</p>
                    <% } %>

                </div>

            </section>
        </main>

        <footer>
            <div class="social-icons">
                <a href="#"><img src="images/facebook.png" alt="Facebook"><span>Facebook</span></a>
                <a href="#"><img src="images/youtube.png" alt="YouTube"><span>YouTube</span></a>
                <a href="#"><img src="images/tiktok.png" alt="TikTok"><span>TikTok</span></a>
            </div>
        </footer>

        <script src="script.js"></script>
    </body>
</html>
