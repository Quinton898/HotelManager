<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.simpleehotels.RoomService" %>
<%@ page import="com.simpleehotels.Room" %>
<%@ page import="com.simpleehotels.Message" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.simpleehotels.Message" %>

<%
    // get student info from the request
    Integer roomNumber = Integer.valueOf(request.getParameter("roomNumber"));
    String address = request.getParameter("address");
    Float price = Float.valueOf(request.getParameter("price"));
    String amenities = request.getParameter("amenities");
    String capacity = request.getParameter("capacity");
    String viewType = request.getParameter("viewType");
    String damages = request.getParameter("damages");
    Boolean extendible = Boolean.valueOf(request.getParameter("extendible"));
    String ssn = request.getParameter("ssn");
    
    String startDateString = request.getParameter("startDateEntry");
    String endDateString = request.getParameter("endDateEntry");

    Date startDate = null;
    Date endDate = null;

    Message msg;

    if (startDateString != null && endDateString != null) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date startDateUtil = dateFormat.parse(startDateString);
        java.util.Date endDateUtil = dateFormat.parse(endDateString);

        startDate = new Date(startDateUtil.getTime());
        endDate = new Date(endDateUtil.getTime());
    } else {
        msg = new Message("error", "Room could not be booked!");
    }

    RoomService roomService = new RoomService();
    // create room object
    Room room = new Room(roomNumber, address, price, amenities, capacity, viewType, damages, extendible);  


    
    // try to update a student
    try {
        boolean value = roomService.bookRoom(room, ssn, startDate, endDate);
        // 
        if (value) msg = new Message("success", "Room successfully booked!");
        // 
        else msg = new Message("error", "Room could not be booked!");
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
    //response.sendRedirect("getDates.jsp");
    String url = "room.jsp?startDate=" + startDate + "&endDate=" + endDate;
    response.sendRedirect(url);
%>