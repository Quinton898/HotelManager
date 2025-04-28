<%@ page import="com.simpleehotels.CustomerService" %>
<%@ page import="com.simpleehotels.Customer" %>
<%
    String ssn = request.getParameter("ssn");
    CustomerService service = new CustomerService();
    Customer customer = null;

    try {
        for (Customer c : service.getCustomers()) {
            if (c.getSsn().equals(ssn)) {
                customer = c;
                break;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<html>
<head>
    <title>Update Customer</title>
</head>
<body>
<h2>Update Customer</h2>

<% if (customer != null) { %>
    <form action="update-customer-controller.jsp" method="post">
        <input type="hidden" name="ssn" value="<%= customer.getSsn() %>" />
        Name: <input type="text" name="name" value="<%= customer.getName() %>" /><br/>
        Address: <input type="text" name="address" value="<%= customer.getAddress() %>" /><br/>
        Registration Date: <input type="date" name="registrationDate" value="<%= customer.getRegistrationDate() %>" /><br/>
        <input type="submit" value="Update Customer" />
    </form>
<% } else { %>
    <p>Customer not found!</p>
<% } %>
</body>
</html>