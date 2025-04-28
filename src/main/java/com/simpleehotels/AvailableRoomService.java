package com.simpleehotels;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;


/*
 * This class is used to get rooms from the database.
 */
public class AvailableRoomService {
    /*
     * This method is used to get all rooms from the database.
     * @return List<Room>
     * @throws Exception
     */
    public ArrayList<AvailableRoom> getAvailableRooms() throws Exception {
        // SQL query to get all rooms
        String query = "SELECT * FROM public.available_rooms_per_area;";
        ConnectionDB db = new ConnectionDB();
        
        // List to store rooms
        ArrayList<AvailableRoom> availableRooms = new ArrayList<>();

        // Get rooms from the database
        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            // Add rooms to the list
            while (rs.next()) {
                AvailableRoom availableRoom = new AvailableRoom(
                    rs.getString("area"),
                    rs.getInt("available_rooms")
                );
                availableRooms.add(availableRoom);
            }
            // Close the connection
            rs.close();
            stmt.close();
            db.closeConnection();
            // Return the list of rooms
            return availableRooms;

        // Handle exceptions
        } catch (Exception e) {
            throw new Exception("Could not get employees: " + e.getMessage());
        }
    }

    
}