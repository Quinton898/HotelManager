package com.simpleehotels;

public class Hotel{
    private final String address;
    private final int num_of_rooms;
    private final String email;
    private final int stars;
    private final String chain_address;

    public Hotel(String address, int num_of_rooms, String email, int stars, String chain_address){
        this.address=address;
        this.num_of_rooms=num_of_rooms;
        this.email=email;
        this.stars=stars;
        this.chain_address=chain_address;

    }

    //getters
    public String getAddress(){
        return address;
    }

    public int getNumOfRooms(){
        return num_of_rooms;
    }

    public String getEmail(){
        return email;
    }

    public int getStars(){
        return stars;
    }

    public String getChainAddress(){
        return chain_address;
    }
}