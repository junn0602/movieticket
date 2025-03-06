
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
        <!-- Basic -->
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- Mobile Metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <!-- Site Metas -->
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <meta name="author" content="" />

        <title>Lodge</title>

        <!-- slider stylesheet -->
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.1.3/assets/owl.carousel.min.css" />

        <!-- bootstrap core css -->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

        <!-- fonts style -->
        <link href="https://fonts.googleapis.com/css?family=Baloo+Chettan|Poppins:400,600,700&display=swap" rel="stylesheet">
        <!-- Custom styles for this template -->
        <link href="css/style.css" rel="stylesheet" />
        <!-- responsive style -->
        <link href="css/responsive.css" rel="stylesheet" />

        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;

            }

            .navbar {
                background: #333;
                color: white;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0px 30px;
                width: 100%; /* Phủ toàn bộ chiều ngang */
                position: relative;
                box-sizing: border-box; /* Đảm bảo padding không làm thay đổi kích thước */

            }


            .navbar .logo {
                font-size: 28px;
                font-weight: bold;
                display: flex;
                align-items: center;
            }

            .navbar .logo img {
                height: 40px;
                margin-right: 10px;
            }

            .navbar .menu {
                position: absolute;
                left: 50%;
                transform: translateX(-50%);
            }

            .navbar ul {
                list-style: none;
                display: flex;
            }

            .navbar ul li {
                margin: 0 20px;
            }

            .navbar ul li a {
                color: white;
                text-decoration: none;
                font-size: 18px;
                transition: 0.3s;
            }

            .navbar ul li a:hover {
                color: #f39c12;
            }
            .profile {
                margin-left: auto;
            }

            .profile a {
                color: white;
                text-decoration: none;
                font-size: 18px;
                transition: 0.3s;
            }

            .profile a:hover {
                color: #f39c12;
            }
            .img-box img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                border-radius: 8px;
            }

            .detail_box {
                padding: 20px;
                text-align: left;
            }

            .detail_box h2 span {
                color: #ff9800;
                font-weight: bold;
            }

            .detail_box a {
                display: inline-block;
                background: #ff9800;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 5px;
                margin-top: 10px;
            }

            .detail_box a:hover {
                background: #e68900;
                .img-box {
                    height: 100%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    overflow: hidden;
                }

                .img-box img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }
                #profileContainer {
                    display: none;
                    position: absolute;
                    top: 40px; /* Điều chỉnh vị trí theo nhu cầu */
                    right: 0;
                    background: white;
                    padding: 15px;
                    border-radius: 8px;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
                    width: 250px;
                    z-index: 9999; /* Đảm bảo luôn hiển thị trên cùng */
                }
            }
        </style>

    </head>

    <body>
        <%List<Movie> list = (List<Movie>) request.getAttribute("listM");%>
        <div class="hero_area">
            <!-- header section strats -->

            <nav class="navbar">
                <a class="logo" href="home.jsp">
                    <img src="images/logo1.png" alt="">
                    <span>Lodge</span>
                </a>
                <div class="menu">
                    <ul>
                        <li><a href="MovieController?action=list">Movie</a></li>
                        <li><a href="CinemaController">Cinema</a></li>
                            <% if (!isLoggedIn) { %>
                        <li><a href="login.jsp">Login</a></li>
                            <% } %>
                    </ul>
                    <li><a href="account?service=changeCustomerProfile">profile</a></li>
                </div>

                <% if (isLoggedIn) { %>
                <div class="profile">
                    <a href="#" onclick="showProfile(event)">Your Profile</a>
                    <div id="profileContainer" style="display: none; position: absolute; background: white; padding: 15px; border-radius: 8px;
                         box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); width: 250px;">
                        <h3 style="color: black">Tài khoản</h3>
                        <p style="color: black"><strong>Tên:</strong> <%= account.getName() %></p>
                        <p style="color: black"><strong>Mã khách hàng:</strong> <%= customerID %></p>

                        <% if (isAdmin || isManager) { %>
                        <p><a href="admin" class="btn btn-warning">Manager</a></p>
                        <% } %>

                        <p><a href="account?service=changeCustomerProfile" class="btn btn-primary">Cập nhật hồ sơ</a></p>
                        <p><a href="account?service=changePassword" class="btn btn-secondary">Đổi mật khẩu</a></p>
                        <p><a href="logout" class="btn btn-danger">Logout</a></p> <!-- Thêm nút Logout vào Profile -->
                        <button onclick="closeProfile()">Đóng</button>
                    </div>
                    <p><strong>Xin chào, <%= account.getName() %>!</strong></p>
                </div>
                <% } %>



                <!-- end header section -->
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
                                                         Cột trái: Hình ảnh 
                                                        <div class="col-md-6">
                                                            <div class="img-box">
                                                                <img src="images/banner1.jpeg" class="img-fluid" alt="Movie 1">
                                                            </div>
                                                        </div>
                                                         Cột phải: Thông tin phim 
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
                    <!-- Nút điều hướng -->
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
                                var link = event.target; // Lấy thẻ <a> được click

                                // Lấy vị trí chính xác của "Your Profile"
                                var rect = link.getBoundingClientRect();
                                var scrollTop = window.scrollY || document.documentElement.scrollTop;
                                var scrollLeft = window.scrollX || document.documentElement.scrollLeft;

                                profile.style.display = 'block';
                                profile.style.position = 'absolute';
                                profile.style.top = (rect.top + rect.height + scrollTop) + 'px';
                                profile.style.left = (rect.left + scrollLeft) + 'px';
                            }

                            function closeProfile() {
                                document.getElementById('profileContainer').style.display = 'none';
                            }

        </script>


    </body>

</html>