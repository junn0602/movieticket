package controller;

import model.SeatDAO;
import entity.Seat;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SeatController", urlPatterns = {"/admin/seats"})
public class SeatController extends HttpServlet {
    private SeatDAO seatDAO;

    @Override
    public void init() throws ServletException {
        seatDAO = new SeatDAO();
        System.out.println("SeatController initialized"); // Debug log
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        System.out.println("SeatController doGet called"); // Debug log
        String action = request.getParameter("action");
        System.out.println("Action: " + action); // Debug log

        if ("all".equals(action)) {
            getAllSeats(request, response);
        } else {
            getSeatsByRoom(request, response);
        }
    }

    // Xử lý yêu cầu lấy tất cả ghế
    private void getAllSeats(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        System.out.println("Getting all seats..."); // Debug log
        List<Seat> seats = seatDAO.getAllSeats();
        System.out.println("Number of seats retrieved: " + seats.size()); // Debug log

        if (seats.isEmpty()) {
            System.out.println("No seats found in database"); // Debug log
            request.setAttribute("error", "Không có ghế nào trong hệ thống!");
        } else {
            System.out.println("Found " + seats.size() + " seats"); // Debug log
            request.setAttribute("seats", seats);
        }

        request.getRequestDispatcher("/admin/seat-management.jsp").forward(request, response);
    }

    // Xử lý yêu cầu lấy ghế theo RoomID
    private void getSeatsByRoom(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String roomIDParam = request.getParameter("roomID");
        System.out.println("Getting seats for room: " + roomIDParam); // Debug log
        
        if (roomIDParam == null || roomIDParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "roomID is required");
            return;
        }

        try {
            int roomID = Integer.parseInt(roomIDParam);
            List<Seat> seats = seatDAO.getSeatsByRoom(roomID);
            System.out.println("Found " + seats.size() + " seats for room " + roomID); // Debug log

            if (seats.isEmpty()) {
                request.setAttribute("error", "Không có ghế nào trong phòng này!");
            } else {
                request.setAttribute("seats", seats);
            }

            request.getRequestDispatcher("/admin/seat-management.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "roomID phải là số nguyên hợp lệ!");
        }
    }

    @Override
    public void destroy() {
        if (seatDAO != null) {
            seatDAO.closeConnection();
        }
    }
}