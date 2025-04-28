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
public class HotelCapacityService {
    /*
     * This method is used to get all rooms from the database.
     * @return List<Room>
     * @throws Exception
     */
    public ArrayList<HotelCapacity> getHotelCapcity() throws Exception {
        // SQL query to get all rooms
        String query = "SELECT * FROM public.hotelroomcapacity;";
        ConnectionDB db = new ConnectionDB();
        
        // List to store rooms
        ArrayList<HotelCapacity> hotelCapacitys = new ArrayList<>();

        // Get rooms from the database
        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            // Add rooms to the list
            while (rs.next()) {
                HotelCapacity hotelCapacity = new HotelCapacity(
                    rs.getString("hotel_address"),
                    rs.getInt("total_capacity")
                );
                hotelCapacitys.add(hotelCapacity);
            }
            // Close the connection
            rs.close();
            stmt.close();
            db.closeConnection();
            // Return the list of rooms
            return hotelCapacitys;

        // Handle exceptions
        } catch (Exception e) {
            throw new Exception("Could not get employees: " + e.getMessage());
        }
    }

    
}