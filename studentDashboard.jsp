<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(session.getAttribute("username")==null){
    response.sendRedirect("login.jsp");
}
%>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    // Allow only logged-in students
    if (username == null || role == null || !role.equals("student")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Student Dashboard</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<style>
*{ box-sizing:border-box; }
body{
    margin:0;
    font-family:"Segoe UI",Tahoma,sans-serif;
    background:#f4f6ff;
    min-height:100vh;
}

/* Layout */
.wrapper{
    display:flex;
    min-height:100vh;
}

/* Sidebar */
.sidebar{
    width:220px;
    background:#4338ca;
    color:white;
    padding:20px;
}
.sidebar h2{
    text-align:center;
    margin-bottom:30px;
}
.sidebar a{
    display:block;
    padding:12px 15px;
    color:white;
    text-decoration:none;
    border-radius:8px;
    margin-bottom:10px;
    transition:0.3s;
}
.sidebar a:hover,
.sidebar a.active{
    background:#3730a3;
}

/* Main content */
.main{
    flex:1;
    padding:30px;
}

/* Header */
.header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:20px;
}
.header h2{
    color:#4338ca;
}

/* Cards */
.card-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
    gap:20px;
}
.card{
    background:white;
    padding:25px;
    border-radius:12px;
    box-shadow:0 10px 25px rgba(0,0,0,0.15);
    text-align:center;
    cursor:pointer;
    transition:transform 0.3s, box-shadow 0.3s;
}
.card:hover{
    transform:translateY(-5px);
    box-shadow:0 15px 30px rgba(0,0,0,0.3);
}
.card h3{
    margin:12px 0;
    color:#4338ca;
}
.card p{
    color:#555;
    font-size:14px;
}

/* Logout Button */
.logout-btn{
    background:#dc3545;
    color:white;
    border:none;
    padding:8px 16px;
    border-radius:6px;
    cursor:pointer;
}
.logout-btn:hover{
    background:#b02a37;
}

/* Footer */
footer{
    text-align:center;
    padding:15px;
    color:#555;
    font-size:14px;
    margin-top:30px;
}
</style>
</head>

<body>

<div class="wrapper">

    <!-- Sidebar -->
    <div class="sidebar">
        <h2>👨‍🎓 Student</h2>
        <a href="studentDashboard.jsp" class="active"><i class="fa fa-home"></i> Dashboard</a>
        <a href="ProfileStudent"><i class="fa fa-user"></i> Profile</a>
        <a href="ProfileAttendance"><i class="fa fa-calendar-check"></i> Attendance</a>
        <a href="ProfileMarks"><i class="fa fa-pen"></i> Marks</a>
        <a href="ReportStudent"><i class="fa fa-file-download"></i> Download Report</a>
        <form action="LogoutServlet" method="post" style="margin-top:20px;">
            <button type="submit" class="logout-btn"><i class="fa fa-sign-out-alt"></i> Logout</button>
        </form>
    </div>

    <!-- Main -->
    <div class="main">
        <div class="header">
            <h2>Welcome, <%= username %> 👋</h2>
        </div>

        <div class="card-grid">
            <div class="card" onclick="location.href='ProfileStudent'">
                <h3><i class="fa fa-user"></i> View Profile</h3>
                <p>See your personal details</p>
            </div>

            <div class="card" onclick="location.href='ProfileAttendance'">
                <h3><i class="fa fa-calendar-check"></i> Check Attendance</h3>
                <p>View your attendance record</p>
            </div>

            <div class="card" onclick="location.href='ProfileMarks'">
                <h3><i class="fa fa-pen"></i> View Marks</h3>
                <p>Check subject-wise marks</p>
            </div>

            <div class="card" onclick="location.href='ReportStudent'">
                <h3><i class="fa fa-file-download"></i> Download Report</h3>
                <p>Download academic report</p>
            </div>
        </div>
    </div>

</div>

<footer>
    © 2026 Student Management System
</footer>

</body>
</html>
