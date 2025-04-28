<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.simpleehotels.EmployeeService" %>
<%@ page import="com.simpleehotels.Employee" %>
<%@ page import="com.simpleehotels.Message" %>
<%@ page import="java.util.ArrayList" %>

<%
    String ssn = request.getParameter("ssn");
    String name = request.getParameter("name");
    String address = request.getParameter("address");
    String hotelAddress = request.getParameter("hotel_address");

    EmployeeService employeeService = new EmployeeService();
    Employee employee = new Employee(ssn, name, address, hotelAddress);

    Message msg;
    try {
        String value = employeeService.updateEmployee(employee);
        if (value.contains("Error") || value.contains("error")) {
            msg = new Message("error", value);
        } else {
            msg = new Message("success", value);
        }
    } catch (Exception e) {
        e.printStackTrace();
        msg = new Message("error", "Something went wrong!");
    }

    ArrayList<Message> messages = new ArrayList<>();
    messages.add(msg);

    session.setAttribute("messages", messages);
    response.sendRedirect("employee-list.jsp");
%>