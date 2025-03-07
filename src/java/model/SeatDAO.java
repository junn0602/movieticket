package model;

import entity.Seat;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SeatDAO  {
    private Connection conn;

    public SeatDAO() {
        try {
            System.out.println("Initializing SeatDAO..."); // Debug log
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(
                "jdbc:sqlserver://localhost:1433;databaseName=SWP391;user=sa;password=123456;"
            );
            System.out.println("Database connection successful"); // Debug log
        } catch (Exception e) {
            System.out.println("Error connecting to database: " + e.getMessage()); // Debug log
            e.printStackTrace();
        }
    }

    // Lấy danh sách ghế theo RoomID
    public List<Seat> getSeatsByRoom(int roomID) {
        List<Seat> seats = new ArrayList<>();
        String query = "SELECT * FROM Seat WHERE RoomID = ? ORDER BY SeatRow, SeatNumber";
        System.out.println("Executing query for room " + roomID + ": " + query); // Debug log

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, roomID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                seats.add(new Seat(
                    rs.getInt("SeatID"),
                    rs.getString("SeatRow"),
                    rs.getInt("SeatNumber"),
                    rs.getString("SeatType"),
                    rs.getInt("RoomID"),
                    rs.getString("Status")
                ));
            }
            System.out.println("Found " + seats.size() + " seats for room " + roomID); // Debug log
        } catch (SQLException e) {
            System.out.println("Error getting seats by room: " + e.getMessage()); // Debug log
            e.printStackTrace();
        }
        return seats;
    }

    // Hàm lấy tất cả ghế trong hệ thống
    public List<Seat> getAllSeats() {
        List<Seat> seats = new ArrayList<>();
        String query = "SELECT * FROM Seat ORDER BY RoomID, SeatRow, SeatNumber";
        System.out.println("Executing query: " + query); // Debug log

        try {
            // Test database connection
            if (conn == null || conn.isClosed()) {
                System.out.println("Connection is null or closed, reconnecting..."); // Debug log
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                conn = DriverManager.getConnection(
                    "jdbc:sqlserver://localhost:1433;databaseName=SWP391;user=sa;password=123456;"
                );
            }

            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(query)) {

                while (rs.next()) {
                    seats.add(new Seat(
                        rs.getInt("SeatID"),
                        rs.getString("SeatRow"),
                        rs.getInt("SeatNumber"),
                        rs.getString("SeatType"),
                        rs.getInt("RoomID"),
                        rs.getString("Status")
                    ));
                }
                System.out.println("Found " + seats.size() + " total seats"); // Debug log
            }
        } catch (Exception e) {
            System.out.println("Error getting all seats: " + e.getMessage()); // Debug log
            e.printStackTrace();
        }
        return seats;
    }

    public void closeConnection() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
                System.out.println("Database connection closed"); // Debug log
            }
        } catch (SQLException e) {
            System.out.println("Error closing connection: " + e.getMessage()); // Debug log
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) {
        SeatDAO dao = new SeatDAO();
        List<Seat> list = dao.getAllSeats();
        System.out.println(list);
    }
}
