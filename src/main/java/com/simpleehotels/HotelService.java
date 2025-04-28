package com.simpleehotels;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/*
 * This class is used to get rooms from the database.
 */
public class HotelService {
    /*
     * This method is used to get all rooms from the database.
     * @return List<Room>
     * @throws Exception
     */
    public ArrayList<Hotel> getHotels() throws Exception {
        // SQL query to get all rooms
        String query = "SELECT * FROM hotel;";
        ConnectionDB db = new ConnectionDB();
        
        // List to store rooms
        ArrayList<Hotel> hotels = new ArrayList<>();

        // Get rooms from the database
        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            // Add rooms to the list
            while (rs.next()) {
                Hotel hotel = new Hotel(
                    rs.getString("address"),
                    rs.getInt("num_of_rooms"),
                    rs.getString("email"),
                    rs.getInt("stars"),
                    rs.getString("chain_address")
                );
                hotels.add(hotel);
            }
            // Close the connection
            rs.close();
            stmt.close();
            db.closeConnection();
            // Return the list of rooms
            return hotels;

        // Handle exceptions
        } catch (Exception e) {
            throw new Exception("Could not get Hotels: " + e.getMessage());
        }
    }  

    public String createHotel(Hotel hotel) throws Exception {
        String message = "";
        Connection con = null;

        // connection object
        ConnectionDB db = new ConnectionDB();
        

        // sql query
        String insertHotelQuery = "INSERT INTO hotel (address, num_of_rooms, email, stars, chain_address) VALUES (?, ?, ?, ?, ?);";
        // "INSERT INTO students (name, surname, email) VALUES (" + student.getName().toString() +
//        ", " + student.getSurname() ...."

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection(); //get Connection

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(insertHotelQuery);

            // set every ? of statement
            stmt.setString(1, hotel.getAddress());
            stmt.setInt(2, hotel.getNumOfRooms());
            stmt.setString(3, hotel.getEmail());
            stmt.setInt(4, hotel.getStars());
            stmt.setString(5, hotel.getChainAddress());

            // execute the query
            int output = stmt.executeUpdate();

            // close the statement
            stmt.close();
            // close the connection
            db.closeConnection();
        } catch (Exception e) {
            message = "Error while inserting customer: " + e.getMessage();
        } finally {
            if (con != null) // if connection is still open, then close.
                con.close();
            if (message.equals("")) message = "Student successfully inserted!";

        }

        // return respective message
        return message;
    }

    public String updateHotel(Hotel hotel) throws Exception {
        Connection con = null;
        String message = "";

        // sql query
        String sql = "UPDATE hotel SET num_of_rooms=?, email=?, stars=?, chain_address=? WHERE address=?;";
//        "UPDATE students SET name=" + student.getName().toString() +", surname=" +

        // connection object
        ConnectionDB db = new ConnectionDB();

        // try connect to database, catch any exceptions
        try {
            // get connection
            con = db.getConnection();

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setInt(1, hotel.getNumOfRooms());
            stmt.setString(2, hotel.getEmail());
            stmt.setInt(3, hotel.getStars());
            stmt.setString(4, hotel.getChainAddress());
            stmt.setString(5, hotel.getAddress());

            // execute the query
            stmt.executeUpdate();

            // close the statement
            stmt.close();

        } catch (Exception e) {
            message = "Error while updating hotel: " + e.getMessage();

        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "Hotel successfully updated!";
        }

        // return respective message
        return message;
    }

    public String deleteHotel(String address) throws Exception {
        Connection con = null;
        String message = "";

        // sql query
        String sql = "DELETE FROM hotel WHERE address = ?;";

        // database connection object
        ConnectionDB db = new ConnectionDB();

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection();

            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setString(1, address);

            // execute the query
            stmt.executeUpdate();

            // close the statement
            stmt.close();

        } catch (Exception e) {
            message = "Error while delete hotel: " + e.getMessage();
        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "Hotel successfully deleted!";
        }

        return message;
    }
}