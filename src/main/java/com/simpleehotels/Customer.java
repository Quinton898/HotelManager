package com.simpleehotels;
import java.sql.Date;

public class Customer {
    private String ssn;
    private String name;
    private String address;
    private Date registrationDate;

    // Constructor
    public Customer(String ssn, String name, String address, Date registrationDate) {
        this.ssn = ssn;
        this.name = name;
        this.address = address;
        this.registrationDate = registrationDate;
    }

    // Getters and setters (if needed)
    public String getSsn() {
        return ssn;
    }

    public void setSsn(String ssn) {
        this.ssn = ssn;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }
}