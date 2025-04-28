package com.simpleehotels;

public class Employee{
    private final String ssn;
    private final String name;
    private final String address;
    private final String hotel_address;

    public Employee(String ssn, String name, String address, String hotel_address){
        this.ssn=ssn;
        this.name=name;
        this.address=address;
        this.hotel_address=hotel_address;
    }

    public String getSsn(){
        return ssn;
    }

    public String getName(){
        return name;
    }

     public String getAddress(){
        return address;
    }

    public String getHotelAddress(){
        return hotel_address;
    }

}