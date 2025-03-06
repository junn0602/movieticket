<%@page import="entity.Movie, entity.Account"%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
    <title>Movie Details</title>
    <link rel="stylesheet" href="styles.css">
    <style>
     main {
    flex: 1;
    padding: 20px;
}  
        
    body {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
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
        .movie-detail {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: auto;
        }
        .movie-info {
            display: flex;
            gap: 20px;
        }
        .movie-info img {
            width: 200px;
            border-radius: 8px;
        }
        .details h3 {
            margin-top: 0;
        }
        .trailer, .buy-ticket {
            background-color: red;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            margin-right: 10px;
        }
        .description {
            margin-top: 20px;
        }
.footer {
    background-color: #333 !important;
    color: white;
    text-align: center;
    padding: 15px;
    width: 100%;
    margin-top: auto;
    position: absolute;
    bottom: 0;
    left: 0;
}
.social-icons {
    display: flex;
    justify-content: center;
    gap: 20px; /* Khoảng cách giữa các icon */
    background-color: #333;    
        padding: 10px;
}

.social-icons a {
    display: flex;
    align-items: center;
    text-decoration: none;
    color: white;
    font-size: 16px;
    font-weight: bold;
    gap: 8px;
}

.social-icons img {
    width: 30px; /* Kích thước logo */
    height: auto;
}

        .header logo li a {
    color: white;
    text-decoration: none;
    font-size: 18px;  /* Đặt kích thước chữ */
    font-weight: bold;  /* Đặt chữ đậm nếu cần */
    padding: 10px;
}
.footer color{
    background-color : #333;
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
        <%
            Movie movie = (Movie) request.getAttribute("MOVIE_DETAIL");
            if (movie != null) {
        %>
        <section class="movie-detail">
            <h2><%= movie.getMovieName() %> - Details</h2>
            <div class="movie-info">
                <img src="<%= movie.getMoviePoster() %>" alt="Movie Poster">
                <div class="details">
                    <h3><%= movie.getMovieName() %></h3>
                    <p><strong>Director:</strong> <%= movie.getDirector() %></p>
                    <p><strong>Genre:</strong> <%= movie.getGenre() %></p>
                    <p><strong>Duration:</strong> <%= movie.getDuration() %> minutes</p>
                    <p><strong>Release Year:</strong> <%= movie.getReleaseDate() %></p>
                    <p><strong>Rating:</strong> <%= movie.getAgeRate() %></p>
                    <a href="<%= movie.getTrailerURL() %>" target="_blank">
                        <button class="trailer">Watch Trailer</button>
                    </a>
                    <button class="buy-ticket">BUY TICKET</button>
                </div>
            </div>
        </section>
        
        <section class="description">
            <h3>Description</h3>
            <p><%= movie.getDescription() %></p>
        </section>
        <% } else { %>
            <p>Movie details not available.</p>
        <% } %>
    </main>
    
    <footer style ="color">
<div class="social-icons">
        <a href="#"><img src="images/facebook.png" alt="Facebook"><span>Facebook</span></a>
        <a href="#"><img src="images/youtube.png" alt="YouTube"><span>YouTube</span></a>
        <a href="#"><img src="images/tiktok.png" alt="TikTok"><span>TikTok</span></a>
    </div>
    </footer>
</body>
</html>