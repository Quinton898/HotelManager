<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.simpleehotels.CustomerService" %>
<%@ page import="com.simpleehotels.Customer" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
    <title>Customer List</title>
    <!-- Bootstrap for button -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
            text-align: left;
        }
        td form {
            display: inline;
        }
    </style>
</head>
<body>

<!-- Top-right Back Button -->
<div class="container mt-3">
    <div class="d-flex justify-content-end">
        <a href="createCustomer.jsp" class="btn btn-primary btn-lg">Back to Create Customer</a>
    </div>
</div>

<h1 class="text-center my-4">Customer List</h1>

<div class="container">
    <table class="table table-bordered">
        <thead class="table-light">
            <tr>
                <th>SSN</th>
                <th>Name</th>
                <th>Address</th>
                <th>Registration Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                CustomerService service = new CustomerService();
                try {
                    ArrayList<Customer> customers = service.getCustomers();
                    for (Customer c : customers) {
            %>
                        <tr>
                            <td><%= c.getSsn() %></td>
                            <td><%= c.getName() %></td>
                            <td><%= c.getAddress() %></td>
                            <td><%= c.getRegistrationDate() %></td>
                            <td>
                                <!-- Update -->
                                <form action="customerUpdate.jsp" method="get">
                                    <input type="hidden" name="ssn" value="<%= c.getSsn() %>" />
                                    <input type="submit" value="Update" class="btn btn-sm btn-warning" />
                                </form>

                                <!-- Delete -->
                                <form action="delete-customer-controller.jsp" method="post" onsubmit="return confirm('Are you sure you want to delete this customer?');">
                                    <input type="hidden" name="ssn" value="<%= c.getSsn() %>" />
                                    <input type="submit" value="Delete" class="btn btn-sm btn-danger" />
                                </form>
                            </td>
                        </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                    <tr>
                        <td colspan="5">Error fetching customers.</td>
                    </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>

</body>
</html>

