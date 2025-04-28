<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guest & Employee Buttons</title>
    <style>
        body {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      height: 100vh;
      background-color: #f4f4f4;
      margin: 0;
      font-family: Arial, sans-serif;
    }

    .title {
      font-size: 40px;
      font-weight: bold;
      background: linear-gradient(to right, #3498db, #2ecc71);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      animation: fadeIn 2s ease-in-out;
      margin-bottom: 40px;
    }

    @keyframes fadeIn {
      from {
        opacity: 0;
        transform: translateY(-20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .container {
      display: flex;
      gap: 20px;
    }

    button {
      padding: 15px 30px;
      font-size: 18px;
      border: none;
      cursor: pointer;
      border-radius: 5px;
      transition: 0.3s;
    }

    .guest {
      background-color: #3498db;
      color: white;
    }

    .guest:hover {
      background-color: #2980b9;
    }

    .employee {
      background-color: #2ecc71;
      color: white;
    }

    .employee:hover {
      background-color: #27ae60;
    }
    </style>
</head>
<body>
    <div class="title">SimpleeHotels</div>
    <div class="container">
        <button class="guest" onclick="window.location.href='getDates.jsp'">Guest</button>
        <button class="employee" onclick="window.location.href='employee.jsp'">Employee</button>
    </div>
</body>
</html>

