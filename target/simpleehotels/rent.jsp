<%@ page import="com.simpleehotels.RoomService" %>
<%@ page import="com.simpleehotels.Room" %>
<%@ page import="com.simpleehotels.Message" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ page import="com.simpleehotels.HotelService" %>
<%@ page import="com.simpleehotels.Hotel" %>
<%@ page import="com.simpleehotels.HotelChainService" %>
<%@ page import="com.simpleehotels.HotelChain" %>
<%@ page import="java.util.Optional" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Date" %>

<%
    ArrayList<Message> messages;

    if ((ArrayList<Message>) session.getAttribute("messages") == null) messages = new ArrayList<>();
    else messages = (ArrayList<Message>) session.getAttribute("messages");

    String msgField = "";

    for (Message m : messages) {
        msgField += "{\"type\":\"" + m.type + "\",\"value\":\"" + m.value.replaceAll("['\"]+", "") + "\"},";
    }

    session.setAttribute("messages", new ArrayList<Message>());

    RoomService roomService = new RoomService();
    HotelService hotelService = new HotelService();
    HotelChainService hotelChainService = new HotelChainService();

    String startDateString = request.getParameter("startDate");
    String endDateString = request.getParameter("endDate");

    Date startDate = null;
    Date endDate = null;

    if (startDateString != null && endDateString != null) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date startDateUtil = dateFormat.parse(startDateString);
        java.util.Date endDateUtil = dateFormat.parse(endDateString);

        startDate = new Date(startDateUtil.getTime());
        endDate = new Date(endDateUtil.getTime());

    }

    ArrayList<Room> rooms = new ArrayList<>();
    ArrayList<Hotel> hotels = null;
    ArrayList<HotelChain> hotelChains = null;

    try {
        rooms = roomService.getAvailableRooms(startDate, endDate);
        hotels = hotelService.getHotels();
        hotelChains = hotelChainService.getHotelChains();
    } catch (Exception e) {
        throw new Exception("Error retrieving rooms: " + e.getMessage());
    }
%>
 

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title> Book A Room </title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/styles.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css">
</head>

