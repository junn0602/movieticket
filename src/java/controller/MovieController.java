/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import model.MovieDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import entity.Movie;

/**
 *
 * @author jun
 */
@WebServlet(name="MovieController", urlPatterns={"/MovieController"})
public class MovieController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        String url = "movie.jsp"; // Đặt url mặc định ở đây
        
        try {
            MovieDAO dao = new MovieDAO();
            if (action == null || action.equals("list")) {
                List<Movie> movies = dao.getAllMovie();
                request.setAttribute("MOVIE_LIST", movies);
                // Không cần forward ở đây nữa
            } else if (action.equals("detail")) {
                int movieId = Integer.parseInt(request.getParameter("id"));
                Movie movie = dao.getMovieById(movieId);
                request.setAttribute("MOVIE_DETAIL", movie);
                url = "detailmovie.jsp"; // Đổi url khi cần
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Forward một lần duy nhất ở cuối
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
