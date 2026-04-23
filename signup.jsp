<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String role = (String) session.getAttribute("role");
if (role == null || !role.equals("admin")) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Create Account</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>
body{
    font-family:'Poppins',sans-serif;
    background:linear-gradient(135deg,#1d2671,#c33764);
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
}

.card{
    border-radius:16px;
    box-shadow:0 15px 30px rgba(0,0,0,0.25);
    animation:fadeIn 0.6s ease-in-out;
}

@keyframes fadeIn{
    from{opacity:0; transform:translateY(15px);}
    to{opacity:1; transform:translateY(0);}
}

.form-control, .form-select{
    border-radius:10px;
    padding:12px;
}

.btn{
    border-radius:10px;
    padding:12px;
    font-weight:600;
}

.error{
    color:#dc3545;
    font-size:14px;
    text-align:center;
}

.success{
    color:#28a745;
    font-size:14px;
    text-align:center;
}
</style>
</head>

<body>

<div class="col-md-4 col-sm-10">

<div class="card">
    <div class="card-header bg-primary text-white text-center">
        <h4><i class="fa fa-user-plus"></i> Create Account</h4>
    </div>

    <div class="card-body">

        <form action="SignupServlet" method="post" onsubmit="return validateSignup()">

            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <input type="text" id="fullname" name="fullname" class="form-control"
                       placeholder="Enter full name">
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" id="email" name="email" class="form-control"
                       placeholder="Enter email address">
            </div>

            <div class="mb-3">
                <label class="form-label">Role</label>
                <select id="role" name="role" class="form-select">
                    <option value="">Select Role</option>
                    <option value="admin">Admin</option>
                    <option value="teacher">Teacher</option>
                    <option value="student">Student</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-control"
                       placeholder="Enter password">
            </div>

            <div class="mb-3">
                <label class="form-label">Confirm Password</label>
                <input type="password" id="confirmPassword" class="form-control"
                       placeholder="Confirm password">
            </div>

            <!-- Messages -->
            <div class="error mb-2">
                <%= request.getAttribute("errorMsg") != null ? request.getAttribute("errorMsg") : "" %>
            </div>

            <div class="success mb-2">
                <%= request.getAttribute("successMsg") != null ? request.getAttribute("successMsg") : "" %>
            </div>

            <button type="submit" class="btn btn-success w-100">
                <i class="fa fa-check-circle"></i> Create Account
            </button>
        </form>

        <div class="text-center mt-3">
            <small>
                Go back to
                <a href="adminDashboard.jsp" class="fw-bold text-primary text-decoration-none">
                    Admin Dashboard
                </a>
            </small>
        </div>

    </div>
</div>

</div>

<script>
function validateSignup() {
    const name = document.getElementById("fullname").value.trim();
    const email = document.getElementById("email").value.trim();
    const role = document.getElementById("role").value;
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirmPassword").value;

    if (name === "" || email === "" || role === "" || password === "" || confirmPassword === "") {
        alert("All fields are required!");
        return false;
    }

    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
        alert("Enter a valid email address!");
        return false;
    }

    if (password.length < 6) {
        alert("Password must be at least 6 characters!");
        return false;
    }

    if (password !== confirmPassword) {
        alert("Passwords do not match!");
        return false;
    }
    return true;
}
</script>

</body>
</html>
