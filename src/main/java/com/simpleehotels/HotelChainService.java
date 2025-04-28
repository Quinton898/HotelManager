package com.simpleehotels;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/*
 * This class is used to get rooms from the database.
 */
public class HotelChainService {
    /*
     * This method is used to get all rooms from the database.
     * @return List<Room>
     * @throws Exception
     */
    public ArrayList<HotelChain> getHotelChains() throws Exception {
        // SQL query to get all rooms
        String query = "SELECT * FROM hotel_chain;";
        ConnectionDB db = new ConnectionDB();
        
        // List to store rooms
        ArrayList<HotelChain> hotelChains = new ArrayList<>();

        // Get rooms from the database
        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            // Add rooms to the list
            while (rs.next()) {
                HotelChain hotelChain = new HotelChain(
                    rs.getString("address"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("num_of_hotels")
                );
                hotelChains.add(hotelChain);
            }
            // Close the connection
            rs.close();
            stmt.close();
            db.closeConnection();
            // Return the list of rooms
            return hotelChains;

        // Handle exceptions
        } catch (Exception e) {
            throw new Exception("Could not get the hotel chain names: " + e.getMessage());
        }
    }  
}
