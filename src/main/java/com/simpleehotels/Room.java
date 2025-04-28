package com.simpleehotels;

import java.sql.Date;
import java.util.ArrayList;

public class Room {
    private final int roomNumber;
    private final String address;
    private float price;
    private String amenities;
    private String capacity;
    private final String viewType;
    private String damages;
    private final boolean extendible;

    public Room(int roomNumber, String address, float price, String amenities, String capacity, String viewType, String damages, boolean extendible) {
        this.roomNumber = roomNumber;
        this.address = address;
        this.price = price;
        this.amenities = amenities;
        this.capacity = capacity;
        this.viewType = viewType;
        this.damages = damages;
        this.extendible = extendible;
    }

    /* Getters and Setters */

    // Get room number
    public int getRoomNumber() {
        return roomNumber;
    }

    // Get address
    public String getRoomAddress() {
        return address;
    }

    // Get price and set price
    public float getRoomPrice() {
        return price;
    }
    public void setRoomPrice(float price) {
        this.price = price;
    }

    // Get ammenities and set ammenities
    public String getRoomAmenities() {
        return amenities;
    }
    public void setRoomAmenities(String ammenities) {
        this.amenities = ammenities;
    }

    // Get capacity and set capacity
    public String getRoomCapacity() {
        return capacity;
    }
    public void setRoomCapacity(String capacity) {
        this.capacity = capacity;
    }

    // Get view type
    public String getRoomViewType() {
        return viewType;
    }
    
    // Get damages and set damages
    public String getRoomDamages() {
        return damages;
    }
    public void setRoomDamages(String damages) {
        this.damages = damages;
    }

    // Get extendible
    public boolean isRoomExtendible() {
        return extendible;
    }

    public String getHotelChainName(ArrayList<Hotel> hotels, ArrayList<HotelChain> hotelChains) {
        for (HotelChain hotelChain : hotelChains) {
            for (Hotel hotel : hotels) {
                if (hotel.getAddress().equals(this.address) && hotel.getChainAddress().equals(hotelChain.getAddress())) {
                    return hotelChain.getName();
                }
            }
        }
        return "";
    }

    public boolean isAvailable(Date startDate, Date endDate, RoomService roomService) throws Exception {
        try{    
            ArrayList<Room> rooms = roomService.getAvailableRooms(startDate, endDate);
            for (Room room : rooms) {
                if (room.getRoomNumber() == this.roomNumber && room.getRoomAddress().equals(this.address)) {
                    return true;
                }
            }
            return false;
        } catch (Exception e) {
            throw new Exception("Could not check availability: " + e.getMessage());
        }
    }

    @Override
    public String toString() {
        return "Room{" +
                "roomNumber=" + roomNumber +
                ", address='" + address + '\'' +
                ", price=" + price +
                ", amenities='" + amenities + '\'' +
                ", capacity='" + capacity + '\'' +
                ", viewType='" + viewType + '\'' +
                ", damages='" + damages + '\'' +
                ", extendible=" + extendible +
                '}';
    }
}
