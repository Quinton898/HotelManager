<%@ page import="com.simpleehotels.Customer" %>
<%@ page import="com.simpleehotels.CustomerService" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    String name = request.getParameter("name");
    String ssn = request.getParameter("ssn");
    String address = request.getParameter("address");

    // Set current date as registration date
    java.sql.Date registrationDate = new java.sql.Date(new java.util.Date().getTime());

    // Create customer object
    Customer customer = new Customer(ssn, name, address, registrationDate);

    // Save to DB
    CustomerService service = new CustomerService();
    boolean success = service.createCustomer(customer);

    if (success) {
        out.println("<script>alert('Customer signed up successfully!'); window.location.href='rent.jsp';</script>");
    } else {
        out.println("<script>alert('Failed to sign up customer.'); window.history.back();</script>");
    }
%>
