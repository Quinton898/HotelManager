<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.simpleehotels.CustomerService" %>
<%@ page import="com.simpleehotels.Customer" %>
<%@ page import="com.simpleehotels.Message" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Date" %>

<%
    // Get customer info from the request
    String ssn = request.getParameter("ssn");
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String registrationDateStr = request.getParameter("registration_date");

    // Parse the registration date
    Date registrationDate = null;
    try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date utilDate = dateFormat.parse(registrationDateStr);
            registrationDate = new java.sql.Date(utilDate.getTime());
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("messages", new ArrayList<Message>() {{
                add(new Message("error", "Invalid registration date format!"));
 }});
    response.sendRedirect("customerList.jsp");
    return;
}


    CustomerService customerService = new CustomerService();
    // Create customer object
    Customer customer = new Customer(ssn, name, address, registrationDate);

    Message msg;
    // Try to create a customer
    try {
        boolean value = customerService.createCustomer(customer);
        if (value) {
            msg = new Message("success", "Customer successfully created!");
        } else {
            msg = new Message("error", "Customer could not be created!");
        }
    } catch (Exception e) {
        e.printStackTrace();
        msg = new Message("error", "Something went wrong!");
    }

    // Create an ArrayList of messages and append the new message
    ArrayList<Message> messages = new ArrayList<>();
    messages.add(msg);

    // Set session attribute named messages to messages value
    session.setAttribute("messages", messages);
    // Redirect to customers page
    response.sendRedirect("customerList.jsp");
%>