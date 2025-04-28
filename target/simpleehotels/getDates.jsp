    
<body>    
    <div id="mandatoryModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Mandatory Form</h4>
                </div>
                <div class="modal-body">
                    <form id="availabilityForm" method="GET" action="checkAvailability.jsp">
                        <label for="startDate">Start Date:</label>
                        <input type="date" id="startDate" name="startDate" required>
                        <label for="endDate">End Date:</label>
                        <input type="date" id="endDate" name="endDate" required>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="submit" id="checkAvailabilityButton" class="btn-primary">See Available Rooms</button>
                </div>
            </div>
        </div>
    </div>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
        }
        .modal-dialog {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            margin: 5px;
        }
        .btn-primary {
            background-color: #3498db;
            color: white;
        }
        .btn-primary:hover {
            background-color: #2980b9;
        }
    </style>
    <script>
        document.getElementById("checkAvailabilityButton").addEventListener("click", function () {
            // Get the startDate and endDate values
            const startDate = document.getElementById("startDate").value;
            const endDate = document.getElementById("endDate").value;

            // Validate the input
            if (!startDate || !endDate) {
                alert("Please select both start and end dates.");
                return;
            }

            // Redirect to room.jsp with the dates as query parameters
            const url = "room.jsp?startDate=" + encodeURIComponent(startDate) + "&endDate=" + encodeURIComponent(endDate);
            window.location.href = url;
        });
    </script>
    <script>
        $(document).ready(function() {
            // Show the modal when the page loads
                $('#mandatoryModal').modal({
                    backdrop: 'static', // Prevent closing by clicking outside
                    keyboard: false     // Prevent closing with the Escape key
                });

                // Handle form submission
                $('#mandatoryForm').on('submit', function (e) {
                    e.preventDefault(); // Prevent default form submission

                    const ssn = $('#ssn').val();
                    if (ssn.trim() === '') {
                        alert('SSN is required!');
                        return;
                    }

                    // Close the modal after successful submission
                    $('#mandatoryModal').modal('hide');

                    // Optionally, send the form data to the server
                    // $.post('/your-server-endpoint', $(this).serialize());
                });
            toastr.options = {
                "closeButton": true,
                "positionClass": "toast-bottom-right",
                "preventDuplicates": false
            };
            let messages = document.getElementById("message").value;
            if (messages !== "") messages = JSON.parse("[" + messages.slice(0, -1) + "]");
            else messages = [];
            messages
                .forEach(({ type, value }) => {
                    switch (type) {
                        case "error":
                            toastr.error(value)
                            break;
                        case "success":
                            toastr.success(value)
                            break;
                        case "warning":
                            toastr.warning(value)
                            break;
                        default:
                            toastr.info(value)
                            break;
                    }
                });
        });
    </script>
</body>
        