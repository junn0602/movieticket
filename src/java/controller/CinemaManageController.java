package controller;

import model.CinemaDAO;
import model.CinemaRoomDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entity.Cinema;
import entity.CinemaRoom;
import java.util.List;


@WebServlet(name="CinemaManageController", urlPatterns={"/CinemaManageController"})
public class CinemaManageController extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        CinemaDAO dao = new CinemaDAO();
       if (action == null){
                action = "list";
            }
        if(action.equals("list")){
        
            
            List<Cinema> cinemas = dao.getAllCinemas();
           
            request.setAttribute("CINEMA_LIST", cinemas);
            
            request.getRequestDispatcher("/admin/cinemamanage.jsp").forward(request, response);
        
        } 
    
        if (action.equals("update")){
                String submit = request.getParameter("submit");
                if (submit == null){
                    int cid = Integer.parseInt(request.getParameter("cid"));
                    List<Cinema> list = dao.getAllCinemas();
                    request.setAttribute("list", list);
                    request.getRequestDispatcher(request.getContextPath() +"/admin/updateCombo.jsp").forward(request, response);
                } else {
                    try {
                        // Get and validate all parameters
                        String comboIdStr = request.getParameter("CinemaID");
                        String comboItem = request.getParameter("CinemaName");
                        String description = request.getParameter("Address");

                        
                        // Check for null parameters
                        if (comboIdStr == null || comboItem == null || description == null )
                            {
                            request.getSession().setAttribute("errorMessage", "Missing required fields");
                            response.sendRedirect(request.getContextPath() + "/admin/cinemaupdate.jsp");
                            return;
                        }
                        
                        // Parse numeric values
                        int cid = Integer.parseInt(comboIdStr);
                        
                        
                        // Validate values
                        if (comboItem.trim().isEmpty() || description.trim().isEmpty()) {
                            request.getSession().setAttribute("errorMessage", "Invalid input values");
                            response.sendRedirect(request.getContextPath() + "/admin/cinemaupdate.jsp");
                            return;
                        }
                        
                        // Update combo
                        Cinema cinema = new Cinema(cid, comboItem, description);
                        int n = dao.updateCinema(cinema);
                        
                        if (n > 0) {
                            request.getSession().setAttribute("successMessage", "Combo updated successfully!");
                        } else {
                            request.getSession().setAttribute("errorMessage", "Failed to update combo");
                        }
                        response.sendRedirect(request.getContextPath() + "/admin/cinemaupdate.jsp");
                        
                    } catch (NumberFormatException e) {
                        request.getSession().setAttribute("errorMessage", "Invalid number format: " + e.getMessage());
                        response.sendRedirect(request.getContextPath() + "/admin/cinemaupdate.jsp");
                    } catch (Exception e) {
                        request.getSession().setAttribute("errorMessage", "Error updating combo: " + e.getMessage());
                        response.sendRedirect(request.getContextPath() + "/admin/cinemaupdate.jsp");
                    }
                }
            }
         if ("insert".equals(action)) {  
        String cinemaName = request.getParameter("cinemaName");
        String address = request.getParameter("address");

        if (cinemaName == null || cinemaName.trim().isEmpty() || address == null || address.trim().isEmpty()) {
            request.setAttribute("error", "Cinema Name and Address cannot be empty.");
            request.getRequestDispatcher(request.getContextPath() +"/admin/cinemacreate.jsp").forward(request, response);
            return;
        }

        Cinema cinema = new Cinema();
        cinema.setCinemaName(cinemaName);
        cinema.setAddress(address);

        if (dao.insertCinema(cinema)) {
            request.setAttribute("success", "Cinema created successfully.");
        } else {
            request.setAttribute("error", "Cinema Name or Address already exists.");
        }
        request.getRequestDispatcher(request.getContextPath() +"/admin/cinemacreate.jsp").forward(request, response);
    
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
    return "Cinema Management Controller";
}
}