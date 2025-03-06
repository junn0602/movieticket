package entity;

public class CinemaRoom {
    private int roomID;
    private int cinemaID;
    private String roomName;
    private String roomType; // Thêm RoomType

    public CinemaRoom() {}

    public CinemaRoom(int roomID, int cinemaID, String roomName, String roomType) {
        this.roomID = roomID;
        this.cinemaID = cinemaID;
        this.roomName = roomName;
        this.roomType = roomType;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public int getCinemaID() {
        return cinemaID;
    }

    public void setCinemaID(int cinemaID) {
        this.cinemaID = cinemaID;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getRoomType() { 
        return roomType; 
    }

    public void setRoomType(String roomType) { 
        this.roomType = roomType; 
    }
}
