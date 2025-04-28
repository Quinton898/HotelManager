<!-- filepath: c:\Users\qwd\AndroidStudioProjects\New folder\simpleehotels\src\main\webapp\insert-room-controller.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.simpleehotels.RoomService" %>
<%@ page import="com.simpleehotels.Room" %>
<%@ page import="com.simpleehotels.Message" %>
<%@ page import="java.util.ArrayList" %>

<%
    int roomNum = Integer.parseInt(request.getParameter("room_num"));
    String address = request.getParameter("address");
    float price = Float.parseFloat(request.getParameter("price"));
    String amenities = request.getParameter("amenities");
    String capacity = request.getParameter("capacity");
    String viewType = request.getParameter("view_type");
    String damages = request.getParameter("damages");
    boolean extendible = Boolean.parseBoolean(request.getParameter("extendible"));

    RoomService roomService = new RoomService();
    Room room = new Room(roomNum, address, price, amenities, capacity, viewType, damages, extendible);

    Message msg;
    try {
        String value = roomService.createRoom(room);
        if (value.contains("Error") || value.contains("error")) {
            msg = new Message("error", value);
        } else {
            msg = new Message("success", value);
        }
    } catch (Exception e) {
        e.printStackTrace();
        msg = new Message("error", "Something went wrong!");
    }

    ArrayList<Message> messages = new ArrayList<>();
    messages.add(msg);

    session.setAttribute("messages", messages);
    response.sendRedirect("employee.jsp");
%>