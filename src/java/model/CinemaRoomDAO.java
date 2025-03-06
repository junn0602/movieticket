package model;

import entity.CinemaRoom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CinemaRoomDAO extends DBConnection {
    
    // Lấy danh sách tất cả các phòng
    public List<CinemaRoom> getAllCinemaRooms() {
        List<CinemaRoom> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM CinemaRoom";
            PreparedStatement stm = conn.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                CinemaRoom room = new CinemaRoom();
                room.setRoomID(rs.getInt("RoomID"));
                room.setCinemaID(rs.getInt("CinemaID"));
                room.setRoomName(rs.getString("RoomName"));
                room.setRoomType(rs.getString("RoomType")); // Lấy RoomType
                list.add(room);
            }
        } catch (Exception ex) {
            Logger.getLogger(CinemaRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    // Lấy danh sách phòng theo CinemaID
    public List<CinemaRoom> getRoomsByCinemaID(int cinemaID) {
        List<CinemaRoom> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM CinemaRoom WHERE CinemaID = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, cinemaID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                CinemaRoom room = new CinemaRoom();
                room.setRoomID(rs.getInt("RoomID"));
                room.setCinemaID(rs.getInt("CinemaID"));
                room.setRoomName(rs.getString("RoomName"));
                room.setRoomType(rs.getString("RoomType")); // Lấy RoomType
                list.add(room);
            }
        } catch (Exception ex) {
            Logger.getLogger(CinemaRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    // Lấy thông tin phòng theo RoomID
    public CinemaRoom getRoomByID(int roomID) {
        try {
            String sql = "SELECT * FROM CinemaRoom WHERE RoomID = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, roomID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new CinemaRoom(
                    rs.getInt("RoomID"),
                    rs.getInt("CinemaID"),
                    rs.getString("RoomName"),
                    rs.getString("RoomType") // Lấy RoomType
                );
            }
        } catch (Exception ex) {
            Logger.getLogger(CinemaRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // Thêm phòng mới
    public boolean addRoom(CinemaRoom room) {
        try {
            String sql = "INSERT INTO CinemaRoom (CinemaID, RoomName, RoomType) VALUES (?, ?, ?)";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setInt(1, room.getCinemaID());
            stm.setString(2, room.getRoomName());
            stm.setString(3, room.getRoomType());
            return stm.executeUpdate() > 0;
        } catch (Exception ex) {
            Logger.getLogger(CinemaRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // Cập nhật phòng
    public boolean updateRoom(CinemaRoom room) {
        try {
            String sql = "UPDATE CinemaRoom SET RoomName = ?, RoomType = ? WHERE RoomID = ?";
            PreparedStatement stm = conn.prepareStatement(sql);
            stm.setString(1, room.getRoomName());
            stm.setString(2, room.getRoomType());
            stm.setInt(3, room.getRoomID());
            return stm.executeUpdate() > 0;
        } catch (Exception ex) {
            Logger.getLogger(CinemaRoomDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}