package com.simpleehotels;

public class AvailableRoom {
    private final String area;
    private final int available_rooms;


    public AvailableRoom(String area, int available_rooms) {
        this.area = area;
        this.available_rooms = available_rooms;
    }

    public String getArea() {
        return area;
    }
    public int getAvailable_rooms() {
        return available_rooms;
    }
}
