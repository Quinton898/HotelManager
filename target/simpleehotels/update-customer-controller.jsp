<%@ page import="java.sql.*" %>
<%@ page import="com.simpleehotels.ConnectionDB" %>

<%
    String ssn = request.getParameter("ssn");
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String registrationDate = request.getParameter("registrationDate");

    try {
        ConnectionDB db = new ConnectionDB();
        Connection con = db.getConnection();

        String query = "UPDATE customer SET name = ?, address = ?, registration_date = ? WHERE ssn = ?";
        PreparedStatement stmt = con.prepareStatement(query);
        stmt.setString(1, name);
        stmt.setString(2, address);
        stmt.setDate(3, java.sql.Date.valueOf(registrationDate));
        stmt.setString(4, ssn);

        int rowsUpdated = stmt.executeUpdate();
        stmt.close();
        con.close();

        if (rowsUpdated > 0) {
            response.sendRedirect("customerList.jsp");
        } else {
            out.println("Customer update failed.");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error updating customer: " + e.getMessage());
    }
%>