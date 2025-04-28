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
public class RoomService {
    /*
     * This method is used to get all rooms from the database.
     * @return List<Room>
     * @throws Exception
     */
    public ArrayList<Room> getAvailableRooms(Date startDate, Date endDate) throws Exception {
        // SQL query to get all rooms
        String query = "SELECT * FROM rooms " +
            "WHERE (address, room_num) NOT IN ( " +
            "    SELECT address, room_num " +
            "    FROM renting " +
            "    WHERE ((start_date BETWEEN ? AND ?) OR (end_date BETWEEN ? AND ?))" +
            ") AND (address, room_num) NOT IN ( " +
            "    SELECT address, room_num " +
            "    FROM booking " +
            "    WHERE ((start_date BETWEEN ? AND ?) OR (end_date BETWEEN ? AND ?))" +
            ");";

        ConnectionDB db = new ConnectionDB();
        
        // List to store rooms
        ArrayList<Room> rooms = new ArrayList<>();

        // Get rooms from the database
        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(query);
            // Set the parameters for the prepared statement
            stmt.setDate(1, startDate);
            stmt.setDate(2, endDate);
            stmt.setDate(3, startDate);
            stmt.setDate(4, endDate);
            stmt.setDate(5, startDate);
            stmt.setDate(6, endDate);
            stmt.setDate(7, startDate);
            stmt.setDate(8, endDate);

            // Execute the query
            ResultSet rs = stmt.executeQuery();
            // Add rooms to the list
            while (rs.next()) {
                Room room = new Room(
                    rs.getInt("room_num"),
                    rs.getString("address"),
                    rs.getFloat("price"),
                    rs.getString("amenities"),
                    rs.getString("capacity"),
                    rs.getString("view_type"),
                    rs.getString("damages"),
                    rs.getBoolean("extendible")
                );
                rooms.add(room);
            }
            // Close the connection
            rs.close();
            stmt.close();
            db.closeConnection();
            // Return the list of rooms
            return rooms;

        // Handle exceptions
        } catch (Exception e) {
            throw new Exception("Could not get rooms: " + e.getMessage());
        }
    }

    public ArrayList<Room> getAllRooms() throws Exception {
        // SQL query to get all rooms
        String query = "SELECT * FROM rooms";
        ConnectionDB db = new ConnectionDB();
        
        // List to store rooms
        ArrayList<Room> rooms = new ArrayList<>();

        // Get rooms from the database
        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(query);
            // Execute the query
            ResultSet rs = stmt.executeQuery();
            // Add rooms to the list
            while (rs.next()) {
                Room room = new Room(
                    rs.getInt("room_num"),
                    rs.getString("address"),
                    rs.getFloat("price"),
                    rs.getString("amenities"),
                    rs.getString("capacity"),
                    rs.getString("view_type"),
                    rs.getString("damages"),
                    rs.getBoolean("extendible")
                );
                rooms.add(room);
            }
            // Close the connection
            rs.close();
            stmt.close();
            db.closeConnection();
            // Return the list of rooms
            return rooms;

        // Handle exceptions
        } catch (Exception e) {
            throw new Exception("Could not get rooms: " + e.getMessage());
        }
    }

    public ArrayList<Room> getRoomsFiltered(Date start, Date end, String capacity, String area, String chainName, int stars, int numofRooms, float price ) throws Exception {
        // SQL query to get all rooms
        String query = "SELECT * " +
                  "FROM rooms " +
                  "WHERE (address, room_num) NOT IN ( " +
                  "    SELECT address, room_num " +
                  "    FROM renting " +
                  "    WHERE current_date >= "+start +"AND "+ end  +">= current_date " +
                  ") AND (address, room_num) NOT IN ( " +
                  "    SELECT address, room_num " +
                  "    FROM booking " +
                  "    WHERE current_date >= "+start +"AND "+ end  +">= current_date " + 
                  ") AND capacity ILIKE '" + capacity + "' " +
                    "AND address ILIKE '" + area + "' " +
                  "IN( SELECT address as chain_address FROM hotel_chain WHERE name ILIKE '" + chainName + "') " +
                  "AND stars <= " + stars + ") " +
                    "AND room_num <= " + numofRooms + ") " +
                    "AND price <= " + price + ";";
        ConnectionDB db = new ConnectionDB();
        
        // List to store rooms
        ArrayList<Room> rooms = new ArrayList<>();

        // Get rooms from the database
        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            // Add rooms to the list
            while (rs.next()) {
                Room room = new Room(
                    rs.getInt("room_num"),
                    rs.getString("address"),
                    rs.getFloat("price"),
                    rs.getString("amenities"),
                    rs.getString("capacity"),
                    rs.getString("view_type"),
                    rs.getString("damages"),
                    rs.getBoolean("extendible")
                );
                rooms.add(room);
            }
            // Close the connection
            rs.close();
            stmt.close();
            db.closeConnection();
            // Return the list of rooms
            return rooms;

        // Handle exceptions
        } catch (Exception e) {
            throw new Exception("Could not get rooms: " + e.getMessage());
        }
    }

    public boolean bookRoom(Room room, String ssn, Date startDate, Date endDate) throws Exception{
        String query1 = "INSERT INTO booking (booking_id, start_date, end_date, price, customer_ssn, room_num, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String query2 = "SELECT MAX(CAST(SUBSTRING(archive_id, 2, 10) AS INTEGER)) AS max_booking_number FROM archives;";
        String query3 = "SELECT * FROM customer WHERE customer.ssn=\'" + ssn + "\';";
        System.out.println(query3);
        ConnectionDB db = new ConnectionDB();
        System.out.println(room.toString());

        try (Connection con = db.getConnection()) {
            System.out.println("2");
            PreparedStatement stmt1 = con.prepareStatement(query1);
            PreparedStatement stmt2 = con.prepareStatement(query2);
            PreparedStatement stmt3 = con.prepareStatement(query3);
            System.out.println("2.1");
    
            ResultSet rs2 = stmt2.executeQuery();
            System.out.println("2.2");
            ResultSet rs3 = stmt3.executeQuery();
            System.out.println("2.3");
            if (!rs3.next()){
                System.out.println("2.4");
                return false;
            }
            
            System.out.println("3");
            if (rs2.next()) {
                // If there is a result, retrieve the max booking number and increment it
                stmt1.setString(1, "b" + (rs2.getInt(1) + 1));
            } else {
                throw new Exception("Could not get a booking id.");
            }
            System.out.println("3.1");
            stmt1.setDate(2, startDate);
            System.out.println("3.2");
            stmt1.setDate(3, endDate);
            System.out.println("3.3");
            stmt1.setFloat(4, room.getRoomPrice());
            System.out.println("3.4");
            stmt1.setString(5, ssn);                                         ///////////////////////////////////////////////// DUMMY DATES AND SSN
            System.out.println("3.5");
            stmt1.setInt(6, room.getRoomNumber());
            System.out.println("3.6");
            stmt1.setString(7, room.getRoomAddress());

            System.out.println("4");
            int rs1 = stmt1.executeUpdate();
            System.out.println("5");
            if (rs1 == 1){
                System.out.println("6");
                //rs2.close();
                rs3.close();
                stmt1.close();
                //stmt2.close();
                stmt3.close();
                db.closeConnection();
                return true;
            } else {
                System.out.println("7");
                //rs2.close();
                rs3.close();
                stmt1.close();
                //stmt2.close();
                stmt3.close();
                db.closeConnection();
                return false;
            }
        } catch (Exception e) {
            return false;
        }
    }

    public Date getDate(boolean end) {
        // Get the current date
        LocalDate currentDate = LocalDate.now();

        // Add one week to the current date
        if (end){
            currentDate = currentDate.plusWeeks(1);
        } else {
            currentDate = currentDate.plusDays(1);
        }

        // Format the date as "year-month-day"
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDate = currentDate.format(formatter);

        // Return the formatted date
        return Date.valueOf(formattedDate);
    }

    public Date getDateEnd() {
        // Get the current date
        LocalDate currentDate = LocalDate.now();

        // Format the date as "year-month-day"
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDate = currentDate.format(formatter);

        // Return the formatted date
        return Date.valueOf(formattedDate);
    }
    public String createRoom(Room room) throws Exception {
        String message = "";
        Connection con = null;
        ConnectionDB db = new ConnectionDB();

        String insertRoomQuery = "INSERT INTO rooms (room_num, address, price, amenities, capacity, view_type, damages, extendible) VALUES (?, ?, ?, ?, ?, ?, ?, ?);";

        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(insertRoomQuery);

            stmt.setInt(1, room.getRoomNumber());
            stmt.setString(2, room.getRoomAddress());
            stmt.setFloat(3, room.getRoomPrice());
            stmt.setString(4, room.getRoomAmenities());
            stmt.setString(5, room.getRoomCapacity());
            stmt.setString(6, room.getRoomViewType());
            stmt.setString(7, room.getRoomDamages());
            stmt.setBoolean(8, room.isRoomExtendible());

            int output = stmt.executeUpdate();

            stmt.close();
            db.closeConnection();

            if (output > 0) {
                message = "Room successfully inserted!";
            } else {
                message = "Failed to insert room.";
            }

        } catch (Exception e) {
            message = "Error while inserting room: " + e.getMessage();
        } finally {
            if (con != null) con.close();
        }

        return message;
    }

    public String updateRoom(Room room) throws Exception {
        Connection con = null;
        String message = "";
        ConnectionDB db = new ConnectionDB();

        String sql = "UPDATE rooms SET price=?, amenities=?, capacity=?, view_type=?, damages=?, extendible=? WHERE room_num=? AND address=?;";

        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setFloat(1, room.getRoomPrice());
            stmt.setString(2, room.getRoomAmenities());
            stmt.setString(3, room.getRoomCapacity());
            stmt.setString(4, room.getRoomViewType());
            stmt.setString(5, room.getRoomDamages());
            stmt.setBoolean(6, room.isRoomExtendible());
            stmt.setInt(7, room.getRoomNumber());
            stmt.setString(8, room.getRoomAddress());
            


            int output = stmt.executeUpdate();

            stmt.close();

            if (output > 0) {
                message = "Room successfully updated!";
            } else {
                message = "Failed to update room.";
            }

        } catch (Exception e) {
            message = "Error while updating room: " + e.getMessage();
        } finally {
            if (con != null) con.close();
        }

        return message;
    }

    public String deleteRoom(int roomNumber, String address) throws Exception {
        Connection con = null;
        String message = "";
        ConnectionDB db = new ConnectionDB();

        String sql = "DELETE FROM rooms WHERE room_num = ? AND address = ?;";

        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(sql);

            stmt.setInt(1, roomNumber);
            stmt.setString(2, address);

            int output = stmt.executeUpdate();

            stmt.close();

            if (output > 0) {
                message = "Room successfully deleted!";
            } else {
                message = "Failed to delete room.";
            }

        } catch (Exception e) {
            message = "Error while deleting room: " + e.getMessage();
        } finally {
            if (con != null) con.close();
        }

        return message;
    }
}