<%@ page import="entity.Account,entity.Movie" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    Object accObj = session.getAttribute("account");
    Account account = null;
    if (accObj instanceof Account) {
        account = (Account) accObj;
    }
    boolean isLoggedIn = (account != null);
    boolean isAdmin = isLoggedIn && "admin".equalsIgnoreCase(account.getRole());
    boolean isManager = isLoggedIn && "Manager".equalsIgnoreCase(account.getRole());
    Integer customerID = (Integer) session.getAttribute("CustomerID");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>Lodge</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.1.3/assets/owl.carousel.min.css" />
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
        <link href="https://fonts.googleapis.com/css?family=Poppins:400,600,700&display=swap" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet" />
        <link href="css/responsive.css" rel="stylesheet" />

        <style>
            .navbar {
                background: #fff;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                padding: 15px 30px;
            }

            .navbar-container {
                max-width: 1200px;
                margin: 0 auto;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .logo {
                display: flex;
                align-items: center;
                text-decoration: none;
                color: #333;
            }

            .logo img {
                height: 35px;
                margin-right: 10px;
            }

            .logo span {
                font-size: 24px;
                font-weight: 600;
            }

            .nav-menu {
                display: flex;
                align-items: center;
                gap: 30px;
            }

            .nav-menu a {
                color: #333;
                text-decoration: none;
                font-size: 16px;
                font-weight: 500;
                transition: color 0.3s ease;
            }

            .nav-menu a:hover {
                color: #ff9800;
            }

            .profile-menu {
                position: relative;
            }

            .profile-container {
                display: none;
                position: absolute;
                top: 100%;
                right: 0;
                background: white;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                min-width: 200px;
                z-index: 1000;
            }

            .profile-container.active {
                display: block;
            }

            .profile-container a {
                display: block;
                padding: 8px 0;
                color: #333;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .profile-container a:hover {
                color: #ff9800;
            }

            @media (max-width: 768px) {
                .nav-menu {
                    display: none;
                }
            }
        </style>
    </head>

    <body>
        <%List<Movie> list = (List<Movie>) request.getAttribute("listM");%>
        <div class="hero_area">
            <nav class="navbar">
                <div class="navbar-container">
                    <a class="logo" href="home.jsp">
                        <img src="images/logo1.png" alt="Lodge">
                        <span>Lodge</span>
                    </a>
                    <div class="nav-menu">
                        <a href="MovieController?action=list">Movie</a>
                        <a href="CinemaController">Cinema</a>
                        <% if (!isLoggedIn) { %>
                            <a href="login.jsp">Login</a>
                        <% } else { %>
                            <div class="profile-menu">
                                <a href="#" onclick="showProfile(event)">
                                    <%= account.getName() %>
                                </a>
                                <div id="profileContainer" class="profile-container">
                                    <% if (isAdmin || isManager) { %>
                                        <a href="admin">Admin Dashboard</a>
                                    <% } %>
                                    <a href="profile.jsp">Profile</a>
                                    <a href="LogoutController">Logout</a>
                                </div>
                            </div>
                        <% } %>
                    </div>
                </div>
            </nav>
            <!-- slider section -->
            <section class=" slider_section position-relative">
                <div class="design-box">
                    <img src="images/design-1.png" alt="">
                </div>

                <!--                <div class="container">
                                    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                                        <ol class="carousel-indicators">
                                            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                                            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                                            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                                        </ol>
                                        <div class="carousel-inner">
                                             Slide 1 
                                            <div class="carousel-item active">
                                                <div class="row">
                                                     C?t trái: Hình ?nh 
                                                    <div class="col-md-6">
                                                        <div class="img-box">
                                                            <img src="images/banner1.jpeg" class="img-fluid" alt="Movie 1">
                                                        </div>
                                                    </div>
                                                     C?t ph?i: Thông tin phim 
                                                    <div class="col-md-6">
                                                        <div class="detail_box">
                                                            <h2>
                                                                <span>New Movies</span>
                                                                <hr>
                                                            </h2>
                                                            <h1>Movie 1</h1>
                                                            <p>
                                                                Lorem ipsum dolor sit amet consectetur adipiscing elit. 
                                                            </p>
                                                            <div>
                                                                <a href="">Order Now</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                             Slide 2 
                                            <div class="carousel-item">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="img-box">
                                                            <img src="images/banner2.jpeg" class="img-fluid" alt="Movie 2">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="detail_box">
                                                            <h2>
                                                                <span>New Movies</span>
                
                                                            </h2>
                                                            <h1>Movie 2</h1>
                                                            <p>
                                                                Lorem ipsum dolor sit amet consectetur adipiscing elit.
                                                            </p>
                                                            <div>
                                                                <a href="">Order Now</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                             Slide 3 
                                            <div class="carousel-item">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="img-box">
                                                            <img src="images/banner3.jpg" class="img-fluid" alt="Movie 3">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="detail_box">
                                                            <h2>
                                                                <span>New Movies</span>
                
                                                            </h2>
                                                            <h1>Movie 3</h1>
                                                            <p>
                                                                Lorem ipsum dolor sit amet consectetur adipiscing elit.
                                                            </p>
                                                            <div>
                                                                <a href="">Order Now</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>-->
                <!-- Nút ?i?u h??ng -->
                <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
               
                

            </section>
            <!-- end slider section -->
        </div>

        <!-- item section -->

        <section class="price_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>Comming Soon</h2>
                </div>
                <div class="price_container">
                    <% if (list != null && list.size() >= 3) { 
                       for (int i = list.size() - 3; i < list.size(); i++) { 
                                Movie movie = list.get(i);
                    %>
                    <div class="box">
                        <div class="img-box">
                            <img src="<%= request.getContextPath() + "/" + movie.getMoviePoster() %>" alt="Movie Poster">
                        </div>
                        <div class="name">
                            <p><%= movie.getMovieName() %></p>
                        </div>
                        <div class="dur">
                            <p><%= movie.getDuration() %></p>
                        </div>
                        <div class="genr">
                            <p><%= movie.getGenre() %></p>
                        </div>
                        <div class="dir">
                            <p><%= movie.getDirector() %></p>
                        </div>
                        <div class="rel">
                            <p><%= movie.getReleaseDate() %></p>
                        </div>
                        <div class="">
                            <p><span><%= movie.getCountry() %></span></p>

                            <a href="MovieController?action=detail&id=<%= movie.getMovieID()%>">Detail</a>

                        </div>
                    </div>
                    <% } 
            } else { %>
                    <p>There are currently not enough movies to display.</p>
                    <% } %>
                </div>
            </div>
        </section>


        <!-- end item section -->

        <!-- about section -->



        <!-- end about section -->

        <!-- price section -->

        <section class="price_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>Now Showing</h2>
                </div>
                <div class="price_container">
                    <% if (list != null && list.size() >= 3) { 
                        for (int i = 0; i < 3; i++) { 
                            Movie movie = list.get(i);
                    %>
                    <div class="box">
                        <div class="img-box">
                            <img src="<%= request.getContextPath() + "/" + movie.getMoviePoster() %>" alt="Movie Poster">
                        </div>
                        <div class="name">
                            <p><%= movie.getMovieName() %></p>
                        </div>
                        <div class="dur">
                            <p><%= movie.getDuration() %></p>
                        </div>
                        <div class="genr">
                            <p><%= movie.getGenre() %></p>
                        </div>
                        <div class="dir">
                            <p><%= movie.getDirector() %></p>
                        </div>
                        <div class="rel">
                            <p><%= movie.getReleaseDate() %></p>
                        </div>
                        <div class="">
                            <p><span><%= movie.getCountry() %></span></p>

                            <a href="MovieController?action=detail&id=<%= movie.getMovieID()%>">Detail</a>

                        </div>
                    </div>
                    <% } 
            } else { %>
                    <p>There are currently not enough movies to display.</p>
                    <% } %>
                </div>
            </div>
        </section>

        <!-- end price section -->

        <!-- ring section -->


        <!--        <section class="ring_section layout_padding">
                    <div class="design-box">
                        <img src="images/design-1.png" alt="">
                    </div>
                    <div class="container">
                        <div class="ring_container layout_padding2">
                            <div class="row">
                                <div class="col-md-5">
                                    <div class="detail-box">
                                        <h4>
                                            special
                                        </h4>
                                        <h2>
                                            Wedding Ring
                                        </h2>
                                        <a href="buy.jsp">
                                            Buy Now
                                        </a>
                                    </div>
                                </div>
                                <div class="col-md-7">
                                    <div class="img-box">
                                        <img src="images/ring-img.jpg" alt="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>-->

        <!--        <section class="ring_section layout_padding">
                    <div class="design-box">
                        <img src="images/design-1.png" alt="">
                    </div>
                    <div class="container">
                        <div class="ring_container layout_padding2">
                            <div class="row">
                                <div class="col-md-5">
                                    <div class="detail-box">
                                        <h4>
                                            special
                                        </h4>
                                        <h2>
                                            Wedding Ring
                                        </h2>
                                        <a href="buy.jsp">
                                            Buy Now
                                        </a>
                                    </div>
                                </div>
                                <div class="col-md-7">
                                    <div class="img-box">
                                        <img src="images/ring-img.jpg" alt="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>-->




        <!-- info section -->
        <section class="info_section ">
            <div class="container">
                <div class="info_container">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="info_logo">
                                <a href="">
                                    <img src="images/logo.png" alt="">
                                    <span>
                                        Lodge
                                    </span>
                                </a>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="info_contact">
                                <a href="">
                                    <img src="images/location.png" alt="">
                                    <span>
                                        Address
                                    </span>
                                </a>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="info_contact">
                                <a href="">
                                    <img src="images/phone.png" alt="">
                                    <span>
                                        +01 1234567890
                                    </span>
                                </a>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="info_contact">
                                <a href="">
                                    <img src="images/mail.png" alt="">
                                    <span>
                                        demo@gmail.com
                                    </span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="info_form">
                        <div class="d-flex justify-content-center">
                            <h5 class="info_heading">
                                Newsletter
                            </h5>
                        </div>
                        <form action="">
                            <div class="email_box">
                                <label for="email2">Enter Your Email</label>
                                <input type="text" id="email2">
                            </div>
                            <div>
                                <button>
                                    subscribe
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="info_social">
                        <div class="d-flex justify-content-center">
                            <h5 class="info_heading">
                                Follow Us
                            </h5>
                        </div>
                        <div class="social_box">
                            <a href="">
                                <img src="images/fb.png" alt="">
                            </a>
                            <a href="">
                                <img src="images/twitter.png" alt="">
                            </a>
                            <a href="">
                                <img src="images/linkedin.png" alt="">
                            </a>
                            <a href="">
                                <img src="images/insta.png" alt="">
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- end info_section -->

        <!-- footer section -->
        <section class="container-fluid footer_section">
            <p>
                &copy; <span id="displayYear"></span> All Rights Reserved By
                <a href="https://html.design/">Free Html Templates</a>
            </p>
        </section>
        <!-- footer section -->

        <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.js"></script>
        <script type="text/javascript" src="js/custom.js"></script>


        <script>
            function showProfile(event) {
                event.preventDefault();
                var profile = document.getElementById('profileContainer');
                profile.classList.toggle('active');
                
                // Close profile menu when clicking outside
                document.addEventListener('click', function(e) {
                    if (!e.target.closest('.profile-menu')) {
                        profile.classList.remove('active');
                    }
                });
            }
        </script>
    </body>
</html>