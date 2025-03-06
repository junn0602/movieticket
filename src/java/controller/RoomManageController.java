package controller;

import model.CinemaDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entity.CinemaRoom;
import java.util.List;
import model.CinemaRoomDAO;

@WebServlet("/RoomManageController")
public class RoomManageController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CinemaRoomDAO roomDAO;

    public void init() {
        roomDAO = new CinemaRoomDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "insert":
                insertRoom(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "update":
                updateRoom(request, response);
                break;
            default:
                listRooms(request, response);
                break;
        }
    }

    private void listRooms(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<CinemaRoom> listRooms = roomDAO.getAllCinemaRooms(); // Cập nhật đúng tên phương thức
        request.setAttribute("listRooms", listRooms);
        request.getRequestDispatcher("roommanage.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("roomcreate.jsp").forward(request, response);
    }

    private void insertRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        String roomName = request.getParameter("roomName");
//        int cinemaID = Integer.parseInt(request.getParameter("cinemaID"));
//        String roomType = request.getParameter("roomType");
//
//        CinemaRoom newRoom = new CinemaRoom(0, cinemaID, roomName, roomType);
//        roomDAO.addRoom(newRoom); // Cập nhật đúng tên phương thức
//        response.sendRedirect("RoomManageController");
  try {
        String roomName = request.getParameter("roomName");
        int cinemaID = Integer.parseInt(request.getParameter("cinemaID"));
        String roomType = request.getParameter("roomType");

        // Debug thông tin nhận được
        System.out.println("Insert Room: Name = " + roomName + ", CinemaID = " + cinemaID + ", RoomType = " + roomType);

        CinemaRoom newRoom = new CinemaRoom(0, cinemaID, roomName, roomType);
        boolean isInserted = roomDAO.addRoom(newRoom); 

        if (isInserted) {
            System.out.println("Room inserted successfully!");
            response.sendRedirect("RoomManageController");
        } else {
            System.out.println("Room insertion failed!");
            response.getWriter().println("Error: Room not inserted!");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().println("Error: " + e.getMessage());
    }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int roomID = Integer.parseInt(request.getParameter("id"));
        CinemaRoom existingRoom = roomDAO.getRoomByID(roomID);
        request.setAttribute("room", existingRoom);
        request.getRequestDispatcher("roomupdate.jsp").forward(request, response);
    }

    private void updateRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int roomID = Integer.parseInt(request.getParameter("roomID"));
        int cinemaID = Integer.parseInt(request.getParameter("cinemaID")); // Lấy cinemaID từ request
        String roomName = request.getParameter("roomName");
        String roomType = request.getParameter("roomType");

        CinemaRoom room = new CinemaRoom(roomID, cinemaID, roomName, roomType);
        roomDAO.updateRoom(room);
        response.sendRedirect("RoomManageController");
    }
}
