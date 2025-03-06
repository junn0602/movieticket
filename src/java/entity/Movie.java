/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.Date;

/**
 *
 * @author Acer Nitro
 */
public class Movie {

    private int movieID;
    private String movieName;
    private String Country;
    private int Duration;
    private String Genre;
    private String Director;
    private Date ReleaseDate;
    private String MoviePoster;
    private String Description;
    private String AgeRate;
    private String TrailerURL;

    public int getMovieID() {
        return movieID;
    }

    public void setMovieID(int movieID) {
        this.movieID = movieID;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public String getCountry() {
        return Country;
    }

    public void setCountry(String Country) {
        this.Country = Country;
    }

    public int getDuration() {
        return Duration;
    }

    public void setDuration(int Duration) {
        this.Duration = Duration;
    }

    public String getGenre() {
        return Genre;
    }

    public void setGenre(String Genre) {
        this.Genre = Genre;
    }

    public String getDirector() {
        return Director;
    }

    public void setDirector(String Director) {
        this.Director = Director;
    }

    public Date getReleaseDate() {
        return ReleaseDate;
    }

    public void setReleaseDate(Date ReleaseDate) {
        this.ReleaseDate = ReleaseDate;
    }

    public String getMoviePoster() {
        return MoviePoster;
    }

    public void setMoviePoster(String MoviePoster) {
        this.MoviePoster = MoviePoster;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    public String getAgeRate() {
        return AgeRate;
    }

    public void setAgeRate(String AgeRate) {
        this.AgeRate = AgeRate;
    }

    public String getTrailerURL() {
        return TrailerURL;
    }

    public void setTrailerURL(String TrailerURL) {
        this.TrailerURL = TrailerURL;
    }

    public Movie() {
    }

    @Override
    public String toString() {
        return "Movie{" + "movieID=" + movieID + ", movieName=" + movieName + ", Country=" + Country + ", Duration=" + Duration + ", Genre=" + Genre + ", Director=" + Director + ", ReleaseDate=" + ReleaseDate + ", MoviePoster=" + MoviePoster + ", Description=" + Description + ", AgeRate=" + AgeRate + ", TrailerURL=" + TrailerURL + '}';
    }

    public Movie(int movieID, String movieName, String Country, int Duration, String Genre, String Director, Date ReleaseDate, String MoviePoster, String Description, String AgeRate, String TrailerURL) {
        this.movieID = movieID;
        this.movieName = movieName;
        this.Country = Country;
        this.Duration = Duration;
        this.Genre = Genre;
        this.Director = Director;
        this.ReleaseDate = ReleaseDate;
        this.MoviePoster = MoviePoster;
        this.Description = Description;
        this.AgeRate = AgeRate;
        this.TrailerURL = TrailerURL;
    }

    
    
    
   

    

    
  

}
