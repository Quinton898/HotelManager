<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.simpleehotels.RoomService" %>
<%@ page import="com.simpleehotels.Room" %>
<%@ page import="com.simpleehotels.Message" %>
<%@ page import="java.util.ArrayList" %>

<%
    ArrayList<Message> messages;

    // Get any incoming messages from session attribute named messages
    // If nothing exists, then messages is an empty ArrayList
    if ((ArrayList<Message>) session.getAttribute("messages") == null) messages = new ArrayList<>();
    else messages = (ArrayList<Message>) session.getAttribute("messages");

    String msgField = "";

    // Create the object in the form of a stringified JSON
    for (Message m : messages) {
        msgField += "{\"type\":\"" + m.type + "\",\"value\":\"" + m.value.replaceAll("['\"]+", "") + "\"},";
    }

    // Empty session messages
    session.setAttribute("messages", new ArrayList<Message>());

    // Get all rooms from the database
    RoomService roomService = new RoomService();
    List<Room> rooms = null;
    try {
        rooms = roomService.getAllRooms();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Rooms Page</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/styles.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
</head>

<body>

    <div id="editModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Edit Rooms</h4>
                </div>
                <div class="modal-body">
                    <form id="modal-form">
                        <div style="text-align: center;">
                            <input type="text" name="room_num" id="room_num" readonly></br>
                            <input type="text" name="address" id="address"readonly></br>
                            <input type="text" name="price" id="price"></br>
                            <input type="text" name="amenities" id="amenities"></br>
                            <input type="text" name="capacity" id="capacity"></br>
                            <input type="text" name="view_type" id="view_type"></br>
                            <input type="text" name="damages" id="damages"></br>
                            <input type="text" name="extendible" id="extendible">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="submit" form="modal-form" class="btn btn-success">Update</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>

    <jsp:include page="navbar.jsp"/>

    <input type="hidden" name="message" id="message" value='<%=msgField%>'>
    <div class="container">
        <div class="row" id="row">
            <div class="col-md-12">
                <div class="card" id="card-container">
                    <div class="card-body" id="card">
                        <% if (rooms.size() == 0) { %>
                        <h1 style="margin-top: 5rem;">No Rooms found!</h1>
                        <% } else { %>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th>Room Number</th>
                                    <th>Hotel Address</th>
                                    <th>Price</th>
                                    <th>Amenities</th>
                                    <th>Capacity</th>
                                    <th>View Type</th>
                                    <th>Damages</th>
                                    <th>Extendible</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                for (Room room : rooms) { %>
                                <tr>
                                    <td><%= room.getRoomNumber() %></td>
                                    <td><%= room.getRoomAddress() %></td>
                                    <td><%= room.getRoomPrice() %></td>
                                    <td><%= room.getRoomAmenities() %></td>
                                    <td><%= room.getRoomCapacity() %></td>
                                    <td><%= room.getRoomViewType() %></td>
                                    <td><%= room.getRoomDamages() %></td>
                                    <td><%= room.isRoomExtendible() %></td>
                                    <form method="POST" action="delete-room-controller.jsp">
                                        <td>
                                            <input type="hidden" value="<%= room.getRoomNumber() %>" name="room_num" />
                                            <input type="hidden" value="<%= room.getRoomAddress() %>" name="address" />
                                            <button style="all: unset; cursor: pointer;" type="submit"><i class="fa fa-trash"></i></button>
                                        </td>
                                    </form>
                                    <td>
                                        <a type="button" onclick="setModalFields(this)"
                                           data-toggle="modal"
                                           data-room_num="<%= room.getRoomNumber() %>"
                                           data-address="<%= room.getRoomAddress() %>"
                                           data-price="<%= room.getRoomPrice() %>"
                                           data-amenities="<%= room.getRoomAmenities() %>"
                                           data-capacity="<%= room.getRoomCapacity() %>"
                                           data-view_type="<%= room.getRoomViewType() %>"
                                           data-damages="<%= room.getRoomDamages() %>"
                                           data-extendible="<%= room.isRoomExtendible() %>"
                                           data-target="#editModal">
                                            <i class="fa fa-edit"></i>
                                        </a>
                                    </td>
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

    <script>
        function setModalFields(row) {
            document.getElementById("room_num").value = row.dataset.room_num;
            document.getElementById("address").value = row.dataset.address;
            document.getElementById("price").value = row.dataset.price;
            document.getElementById("amenities").value = row.dataset.amenities;
            document.getElementById("capacity").value = row.dataset.capacity;
            document.getElementById("view_type").value = row.dataset.view_type;
            document.getElementById("damages").value = row.dataset.damages;
            document.getElementById("extendible").value = row.dataset.extendible;

            document.getElementById("modal-form").action = "update-room-controller.jsp";
            document.getElementById("modal-form").method = "POST";
        }
    </script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <script src="/assets/js/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

    <script>
        $(document).ready(function() {
            toastr.options = {
                "closeButton": true,
                "positionClass": "toast-bottom-right",
                "preventDuplicates": false
            };
            let messages = document.getElementById("message").value;
            if (messages !== "") messages = JSON.parse("[" + messages.slice(0, -1) + "]");
            else messages = [];

            messages.forEach(({ type, value }) => {
                switch (type) {
                    case "error":
                        toastr.error(value);
                        break;
                    case "success":
                        toastr.success(value);
                        break;
                    case "warning":
                        toastr.warning(value);
                        break;
                    default:
                        toastr.info(value);
                        break;
                }
            });
        });
    </script>

</body>

</html>