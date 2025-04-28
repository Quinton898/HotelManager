<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.simpleehotels.HotelService" %>
<%@ page import="com.simpleehotels.Hotel" %>
<%@ page import="com.simpleehotels.Message" %>
<%@ page import="java.util.ArrayList" %>

<%
    String address = request.getParameter("address");
    Integer numOfRooms = Integer.valueOf(request.getParameter("num_of_rooms"));
    String email = request.getParameter("email");
    Integer stars = Integer.valueOf(request.getParameter("stars"));
    String chainAddress = request.getParameter("chain_address");

    HotelService hotelService = new HotelService();
    Hotel hotel = new Hotel(address, numOfRooms, email, stars, chainAddress);

    Message msg;
    // try to update a student
    try {
        String value = hotelService.updateHotel(hotel);
        // if the value contains error/Error then this is an error message
        if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
        // else the student was successfully created
        else msg = new Message("success", value);
    } catch (Exception e) {
        e.printStackTrace();
        msg = new Message("error", "Something went wrong!");
    }

    // create an arraylist of messages and append the new message
    ArrayList<Message> messages = new ArrayList<>();
    messages.add(msg);

    // set session attribute named messages to messages value
    session.setAttribute("messages", messages);
    
    // redirect to students page
    response.sendRedirect("hotel.jsp");
%>