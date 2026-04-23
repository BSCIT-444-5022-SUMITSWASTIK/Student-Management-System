<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Management System</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: "Segoe UI", Tahoma, sans-serif;
            height: 100vh;
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            justify-content: center;
            align-items: center;
            color: #fff;
        }

        .welcome-box {
            background: rgba(255, 255, 255, 0.12);
            padding: 50px 40px;
            border-radius: 16px;
            text-align: center;
            max-width: 450px;
            width: 100%;
            backdrop-filter: blur(8px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
            animation: fadeIn 0.8s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h1 {
            font-size: 28px;
            margin-bottom: 10px;
        }

        p {
            font-size: 16px;
            margin-bottom: 30px;
            opacity: 0.9;
        }

        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        .btn {
            padding: 14px 26px;
            font-size: 16px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .btn-login {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: #fff;
        }

        .btn-signup {
            background: linear-gradient(135deg, #28a745, #1e7e34);
            color: #fff;
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.3);
        }

        @media (max-width: 480px) {
            .btn-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

<div class="welcome-box">
    <h1>Student Management System</h1>
    <p>Manage students, teachers, and academic records easily and efficiently.</p>

    <div class="btn-group">
        <button class="btn btn-login" onclick="location.href='login.jsp'">Login</button>
    </div>
</div>

</body>
</html>
