
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.simpleehotels.Message" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.simpleehotels.HotelCapacity" %>
<%@ page import="com.simpleehotels.HotelCapacityService" %>
<%@ page import="java.util.Optional" %>


<%
    ArrayList<Message> messages;

    // get any incoming messages from session attribute named messages
    // if nothing exists then messages is an empty arraylist
    if ((ArrayList<Message>) session.getAttribute("messages") == null) messages = new ArrayList<>();
    // else get that value
    else messages = (ArrayList<Message>) session.getAttribute("messages");

    String msgField = "";

    // create the object in the form of a stringified json
    for (Message m : messages) {
        msgField += "{\"type\":\"" + m.type + "\",\"value\":\"" + m.value.replaceAll("['\"]+", "") + "\"},";
    }

    // empty session messages
    session.setAttribute("messages", new ArrayList<Message>());

    // retrieve grades from database
    HotelCapacityService hotelCapacityService = new HotelCapacityService();
    ArrayList<HotelCapacity> hotelCapacitys = null;
    try {
        hotelCapacitys = hotelCapacityService.getHotelCapcity();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title> Grades Page </title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/styles.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
</head>

<body>

        <jsp:include page="navbar.jsp"/>
    <input type="hidden" name="message" id="message" value='<%=msgField%>' >
    <div class="container">
        <div class="row" id="row">
            <div class="col-md-12">
                <div class="card" id="card-container">
                    <div class="card-body" id="card">
                        <% if (hotelCapacitys.size() == 0) { %>
                        <h1 style="margin-top: 5rem;">No Rooms found!</h1>
                        <% } else { %>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>Hotel Address</th>
                                    <th>Total Capacity of the hotel</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                for (HotelCapacity hotelCapacity : hotelCapacitys) { %>
                                <tr>
                                    <td><%= hotelCapacity.getHotel_Address() %></td>
                                    <td><%= hotelCapacity.getTotal_Capacity() %></td>
                                </tr>
                                <% } %>
                                </tbody>
                            </table>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    
</body>

</html>
