<%
    import java.util.ArrayList;
    import com.simpleehotels.Room;
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");

    ArrayList<Room> rooms = new ArrayList<>();

    for (Room room : rooms) {
        if (room.isAvailable(startDate, endDate)) {
            rooms.add(room);
        }
    }
%>