<html>
<body>
    <div id="editModal" class="modal fade" role="dialog">
        <div class="modal-dialog">


            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Rent Room</h4>
                    <h6 class="modal-title">Would the customer like to rent this room?</h6>
                </div>
                <div class="modal-body">
                    <form id="modal-form">
                        <div style="text-align: center;">
                            <input type="hidden" name="roomNumber" id="roomNumber">
                            <input type="hidden" name="address" id="address">
                            <input type="hidden" name="price" id="price">
                            <input type="hidden" name="amenities" id="amenities">
                            <input type="hidden" name="capacity" id="capacity">
                            <input type="hidden" name="viewType" id="viewType">
                            <input type="hidden" name="damages" id="damages">
                            <input type="hidden" name="extendible" id="extendible">
                            <input type="hidden" name="startDateEntry" id="startDateEntry">
                            <input type="hidden" name="endDateEntry" id="endDateEntry">
                            <p id="roomNumberText">Room Number: </p>
                            <p id="addressText">Address: </p>
                            <p id="priceText">Price: </p>
                            <p id="amenitiesText">Amenities: </p>
                            <p id="capacityText">Capacity: </p>
                            <p id="viewTypeText">View Type: </p>
                            <p id="damagesText">Damages: </p>
                            <p id="extendibleText">Extendible: </p>
                            <p id="startDateText">Start Date: </p>
                            <p id="endDateText">End Date: </p>
                            <input type="text" name="ssn" id="ssn">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="confirm" form="modal-form" class="btn btn-success">Confirm</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>
    <div class="container">
        <button class="btn btn-primary mb-3" onclick="window.location.href='index.jsp'">Back to Home</button>
        <button class="btn btn-primary mb-3" onclick="window.location.href='sign-up.jsp'">Sign Up</button>
    </div>
    <div id="table-filter-container" class="room-page">
        <div class="filter-container">
            <ul>
                <li>
                    <label for="filter" class="mr-2">Capacity:</label>
                    <select id="capacityFilter"  onchange="filterRooms()">
                        <option value="">All</option>
                        <option value="single">Single</option>
                        <option value="double">Double</option>
                        <option value="queen">Queen</option>
                        <option value="double queen">Double Queen</option>
                        <option value="suite">Suite</option>
                    </select>
                </li>
                <li>
                    <label for="filter" class="mr-2">Price:</label>
                    <select id="priceFilter" onchange="filterRooms()">
                        <option value="">All</option>
                        <option value="low">Below $100</option>
                        <option value="medium">Below $250</option>
                        <option value="high">Below $500</option>
                    </select>
                </li>
                <li>
                    <label for="filter" class="mr-2">Hotel Category:</label>
                    <select id="categoryFilter" onchange="filterRooms()">
                        <option value="">All</option>
                        <option value="1">1 Star</option>
                        <option value="2">2 Star</option>
                        <option value="3">3 Star</option>
                        <option value="4">4 Star</option>
                        <option value="5">5 Star</option>
                    </select>
                </li>
                <li>
                    <label for="filter" class="mr-2">Number of Rooms:</label>
                    <select id="numberOfRoomsFilter" onchange="filterRooms()">
                        <option value="">All</option>
                        <option value="50">Less Than 50</option>
                        <option value="70">Less Than 70</option>
                        <option value="100">Less Than 100</option>
                    </select>
                </li>
                <li>
                    <label for="filter" class="mr-2">Area:</label>
                    <input type="text" id="areaFilter" placeholder="Enter area" onkeyup="filterRooms()">
                </li>
                <li>
                    <label for="filter" class="mr-2">Hotel Chain:</label>
                    <select id="hotelChainFilter" onchange="filterRooms()">
                        <option value="">All</option>
                        <% for (HotelChain hotelChain : hotelChains) { %>
                            <option value="<%= hotelChain.getName() %>"><%= hotelChain.getName() %></option>
                        <% } %>
                    </select>
                </li>
            </ul>
            <button class="changeDates" onclick="window.location.href='get-dates-renting.jsp'">Change Dates</button>
        </div>
        <input type="hidden" name="message" id="message" value='<%=msgField%>' >
        <div class="table-container">
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
                                            <th>Address</th>
                                            <th>Price</th>
                                            <th>Amenities</th>
                                            <th>Capacity</th>
                                            <th>View Type</th>
                                            <th>Damages</th>
                                            <th>Extendible</th>
                                            <th>Rent</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <% for (Room room : rooms) { %>
                                        <tr data-category="<%= hotels.stream().filter(h -> h.getAddress().equals(room.getRoomAddress())).findFirst().map(Hotel::getStars).orElse(0) %>"
                                            data-numberofrooms="<%= hotels.stream().filter(h -> h.getAddress().equals(room.getRoomAddress())).findFirst().map(Hotel::getNumOfRooms).orElse(0) %>"
                                            data-chainname="<%= room.getHotelChainName(hotels, hotelChains) %>">
                                            <td><%= room.getRoomNumber() %></td>
                                            <td><%= room.getRoomAddress() %></td>
                                            <td><%= room.getRoomPrice() %></td>
                                            <td><%= room.getRoomAmenities() %></td>
                                            <td><%= room.getRoomCapacity() %></td>
                                            <td><%= room.getRoomViewType() %></td>
                                            <td><%= room.getRoomDamages() %></td>
                                            <td><%= room.isRoomExtendible() %></td>
                                            <td>
                                                <a type="button" onclick="setModalFields(this)"
                                                    data-toggle="modal" 
                                                    data-roomnumber="<%= room.getRoomNumber() %>"
                                                    data-address="<%= room.getRoomAddress() %>" 
                                                    data-price="<%= room.getRoomPrice() %>"
                                                    data-amenities="<%= room.getRoomAmenities() %>"
                                                    data-capacity="<%= room.getRoomCapacity() %>"
                                                    data-viewtype="<%= room.getRoomViewType() %>"
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
    </div>
    <script>
        const startDate = "<%= startDate %>";
        const endDate = "<%= endDate %>";
    </script>
    <script>
        function setModalFields(row) {
            document.getElementById("roomNumberText").innerText = "Room Number: " + row.dataset.roomnumber;
            document.getElementById("addressText").innerText = "Address: " + row.dataset.address;
            document.getElementById("priceText").innerText = "Price: " + row.dataset.price;
            document.getElementById("amenitiesText").innerText = "Amenities: " + row.dataset.amenities;
            document.getElementById("capacityText").innerText = "Capacity: " + row.dataset.capacity;
            document.getElementById("viewTypeText").innerText = "View Type: " + row.dataset.viewtype;
            document.getElementById("damagesText").innerText = "Damages: " + row.dataset.damages;
            document.getElementById("extendibleText").innerText = "Extendible: " + row.dataset.extendible;
            document.getElementById("startDateText").innerText = "Start Date: " + startDate;
            document.getElementById("endDateText").innerText = "End Date: " + endDate;

            // Update the hidden input fields in the form
            document.getElementById("roomNumber").value = row.dataset.roomnumber;
            document.getElementById("address").value = row.dataset.address;
            document.getElementById("price").value = row.dataset.price;
            document.getElementById("amenities").value = row.dataset.amenities;
            document.getElementById("capacity").value = row.dataset.capacity;
            document.getElementById("viewType").value = row.dataset.viewtype;
            document.getElementById("damages").value = row.dataset.damages;
            document.getElementById("extendible").value = row.dataset.extendible;
            document.getElementById("startDateEntry").value = startDate;
            document.getElementById("endDateEntry").value = endDate;

            document.getElementById("modal-form").action = "rent-room-controller.jsp";
            document.getElementById("modal-form").method = "POST";
        }
    </script>
    <script>
        function filterRooms() {
            const capacityFilter = document.getElementById("capacityFilter").value;
            const priceFilter = document.getElementById("priceFilter").value;
            const categoryFilter = document.getElementById("categoryFilter").value;
            const numberOfRoomsFilter = document.getElementById("numberOfRoomsFilter").value;
            const areaFilter = document.getElementById("areaFilter").value;
            const hotelChainFilter = document.getElementById("hotelChainFilter").value;
            const rows = document.querySelectorAll("tbody tr");

            rows.forEach(row => {
                const price = parseFloat(row.querySelector("td:nth-child(3)").innerText.replace('$', ''));
                const capacity = row.querySelector("td:nth-child(5)").innerText;
                const roomAddress = row.querySelector("td:nth-child(2)");
                const category = parseInt(row.dataset.category); 
                const numberOfRooms = parseInt(row.dataset.numberofrooms);
                const area = roomAddress ? roomAddress.innerText : ""; // Get the area from the address cell
                const areaMatch = area.toLowerCase().includes(areaFilter.toLowerCase());
                const hotelChain = row.dataset.chainname; // Get the hotel chain from the data attribute

                // Show all rows by default
                row.style.display = "";

                // Apply filters
                // Capacity filter logic            
                if (capacityFilter === "single" && capacity !== "single") {
                    row.style.display = "none"; // Example: Hide rooms that don't match the selected capacity
                } else if ( capacityFilter === "double" && capacity !== "double") {
                    row.style.display = "none"; 
                } else if (capacityFilter === "queen" && capacity !== "queen") {
                    row.style.display = "none"; 
                } else if (capacityFilter === "double queen" && capacity !== "double queen") {
                    row.style.display = "none"; 
                } else if (capacityFilter === "suite" && capacity !== "suite") {
                    row.style.display = "none";
                }
                if (priceFilter === "low" && price > 100) {
                    row.style.display = "none"; 
                } else if (priceFilter === "medium" && price > 250) {
                    row.style.display = "none"; 
                } else if (priceFilter === "high" && price > 500) {
                    row.style.display = "none"; 
                }
                // Category filter logic
                if (categoryFilter === "1" && category !== 1) {
                    row.style.display = "none"; 
                } else if (categoryFilter === "2" && category !== 2) {
                    row.style.display = "none"; 
                } else if (categoryFilter === "3" && category !== 3) {
                    row.style.display = "none"; 
                } else if (categoryFilter === "4" && category !== 4) {
                    row.style.display = "none"; 
                } else if (categoryFilter === "5" && category !== 5) {
                    row.style.display = "none"; 
                }
                // Number of rooms filter logic
                if (numberOfRoomsFilter === "50" && numberOfRooms > 50) {
                    row.style.display = "none"; 
                } else if (numberOfRoomsFilter === "70" && numberOfRooms > 70) {
                    row.style.display = "none"; 
                } else if (numberOfRoomsFilter === "100" && numberOfRooms > 100) {
                    row.style.display = "none"; 
                }
                // Area filter logic
                if (areaFilter && !areaMatch) {
                    row.style.display = "none"; 
                }
                // Hotel chain filter logic
                if (hotelChainFilter && !hotelChain.toLowerCase().includes(hotelChainFilter.toLowerCase())) {
                    row.style.display = "none";
                }
            });
        }
    </script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <script src="/assets/js/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

    <script>
        $(document).ready(function() {
            /* In order to access variables sent to ejs file to script you must Parse them to string */
            /* then to parse them back to JSON */
            let messages = document.getElementById("message").value;
            if (messages !== "") messages = JSON.parse("[" + messages.slice(0, -1) + "]");
            else messages = [];

            messages
            .forEach(({
                type,
                value
            }) => {
            switch (type) {
                case "error":
                    toastr.error(value)
                    break;
                case "success":
                    toastr.success(value)
                    break;
                case "warning":
                    toastr.warning(value)
                    break;
                default:
                    toastr.info(value)
                        break;
                }
            });
        })
    </script>
</body>
</html>