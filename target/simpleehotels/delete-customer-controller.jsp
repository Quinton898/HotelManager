<%@ page import="com.simpleehotels.CustomerService" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    String ssn = request.getParameter("ssn");
    if (ssn != null && !ssn.isEmpty()) {
        CustomerService service = new CustomerService();
        try {
            String query = "DELETE FROM customer WHERE ssn = ?";
            java.sql.Connection con = new com.simpleehotels.ConnectionDB().getConnection();
            java.sql.PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, ssn);
            int rows = stmt.executeUpdate();
            stmt.close();
            con.close();
            if (rows > 0) {
                response.sendRedirect("customerList.jsp");
            } else {
                out.println("Customer not found or couldn't be deleted.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error deleting customer: " + e.getMessage());
        }
    } else {
        out.println("Invalid SSN.");
    }
%>
