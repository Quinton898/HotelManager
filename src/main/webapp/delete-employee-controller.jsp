<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.simpleehotels.EmployeeService" %>
<%@ page import="com.simpleehotels.Message" %>
<%@ page import="java.util.ArrayList" %>

<%
    String ssn = request.getParameter("ssn");

    Message msg;
    try {
        EmployeeService employeeService = new EmployeeService();
        String value = employeeService.deleteEmployee(ssn);
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