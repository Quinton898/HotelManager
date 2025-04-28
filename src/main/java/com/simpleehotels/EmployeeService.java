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
public class EmployeeService {
    /*
     * This method is used to get all rooms from the database.
     * @return List<Room>
     * @throws Exception
     */
    public ArrayList<Employee> getEmployees() throws Exception {
        // SQL query to get all rooms
        String query = "SELECT * FROM employee;";
        ConnectionDB db = new ConnectionDB();
        
        // List to store rooms
        ArrayList<Employee> employees = new ArrayList<>();

        // Get rooms from the database
        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            // Add rooms to the list
            while (rs.next()) {
                Employee employee = new Employee(
                    rs.getString("ssn"),
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getString("hotel_address")
                );
                employees.add(employee);
            }
            // Close the connection
            rs.close();
            stmt.close();
            db.closeConnection();
            // Return the list of rooms
            return employees;

        // Handle exceptions
        } catch (Exception e) {
            throw new Exception("Could not get employees: " + e.getMessage());
        }
    }
    public String createEmployee(Employee employee) throws Exception {
        String message = "";
        Connection con = null;

        // connection object
        ConnectionDB db = new ConnectionDB();
        

        // sql query
        String insertEmployeeQuery = "INSERT INTO employee (ssn, name, address, hotel_address) VALUES (?, ?, ?, ?);";
        
        try {
            con = db.getConnection(); //get Connection

            // prepare the statement
            PreparedStatement stmt = con.prepareStatement(insertEmployeeQuery);

            // Set parameters for the query
            stmt.setString(1, employee.getSsn());
            stmt.setString(2, employee.getName());
            stmt.setString(3, employee.getAddress());
            stmt.setString(4, employee.getHotelAddress());
            // execute the query
            int output = stmt.executeUpdate();

            // close the statement
            stmt.close();
            // close the connection
            db.closeConnection();
        } catch (Exception e) {
            message = "Error while inserting employee: " + e.getMessage();
        } finally {
            if (con != null) // if connection is still open, then close.
                con.close();
            if (message.equals("")) message = "employee successfully inserted!";

        }

        // return respective message
        return message;
    }

    public String updateEmployee(Employee employee) throws Exception {
        Connection con = null;
        String message = "";

        // sql query
        String sql = "UPDATE employee SET name=?, address=?, hotel_address=? WHERE ssn=?;";
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
            stmt.setString(1, employee.getName());
            stmt.setString(2, employee.getAddress());
            stmt.setString(3, employee.getHotelAddress());
            stmt.setString(4, employee.getSsn());
            // execute the query
            stmt.executeUpdate();

            // close the statement
            stmt.close();

        } catch (Exception e) {
            message = "Error while updating employee: " + e.getMessage();

        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "employee successfully updated!";
        }

        // return respective message
        return message;
    }

    public String deleteEmployee(String ssn) throws Exception {
        Connection con = null;
        String message = "";

        // sql query
        String sql = "DELETE FROM employee WHERE ssn = ?;";

        // database connection object
        ConnectionDB db = new ConnectionDB();

        // try connect to database, catch any exceptions
        try {
            con = db.getConnection();

            // prepare statement
            PreparedStatement stmt = con.prepareStatement(sql);

            // set every ? of statement
            stmt.setString(1, ssn);

            // execute the query
            stmt.executeUpdate();

            // close the statement
            stmt.close();

        } catch (Exception e) {
            message = "Error while delete employee: " + e.getMessage();
        } finally {
            if (con != null) con.close();
            if (message.equals("")) message = "employee successfully deleted!";
        }

        return message;
    }

    
}