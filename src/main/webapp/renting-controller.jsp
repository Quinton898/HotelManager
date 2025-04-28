<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.simpleehotels.BookingService" %>
<%@ page import="com.simpleehotels.Booking" %>
<%@ page import="com.simpleehotels.Message" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Date" %>



<%

    // create a message object
    Message msg;
    // try to delete a grade
    try {
        String bookingID = request.getParameter("bookingID");
        Date startDate = Date.valueOf(request.getParameter("startDate"));
        Date endDate = Date.valueOf(request.getParameter("endDate"));
        float price = Float.parseFloat(request.getParameter("price"));
        String customerSSN = request.getParameter("customerSSN");
        int roomNumber = Integer.parseInt(request.getParameter("roomNumber"));
        String address = request.getParameter("address");
        Booking booking = new Booking(bookingID, startDate, endDate, price, customerSSN, roomNumber, address);

        BookingService bookingService = new BookingService();
        // save the message returned from trying to delete a grade
        String value = bookingService.createRenting(booking);

        // in case the value contains error/Error then this message is an error
        if (value.contains("Error") || value.contains("error")) msg = new Message("error", value);
        // else the grade was successfully deleted
        else msg = new Message("success", value);
    } catch (Exception e) {
        e.printStackTrace();
        msg = new Message("error", "Something went wrong!");
    }

    // append the message in a messages arraylist
    ArrayList<Message> messages = new ArrayList<>();
    messages.add(msg);

    // set session attribute named messages with the messages arraylist
    session.setAttribute("messages", messages);
    response.sendRedirect("booking-list.jsp");
%>