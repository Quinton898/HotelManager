<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.simpleehotels.RoomService" %>
<%@ page import="com.simpleehotels.Room" %>
<%@ page import="com.simpleehotels.Message" %>
<%@ page import="java.util.ArrayList" %>

<%
    Integer roomNumber = Integer.valueOf(request.getParameter("room_num"));
    String address = request.getParameter("address");
    Float price = Float.valueOf(request.getParameter("price"));
    String amenities = request.getParameter("amenities");
    String capacity = request.getParameter("capacity");
    String viewType = request.getParameter("view_type");
    String damages = request.getParameter("damages");
    Boolean extendible = Boolean.valueOf(request.getParameter("extendible"));

    Room room = new Room(roomNumber, address, price, amenities, capacity, viewType, damages, extendible);

    RoomService roomService = new RoomService();
    Message msg;

    try {
        String result = roomService.updateRoom(room);
        if (result.contains("Error") || result.contains("error")) {
            msg = new Message("error", result);
        } else {
            msg = new Message("success", result);
        }
    } catch (Exception e) {
        e.printStackTrace();
        msg = new Message("error", "Something went wrong while updating the room!");
    }

    ArrayList<Message> messages = new ArrayList<>();
    messages.add(msg);

    session.setAttribute("messages", messages);

    response.sendRedirect("room-list.jsp");
%>