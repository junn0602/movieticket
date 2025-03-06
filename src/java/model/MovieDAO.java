package model;

import entity.Movie;
import model.DBConnection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MovieDAO extends DBConnection {

    public List<Movie> getAllMovie() {
        List<Movie> list = new ArrayList<>();
        String query = "SELECT * FROM movie";
        try (PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            if (!rs.isBeforeFirst()) { // Kiểm tra nếu ResultSet trống
                System.out.println("Không có dữ liệu trong bảng Movie!");
            }
            while (rs.next()) {
                System.out.println("Lấy được phim: " + rs.getString("MovieName"));
                list.add(new Movie(
                        rs.getInt("MovieID"),
                        rs.getString("MovieName"),
                        rs.getString("Country"),
                        rs.getInt("Duration"),
                        rs.getString("Genre"),
                        rs.getString("Director"),
                        rs.getDate("ReleaseDate"),
                        rs.getString("MoviePoster"),
                        rs.getString("Description"),
                        rs.getString("AgeRate"),
                        rs.getString("TrailerURL")
                ));
            }
        } catch (SQLException e) {
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, "Lỗi khi lấy danh sách phim", e);
        }
        return list;
    }

    public Movie getMovieById(int id) {
        Movie movie = null;
        try {
            String sql = "SELECT * FROM [dbo].[Movie] WHERE MovieID = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                movie = new Movie();
                movie.setMovieID(rs.getInt("MovieID"));
                movie.setMovieName(rs.getString("MovieName"));
                movie.setCountry(rs.getString("Country"));
                movie.setDuration(rs.getInt("Duration"));
                movie.setGenre(rs.getString("Genre"));
                movie.setDirector(rs.getString("Director"));
                movie.setReleaseDate(rs.getDate("ReleaseDate"));
                movie.setMoviePoster(rs.getString("MoviePoster"));
                movie.setDescription(rs.getString("Description"));
                movie.setAgeRate(rs.getString("AgeRate"));
                movie.setTrailerURL(rs.getString("TrailerURL"));
            }
        } catch (Exception ex) {
            Logger.getLogger(model.MovieDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return movie;
    }

    public List<Movie> getLastThreeMovies() {
        List<Movie> list = new ArrayList<>();
        String query = "WITH MovieRank AS (\n"
                + "    SELECT *, ROW_NUMBER() OVER (ORDER BY ReleaseDate DESC) AS row_num\n"
                + "    FROM movie\n"
                + ")\n"
                + "SELECT * FROM MovieRank WHERE row_num <= 3;";
        try (PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Movie(
                        rs.getInt("MovieID"),
                        rs.getString("MovieName"),
                        rs.getString("Country"),
                        rs.getInt("Duration"),
                        rs.getString("Genre"),
                        rs.getString("Director"),
                        rs.getDate("ReleaseDate"),
                        rs.getString("MoviePoster"),
                        rs.getString("Description"),
                        rs.getString("AgeRate"),
                        rs.getString("TrailerURL")
                ));
            }
        } catch (SQLException e) {
            Logger.getLogger(MovieDAO.class.getName()).log(Level.SEVERE, "Lỗi khi lấy 3 phim cuối", e);
        }
        return list;
    }

    public static void main(String[] args) {
        MovieDAO dao = new MovieDAO();
        List<Movie> list = dao.getAllMovie();
        for (Movie movie : list) {
            System.out.println(movie);
        }
    }
}
