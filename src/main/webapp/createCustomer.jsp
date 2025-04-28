<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Create Customer</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<!-- Center container horizontally and vertically -->
<div class="container vh-100 d-flex justify-content-center align-items-center">
  <div class="text-center">
    <!-- Create Button (Big and Centered) -->
    <button class="btn btn-primary btn-lg mb-3" data-bs-toggle="modal" data-bs-target="#customerModal">Create Customer</button><br>

    <!-- Back Button -->
    <a href="index.jsp" class="btn btn-secondary mb-2">Back</a><br>

    <!-- Go to Customer List Button -->
    <a href="customerList.jsp" class="btn btn-info">View Customers</a>
  </div>
</div>

<!-- Customer Modal -->
<div class="modal fade" id="customerModal" tabindex="-1" aria-labelledby="customerModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form id="customerForm" action="create-customer-controller.jsp" method="post">
        <div class="modal-header">
          <h5 class="modal-title" id="customerModalLabel">Create Customer</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        
        <div class="modal-body">
          <div class="mb-3">
            <label for="name" class="form-label">Full Name</label>
            <input type="text" class="form-control" name="name" id="name" required>
          </div>
          <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <textarea class="form-control" name="address" id="address" rows="2" required></textarea>
          </div>
          <div class="mb-3">
            <label for="ssn" class="form-label">SSN</label>
            <input type="text" class="form-control" name="ssn" id="ssn" required>
          </div>
          <div class="mb-3">
            <label for="registration_date" class="form-label">Registration Date</label>
            <input type="date" class="form-control" name="registration_date" id="registration_date" required>
          </div>
        </div>
        
        <div class="modal-footer">
          <button type="submit" class="btn btn-success">Save Customer</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Bootstrap JS and Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html> 
