package com.simpleehotels;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


/*
 * This class is used to get rooms from the database.
 */
public class BookingService {
    /*
     * This method is used to get all rooms from the database.
     * @return List<Room>
     * @throws Exception
     */
    public ArrayList<Booking> getBooking() throws Exception {

        // SQL query to get all rooms
        String query = "SELECT * FROM booking;";
        ConnectionDB db = new ConnectionDB();
        
        // List to store rooms
        ArrayList<Booking> bookings = new ArrayList<>();

        // Get rooms from the database
        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            // Add rooms to the list
            while (rs.next()) {
                Booking booking = new Booking(
                    rs.getString("booking_id"),
                    rs.getDate("start_date"),
                    rs.getDate("end_date"),
                    rs.getFloat("price"),
                    rs.getString("customer_ssn"),
                    rs.getInt("room_num"),
                    rs.getString("address")
                );
                bookings.add(booking);
            }
            // Close the connection
            rs.close();
            stmt.close();
            db.closeConnection();
            // Return the list of rooms
            return bookings;

        // Handle exceptions
        } catch (Exception e) {
            throw new Exception("Could not get employees: " + e.getMessage());
        }
    }

    public String createRenting(Booking booking) throws Exception {
        String message = "";
        Connection con = null;
        ConnectionDB db = new ConnectionDB();

        String insertRoomQuery = "INSERT INTO renting (renting_id, start_date, end_date, price, customer_ssn, room_num, address) VALUES (?, ?, ?, ?, ?, ?, ?);";

        try {
            con = db.getConnection();
            PreparedStatement stmt = con.prepareStatement(insertRoomQuery);

            stmt.setString(1, "r"+(booking.getBookingID()).substring(1));
            stmt.setDate(2, booking.getStartDate());
            stmt.setDate(3, booking.getEndDate());
            stmt.setFloat(4, booking.getPrice());
            stmt.setString(5, booking.getCustomerSSN());
            stmt.setInt(6, booking.getRoomNumber());
            stmt.setString(7, booking.getAddress());

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

    public boolean rentRoom(Room room, String ssn, Date startDate, Date endDate) throws Exception{
        String query1 = "INSERT INTO renting (renting_id, start_date, end_date, price, customer_ssn, room_num, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
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
                stmt1.setString(1, "r" + (rs2.getInt(1) + 1));
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
    
}