<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Role Based Login</title>

<style>
*{ box-sizing:border-box; }
body{
    font-family:"Segoe UI",Tahoma,sans-serif;
    background:linear-gradient(135deg,#667eea,#764ba2);
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
    margin:0;
}
.login-box{
    background:#fff;
    padding:30px;
    width:100%;
    max-width:350px;
    border-radius:12px;
    box-shadow:0 15px 30px rgba(0,0,0,0.2);
}
h2{
    text-align:center;
    margin-bottom:20px;
}
input, select{
    width:100%;
    padding:12px;
    margin:10px 0;
    border-radius:6px;
    border:1px solid #ccc;
}
button{
    width:100%;
    padding:12px;
    background:linear-gradient(135deg,#007bff,#0056b3);
    color:white;
    border:none;
    border-radius:6px;
    font-size:16px;
    cursor:pointer;
}
.error{
    color:#dc3545;
    text-align:center;
    font-size:14px;
}
.signup-link{
    text-align:center;
    margin-top:15px;
}
.signup-link a{
    color:#667eea;
    text-decoration:none;
    font-weight:600;
}
</style>
</head>

<body>

<div class="login-box">
    <h2>Login</h2>

    <form action="LoginServlet" method="post">

        <select name="role" required>
            <option value="">Select Role</option>
            <option value="admin">Admin</option>
            <option value="teacher">Teacher</option>
            <option value="student">Student</option>
        </select>

        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>

        <div class="error">
            <%= request.getAttribute("errorMsg") != null ? request.getAttribute("errorMsg") : "" %>
        </div>

        <button type="submit">Login</button>
    </form>

    <!-- <div class="signup-link">
        Don’t have an account?
        <a href="signup.jsp">Signup</a>
    </div> -->
</div>

</body>
</html>
