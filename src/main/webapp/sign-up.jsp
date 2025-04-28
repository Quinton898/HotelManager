<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Page</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
        }
        .signup-container {
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
        .signup-btn {
            background-color: #3498db;
            color: white;
        }
        .signup-btn:hover {
            background-color: #2980b9;
        }
        .login-btn {
            background-color: #2ecc71;
            color: white;
        }
        .login-btn:hover {
            background-color: #27ae60;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <h2>Sign Up</h2>
        <form action="sign-up-controller.jsp" method="post">
            <input type="text" name="name" placeholder="Name" required>
            <input type="text" name="ssn" placeholder="Social Security Number" required>
            <input type="text" name="address" placeholder="Address" required>
            <button type="submit" class="signup-btn">Sign Up</button>
        </form>
        <!--<button class="login-btn" onclick="window.location.href='login.jsp'">Go to Login</button> -->
    </div>
</body>
</html>
