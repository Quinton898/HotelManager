<!-- filepath: c:\Users\qwd\AndroidStudioProjects\New folder\simpleehotels\src\main\webapp\delete-room-controller.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.simpleehotels.RoomService" %>
<%@ page import="com.simpleehotels.Message" %>
<%@ page import="java.util.ArrayList" %>

<%
    int roomNum = Integer.parseInt(request.getParameter("room_num"));
    String address = request.getParameter("address");

    Message msg;
    try {
        RoomService roomService = new RoomService();
        String value = roomService.deleteRoom(roomNum, address);
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
    response.sendRedirect("room-list.jsp");
%>