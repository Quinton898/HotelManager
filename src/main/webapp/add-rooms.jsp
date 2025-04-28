<!-- filepath: c:\Users\qwd\AndroidStudioProjects\New folder\simpleehotels\src\main\webapp\add-room.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Create Room Page</title>
    <link rel="stylesheet" href="/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/assets/css/styles.css">
</head>

<body>

    <jsp:include page="navbar.jsp"/>

    <div class="container">
        <div class="row" id="row">
            <div class="col-md-12">
                <form class="form-horizontal" name="room-form" action="insert-room-controller.jsp" method="POST">
                    <div class="form-group col-sm-3 mb-3">
                        <label for="room_num">Room Number</label>
                        <input type="number" class="form-control" name="room_num" placeholder="Enter Room Number" required>
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="address">Hotel Address</label>
                        <input type="text" class="form-control" name="address" placeholder="Enter Hotel Address" required>
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="price">Price</label>
                        <input type="number" step="0.01" class="form-control" name="price" placeholder="Enter Price" required>
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="amenities">Amenities</label>
                        <input type="text" class="form-control" name="amenities" placeholder="Enter Amenities" required>
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="capacity">Capacity</label>
                        <select class="form-control" name="capacity" required>
                            <option value="single">Single</option>
                            <option value="double">Double</option>
                            <option value="queen">Queen</option>
                            <option value="double queen">Double Queen</option>
                            <option value="suite">Suite</option>
                        </select>
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="view_type">View Type</label>
                        <select class="form-control" name="view_type" required>
                            <option value="sea">Sea</option>
                            <option value="mountain">Mountain</option>
                        </select>
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="damages">Damages</label>
                        <input type="text" class="form-control" name="damages" placeholder="Enter Damages (if any)">
                    </div>
                    <div class="form-group col-sm-3 mb-3">
                        <label for="extendible">Extendible</label>
                        <select class="form-control" name="extendible" required>
                            <option value="true">Yes</option>
                            <option value="false">No</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary btn-submit-custom">Submit</button>
                </form>
            </div>
        </div>
    </div>

    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>