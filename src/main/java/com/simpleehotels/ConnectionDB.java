package com.simpleehotels;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionDB {
    // JDBC URL, username and password of Postgres server
    private static final String ipAddress = "localhost";
    private static final String dbServerPort = "5432";
    private static final String dbName = "simpleehotels";
    private static final String dbUsername = "postgres";
    private static final String dbPassword = "postgres";

    private Connection con = null;

    /*
     * This method is used to establish a connection with the database server.
     * @return Connection
     * @throws Exception
     */
    public Connection getConnection() throws Exception {
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql://" + ipAddress + ":" + dbServerPort + "/" + dbName, dbUsername, dbPassword);
            return con;
        } catch (Exception e) {
            throw new Exception("Could not establish connection with the database server: " + e.getMessage());
        }
    }

    /*  
     * This method is used to close the connection with the database server.
     * @throws SQLException
     */
    public void closeConnection() throws SQLException{
        try {
            if (con != null) {
                con.close();
            }
        } catch (SQLException e) {
            throw new SQLException("Could not close connection with the database server: " + e.getMessage());
        }
    }
}
