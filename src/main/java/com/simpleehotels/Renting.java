package com.simpleehotels;
import java.sql.Date;

public class Renting {
    private final String rentingID;
    private final Date startDate;
    private final Date endDate;
    private final float price;
    private final String customerSSN;
    private final int roomNumber;
    private final String address;

    public Renting(String rentingID, Date startDate, Date endDate, float price, String customerSSN, int roomNumber, String address) {
        this.rentingID = rentingID;
        this.startDate = startDate;
        this.endDate = endDate;
        this.price = price;
        this.customerSSN = customerSSN;
        this.roomNumber = roomNumber;
        this.address = address;
    }

    // getters
    public String getRentingID() {
        return rentingID;
    }
    public Date getStartDate() {
        return startDate;
    }
    public Date getEndDate() {
        return endDate;
    }
    public float getPrice() {
        return price;
    }
    public String getCustomerSSN() {
        return customerSSN;
    }
    public int getRoomNumber() {
        return roomNumber;
    }
    public String getAddress() {
        return address;
    }
}
