package com.simpleehotels;

public class HotelCapacity {
    private final String hotel_address;
    private final int total_capacity;


    public HotelCapacity(String hotel_address, int total_capacity) {
        this.hotel_address = hotel_address;
        this.total_capacity = total_capacity;
    }

    public String getHotel_Address() {
        return hotel_address;
    }
    public int getTotal_Capacity() {
        return total_capacity;
    }
}
