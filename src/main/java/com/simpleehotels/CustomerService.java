package com.simpleehotels;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CustomerService {
    public ArrayList<Customer> getCustomers() throws Exception {
        String query = "SELECT * FROM customer ";
        ConnectionDB db = new ConnectionDB();
        ArrayList<Customer> customers = new ArrayList<>();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Customer customer = new Customer(
                    rs.getString("ssn"),
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getDate("registration_date")
                );
                customers.add(customer);
            }
            // Close the connection
            rs.close();
            stmt.close();
            db.closeConnection();
            // Return the list of rooms
            return customers;
        } catch (Exception e) {
            throw new Exception("Could not get customers: " + e.getMessage());
        }
    }

    // Add the createCustomer method here
    public boolean createCustomer(Customer customer) {
        String query = "INSERT INTO customer (ssn, name, address, registration_date) VALUES (?, ?, ?, ?)";
        ConnectionDB db = new ConnectionDB();

        try (Connection con = db.getConnection()) {
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, customer.getSsn());
            stmt.setString(2, customer.getName());
            stmt.setString(3, customer.getAddress());
            stmt.setDate(4, new java.sql.Date(customer.getRegistrationDate().getTime()));

            int rowsInserted = stmt.executeUpdate();
            stmt.close();
            db.closeConnection();

            return rowsInserted > 0; // Return true if at least one row was inserted
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}

